# Starter Toolkit

Shared data-layer code and utilities for Flutter applications: HTTP client, exceptions, repository executors, mock helpers, form validation, formatting and platform helpers. It contains no widgets (some helpers take a `BuildContext` for localization).

## Features

### Data Layer
- **API Client**: Abstract HTTP client interface with response type-based methods
- **Exception Handling**: Sealed class exception system with UI configuration annotations
- **Repository Executors**: Decorator pattern for cross-cutting concerns (retry, error handling); `RepositoryCache` collaborator for keyed TTL caching
- **Interceptors**: Authentication refresh (`AuthRefreshInterceptor`) and error mapping (`AppErrorInterceptor`) for Dio
- **Mock Helpers**: `MockNetworkBehavior` — shared latency and random failures for `Mock*DataSource` twins

### Utilities
- **Date/Time Helpers**: Extensions and functions for date manipulation and formatting
- **Form Validation**: Reusable validators for common input types
- **Form Formatters**: Input formatters for masks and special characters
- **String Functions**: Capitalize, formatting, and string manipulation utilities
- **Converters**: Type converters for JSON serialization (money, primitives)
- **Misc**: `Debouncer`, `SemanticVersion`

### BLoC Utilities
- **BlocLoadState**: Enum for tracking loading states
- **PaginatedData**: Helper for paginated list management
- **RefreshableBloc**: Mixin that drives pull-to-refresh indicators

### Platform Helpers
- **File Upload**: Builds Dio `FormData` for picked images
- **Screenshot**: Widget screenshot capture (`RepaintBoundary` + `GlobalKey`)
- **Permission Dialogs**: Permission request helpers with a rationale dialog
- **URL Launcher**: Phone, messenger, store and web launching that throws `UrlLaunchFailedException`
- **Crash Reporting**: `CrashReporter` interface with a Firebase Crashlytics implementation

### Models
- **TitleItem**: Common title/value pair model
- **PaginatedListItems**: Generic paginated list wrapper

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  starter_toolkit:
    path: ../packages/starter_toolkit
```

## Usage

### Exception Handling

Define domain exceptions with UI configuration:

```dart
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

// Use predefined exceptions
throw const NoInternetException();
throw const ServerException(statusCode: 502, message: 'Bad gateway');
throw const UnauthorizedException();

// Create from Dio response (401 / 403 / 500 map to their own types,
// everything else becomes ServerException)
final exception = AppException.fromDioResponse(
  statusCode: response.statusCode,
  response: response,
);
```

**Available exceptions** (`AppException` is a sealed class; every subtype has `name` and `canRetry`):
- `NoInternetException` - Network connectivity issues
- `ServerException` - Any other HTTP error (`statusCode`, optional `message`)
- `UnauthorizedException` - Authentication required (401)
- `ForbiddenException` - Insufficient permissions (403)
- `InternalServerErrorException` - Backend failure (500)
- `UnknownException` - Unexpected error (`error`, `stackTrace`); not retryable, since retrying a bug only repeats it
- `DevelopmentException` - Programming error, never shown in detail
- `UrlLaunchFailedException` - A URL could not be opened

`toString()` prints the type name with its payload (e.g. `Server(statusCode: 502, message: Bad gateway)`, `Unknown(<error>)`), so logs show the cause. `AppErrorInterceptor` likewise copies the original Dio error text into `DioException.message` when it replaces `error` with an `AppException`.

```dart
dio.interceptors.add(const AppErrorInterceptor());
```

### Repository Executors

Repositories declare their resilience needs as `RepositoryExecutor`
constructor params (one per distinct behavior). Executor chains are composed
**only** in the repository's DI registration closure, from a single local
`base` — repositories never import the extensions or call `withX()`.

```dart
class TaskRepository {
  const TaskRepository({
    required RepositoryExecutor executor,
    required RepositoryExecutor creationExecutor,
    required TaskDataSource dataSource,
  })  : _executor = executor,
        _creationExecutor = creationExecutor,
        _dataSource = dataSource;

  final RepositoryExecutor _executor;          // baseline
  final RepositoryExecutor _creationExecutor;  // retry-heavy writes
  final TaskDataSource _dataSource;

  Future<List<Task>> getTasks() =>
      _executor.execute(_dataSource.getTasks);

  Future<Task> createTask(TaskCreateRequest request) =>
      _creationExecutor.execute(() => _dataSource.createTask(request));
}
```

```dart
// task_module.dart — still ONE registration; one local base.
..registerFactory(() {
  final base = const RawRepositoryExecutor().withErrorHandling();

  return TaskRepository(
    executor: base,
    creationExecutor: base.withRetry(
      maxAttempts: 5,
      retryDelay: const Duration(seconds: 1),
    ),
    dataSource: getIt<TaskDataSource>(),
  );
})
```

Single-executor repositories keep a plain positional signature — only switch
to named params when a second behavior appears. See the full walkthrough
(usage, adding executors, testing) in
[docs/guides/repository_executor.md](../../docs/guides/repository_executor.md).

**Available executors:**
- `RawRepositoryExecutor` - Base executor, no additional behavior
- `ErrorHandlingExecutor` - Converts Dio errors to `AppException`; unexpected errors become `DevelopmentException` in release (rethrown as-is in debug); always innermost
- `RetryExecutor` - Automatic retry with linear backoff (`maxAttempts` total calls)

**Available collaborators:**
- `RepositoryCache` / `InMemoryRepositoryCache` - Keyed TTL cache; injected as a
  sibling dependency (not a decorator), registered as an app-wide singleton

**Retry configuration:**
- Default: 3 attempts in total (`maxAttempts`) with a 2-second base delay
- Linear backoff: after failed attempt *n* (counting from 1) it waits `retryDelay * n`
- Default timeline: attempt, wait 2s, attempt, wait 4s, final attempt (errors with `canRetry == false` are rethrown immediately)

### API Client

Abstract client for type-safe HTTP operations:

```dart
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class UserApiDataSource {
  const UserApiDataSource(this._client);

  final ApiClient _client;

  Future<User> getUser(String id) {
    return _client.requestJson<User>(
      method: HttpMethod.get,
      path: '/users/$id',
      fromJson: User.fromJson,
    );
  }

  Future<List<User>> getUsers() {
    return _client.requestJsonList<User>(
      method: HttpMethod.get,
      path: '/users',
      fromJson: User.fromJson,
    );
  }

  Future<void> deleteUser(String id) {
    return _client.requestVoid(
      method: HttpMethod.delete,
      path: '/users/$id',
    );
  }

  Future<List<int>> downloadAvatar(String userId) {
    return _client.requestBytes(
      method: HttpMethod.get,
      path: '/users/$userId/avatar',
    );
  }
}
```

Other response types: `requestPlainText` (`String`) and `requestStream` (`Stream<List<int>>`). Every method also accepts `body`, `queryParameters` and `headers`; `DioApiClient` is the Dio-backed implementation.

**HTTP Methods:**
- `HttpMethod.get`
- `HttpMethod.post`
- `HttpMethod.put`
- `HttpMethod.patch`
- `HttpMethod.delete`

### Mock Network Behavior

One shared source of latency and random failures for every `Mock*DataSource`, so mock builds feel like a real backend on every screen:

```dart
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';

class MockTaskDataSource implements TaskDataSource {
  const MockTaskDataSource(this._network);

  final MockNetworkBehavior _network;

  @override
  Future<List<Task>> getTasks() async {
    await _network.simulate();   // wait, then fail at `failureRate`

    return _tasks;
  }
}

// Register once (defaults: 500 ms wait, 5% failure rate)
getIt.registerSingleton<MockNetworkBehavior>(const MockNetworkBehavior());

// Tests: no wait, never fails
const MockNetworkBehavior.instant();
```

- `simulate()` waits `wait`, then throws `InternalServerErrorException` with probability `failureRate`.
- `delay()` only waits — use it in twins that also serve non-mock builds and must never fail at random.
- `chance(rate)` varies a response shape (e.g. an occasional empty list); inject `random` for deterministic tests.

### Crash Reporting

`CrashReporter` keeps Firebase out of everything below `main.dart`. The global `crashReporter` defaults to `NoopCrashReporter`, so tests and pre-bootstrap code never touch Firebase; swap it once Firebase initializes:

```dart
import 'package:starter_toolkit/utils/crash/crash_reporter.dart' as crash;

await Firebase.initializeApp();
crash.crashReporter = const crash.FirebaseCrashReporter();

// Anywhere later
await crash.crashReporter.recordError(error, stackTrace, reason: 'sync failed');
```

### Date/Time Extensions

```dart
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

final date = DateTime.now();

// Check date properties
if (date.isToday) { ... }
if (date.isTomorrow) { ... }
if (date.isSameDay(otherDate)) { ... }

// Get date boundaries
final startOfDay = date.startOfDay;      // DateTime(2025, 11, 21, 0, 0, 0)
final endOfDay = date.endOfDay;          // DateTime(2025, 11, 21, 23, 59, 59)
final startOfMonth = date.startOfMonth;  // DateTime(2025, 11, 1)
final startOfWeek = date.startOfWeek;    // Monday of current week
final onlyDay = date.onlyDay;            // DateTime(2025, 11, 21)
```

### Date Formatting Functions

```dart
import 'package:starter_toolkit/utils/date/date_time_functions.dart';

// Get localized date label
final label = getLocalizedDateLabel(context, DateTime.now());
// Returns: "Today", "Yesterday", or a "d MMMM" date

// Format time range
final timeRange = getFormattedTimeRange(
  DateTime(2025, 11, 21, 9, 0),
  DateTime(2025, 11, 21, 17, 30),
);
```

More range formatters live in `package:starter_toolkit/utils/functions/format_time_range.dart` (`formatDateRange`, `formatTimeRange`, `formatTimeRangeAndDay`).

### Form Validators

```dart
import 'package:starter_toolkit/utils/form/form_validators.dart';

FormBuilderTextField(
  name: 'email',
  validator: FormValidators.required(context),
)

FormBuilderTextField(
  name: 'phone',
  validator: FormValidators.phone(context),
)

FormBuilderTextField(
  name: 'website',
  validator: FormValidators.url(context),
)
```

Also available: `email`, `passwordMinLength`, `phonePattern`. Every validator takes an optional `message` and (except `required`) passes empty values, so combine with `required` to forbid them.

Validate a whole `FormBuilder` and scroll to the first invalid field with `saveAndValidateForm(formKey)` (`utils/form/save_and_validate_form.dart`); in an app use `AppForm` from `starter_uikit`, which wraps it and validates on edit after the first submit; for single-field screens use `ValidatableTextEditingController` with `validateAll`.

### Form Input Formatters

```dart
import 'package:starter_toolkit/utils/form/form_input_formatters.dart';

TextField(
  inputFormatters: [
    FormInputFormatters.phoneShortMask,  // (###) ###-##-##
    FormInputFormatters.phoneMaxLength,
  ],
)
```

### BLoC Load State

```dart
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';

@freezed
class MyState with _$MyState {
  const factory MyState({
    required BlocLoadState loadState,
    List<Item>? items,
  }) = _MyState;

  const MyState._();

  bool get isLoading => loadState.isLoading;
}

// Usage in BLoC
emit(state.copyWith(loadState: BlocLoadState.loading));
emit(state.copyWith(loadState: BlocLoadState.loaded, items: items));
```

### File Upload Helper

```dart
import 'package:starter_toolkit/utils/helpers/file_upload_helper.dart';

// Wrap a picked image (image_picker `XFile`) as multipart form data
final formData = await FileUploadHelper.createImageFormData(xFile);

// Several images, each sent under the `file` field
final multiple = await FileUploadHelper.createMultipleImagesFormData(xFiles);
```

### Screenshot Helper

```dart
import 'package:starter_toolkit/utils/helpers/app_screenshot_helper.dart';

final helper = AppScreenshotHelper();

// Capture widget screenshot
// `globalKey` must belong to a RepaintBoundary; returns PNG bytes or null
final bytes = await helper.captureScreenshot(
  globalKey,
  context: context,
);
```

### URL Launcher Helper

```dart
import 'package:starter_toolkit/utils/helpers/url_launcher_helper.dart';

// Throws UrlLaunchFailedException when the platform cannot open the URL
await UrlLauncherHelper.launchWebUrl('https://example.com');
await UrlLauncherHelper.launchWebUrl('https://example.com', useExternalBrowser: true);

await UrlLauncherHelper.launchPhone('+1234567890');
await UrlLauncherHelper.launchSms('+1234567890');
```

Also: `launchWhatsapp`, `launchTelegram`, `launchMessenger`, `launchStore`.

### String Formatting

```dart
import 'package:starter_toolkit/utils/functions/capitalize_first_letter.dart';
import 'package:starter_toolkit/utils/functions/string_formatting_functions.dart';

final text = 'hello world';
final capitalized = capitalizeFirstLetter(text);  // "Hello world"

// Strip display formatting from a phone number
final phone = cleanPhoneNumber('+7 (123) 456-78-90');  // "+71234567890"
final compact = removeSpaceAndSymbols('a b-c');         // "abc"
```

### Time Formatting

```dart
import 'package:starter_toolkit/utils/functions/format_duration.dart';
import 'package:starter_toolkit/utils/functions/format_hours_minutes_seconds.dart';

// Localized "Xh Ym" (hours dropped when under one hour)
final duration = Duration(hours: 2, minutes: 30);
final formatted = formatDuration(context, duration);

// Seconds remaining as a countdown string
final countdown = formatHoursMinutesSeconds(90);  // "01:30"
```

## Localization

The toolkit includes its own localization for error messages:

```dart
import 'package:starter_toolkit/l10n/generated/l10n.dart';

// Access localized strings
final errorMessage = ToolkitLocalizer.of(context).errorRequiredField;
final noConnection = ToolkitLocalizer.of(context).errorMessageNoConnection;
```

**Supported locales:**
- English (`en`) - Main locale
- Russian (`ru`)

## Architecture

### Exception System

Two-layer exception architecture:
- **Data Layer** (`starter_toolkit`): `AppException` - Pure domain exceptions (sealed classes)
- **UI Layer** (`starter_uikit`): `ExceptionUiModel` - Localized UI models

Use `@ExceptionUiConfig` annotation to configure UI presentation:

```dart
@ExceptionUiConfig(
  titleKey: 'errorMessageNoConnection',
  descriptionKey: 'errorMessageCouldNotConnectServer',
  snackbarKey: 'errorMessageNoConnection',
)
final class NoInternetException extends AppException {
  const NoInternetException();

  @override
  String get name => 'NoInternet';

  @override
  bool get canRetry => true;
}
```

**Adding new exceptions:**
1. Add a `final class` subtype of the sealed `AppException` with `@ExceptionUiConfig` (override `name` and `canRetry`)
2. Add its ARB keys and run `fvm flutter --no-color pub global run intl_utils:generate`
3. Run (from the repo root): `dart run utils/generators/generate_exception_mapper.dart` — it updates `ExceptionUiMapper` in `starter_uikit`

### Repository Executor Pattern

Decorator pattern for composable cross-cutting concerns, composed in DI
modules from a single local `base`:

```dart
// Base executor
final base = const RawRepositoryExecutor();

// Add error handling (always innermost)
final withErrors = base.withErrorHandling();

// Add retry logic
final withRetry = withErrors.withRetry(
  maxAttempts: 3,
  retryDelay: const Duration(seconds: 2),
);
```

Caching is a separate collaborator (`RepositoryCache`), not a decorator — see
[docs/guides/repository_executor.md](../../docs/guides/repository_executor.md).

### API Client Pattern

Response type-based methods instead of HTTP method-based:

```dart
// ✓ Clear intent - returns User object
final user = await client.requestJson<User>(...);

// ✓ Clear intent - returns void
await client.requestVoid(...);

// ✓ Clear intent - returns bytes
final bytes = await client.requestBytes(...);

// ✗ Old pattern - unclear what's returned
final response = await client.get(...);
```

## Development

### Code Generation

Generate Freezed models and JSON serialization:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

Generate exception mapper (from the repo root, after `AppException` changes):

```bash
dart run utils/generators/generate_exception_mapper.dart
```

Generate localization files:

```bash
fvm flutter --no-color pub global run intl_utils:generate
```

### Testing

Run tests:

```bash
fvm flutter test
```

Run with coverage:

```bash
fvm flutter test --coverage
```

## Dependencies

**Core:**
- `dio` - HTTP client
- `freezed_annotation` - Immutable models
- `equatable` - Value equality
- `collection` - Extended collections

**BLoC:**
- `flutter_bloc` - State management

**Forms:**
- `flutter_form_builder` - Form widgets
- `mask_text_input_formatter` - Input masks

**Platform:**
- `image_picker` - Image selection (`XFile` for upload helpers)
- `permission_handler` - Permission requests
- `url_launcher` - Open URLs
- `firebase_crashlytics` - `FirebaseCrashReporter`
- `http_parser` - Multipart content types

**Localization:**
- `intl` - Internationalization
- `intl_utils` - ARB file management

## Related Packages

- **starter_uikit**: UI components and theme system (depends on starter_toolkit)
- **request_logger**: In-app HTTP request logger (a Dio interceptor; independent of this package)

## License

Private package for internal use.
