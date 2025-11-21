# Starter Toolkit

Pure Dart utilities and common functionality for Flutter applications. This package contains no Flutter UI dependencies and focuses on business logic, data layer utilities, and shared helpers.

## Features

### Data Layer
- **API Client**: Abstract HTTP client interface with response type-based methods
- **Exception Handling**: Sealed class exception system with UI configuration annotations
- **Repository Executors**: Decorator pattern for cross-cutting concerns (caching, retry, error handling)
- **Interceptors**: Authentication refresh and error handling for Dio

### Utilities
- **Date/Time Helpers**: Extensions and functions for date manipulation and formatting
- **Form Validation**: Reusable validators for common input types
- **Form Formatters**: Input formatters for masks and special characters
- **String Functions**: Capitalize, formatting, and string manipulation utilities
- **Converters**: Type converters for JSON serialization (money, primitives)

### BLoC Utilities
- **BlocLoadState**: Enum for tracking loading states
- **PaginatedData**: Helper for paginated list management

### Platform Helpers
- **File Upload**: Image picker integration
- **Screenshot**: App screenshot capture utilities
- **Permission Dialogs**: Permission request helpers
- **URL Launcher**: Safe URL launching with error handling

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
throw const ServerException(statusCode: 500, message: 'Server error');
throw const UnauthorizedException();

// Create from Dio response
final exception = AppException.fromDioResponse(
  statusCode: response.statusCode,
  response: response,
);
```

**Available exceptions:**
- `NoInternetException` - Network connectivity issues
- `ServerException` - Server errors (5xx)
- `UnauthorizedException` - Authentication required (401)
- `ForbiddenException` - Insufficient permissions (403)
- `NotFoundException` - Resource not found (404)
- `ValidationException` - Request validation errors (400)
- `UnexpectedErrorException` - Generic unexpected errors

### Repository Executors

Chain decorators for cross-cutting concerns:

```dart
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class UserRepository {
  UserRepository(this._dataSource) {
    _executor = const RawRepositoryExecutor()
      .withErrorHandling()  // Converts exceptions to AppException
      .withRetry(maxRetries: 3, retryDelay: Duration(seconds: 2))
      .withCaching();       // Time-based caching
  }

  late final RepositoryExecutor _executor;
  final UserDataSource _dataSource;

  Future<List<User>> getUsers() {
    return _executor.execute(() => _dataSource.getUsers());
  }

  Future<User> getUserById(String id) {
    return _executor.cached(
      key: 'user_$id',
      function: () => _dataSource.getUserById(id),
    );
  }
}
```

**Available executors:**
- `RawRepositoryExecutor` - Base executor, no additional behavior
- `ErrorHandlingExecutor` - Converts all exceptions to AppException
- `RetryExecutor` - Automatic retry with exponential backoff
- `CachingExecutor` - Time-based in-memory caching

**Retry configuration:**
- Default: 3 attempts with 2-second exponential backoff
- Delay formula: `retryDelay * (attempt + 1)`
- Example: 0s, 2s, 4s, 6s (total ~12s for 3 retries)

### API Client

Abstract client for type-safe HTTP operations:

```dart
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class UserRemoteDataSource {
  const UserRemoteDataSource(this._client);

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

**HTTP Methods:**
- `HttpMethod.get`
- `HttpMethod.post`
- `HttpMethod.put`
- `HttpMethod.patch`
- `HttpMethod.delete`

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
// Returns: "Today", "Tomorrow", or formatted date

// Format time range
final timeRange = getFormattedTimeRange(
  context,
  startTime: DateTime(2025, 11, 21, 9, 0),
  endTime: DateTime(2025, 11, 21, 17, 30),
);
// Returns: "09:00 - 17:30"
```

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

### Form Input Formatters

```dart
import 'package:starter_toolkit/utils/form/form_input_formatters.dart';

TextField(
  inputFormatters: [
    FormInputFormatters.phone(),  // Phone number mask
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

// Pick image from gallery
final file = await FileUploadHelper.pickImageFromGallery(context);

// Pick image from camera
final file = await FileUploadHelper.pickImageFromCamera(context);
```

### Screenshot Helper

```dart
import 'package:starter_toolkit/utils/helpers/app_screenshot_helper.dart';

final helper = AppScreenshotHelper();

// Capture widget screenshot
final bytes = await helper.captureScreenshot(
  globalKey,
  context: context,
);
```

### URL Launcher Helper

```dart
import 'package:starter_toolkit/utils/helpers/url_launcher_helper.dart';

// Launch URL with error handling
await UrlLauncherHelper.launchUrlString(context, 'https://example.com');

// Launch phone number
await UrlLauncherHelper.launchUrlString(context, 'tel:+1234567890');

// Launch email
await UrlLauncherHelper.launchUrlString(context, 'mailto:support@example.com');
```

### String Formatting

```dart
import 'package:starter_toolkit/utils/functions/capitalize_first_letter.dart';
import 'package:starter_toolkit/utils/functions/string_formatting_functions.dart';

final text = 'hello world';
final capitalized = capitalizeFirstLetter(text);  // "Hello world"

// Format phone number
final phone = formatPhoneNumber('+71234567890');  // "+7 (123) 456-78-90"
```

### Time Formatting

```dart
import 'package:starter_toolkit/utils/functions/format_duration.dart';
import 'package:starter_toolkit/utils/functions/format_hours_minutes_seconds.dart';

// Format duration
final duration = Duration(hours: 2, minutes: 30);
final formatted = formatDuration(duration);  // "2h 30m"

// Format time components
final time = formatHoursMinutesSeconds(hours: 1, minutes: 30);  // "01:30"
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
1. Create sealed class extending `AppException` with `@ExceptionUiConfig`
2. Run: `dart run tool/generate_exception_mapper.dart`
3. Code generator automatically updates mapper and decorator

### Repository Executor Pattern

Decorator pattern for composable cross-cutting concerns:

```dart
// Base executor
final executor = RawRepositoryExecutor();

// Add error handling
final withErrors = executor.withErrorHandling();

// Add retry logic
final withRetry = withErrors.withRetry(
  maxRetries: 3,
  retryDelay: Duration(seconds: 2),
);

// Add caching
final withCaching = withRetry.withCaching(
  duration: Duration(minutes: 5),
);
```

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

Generate exception mapper:

```bash
dart run tool/generate_exception_mapper.dart
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
- `image_picker` - Image selection
- `permission_handler` - Permission requests
- `url_launcher` - Open URLs

**Localization:**
- `intl` - Internationalization
- `intl_utils` - ARB file management

## Related Packages

- **starter_uikit**: UI components and theme system (depends on starter_toolkit)

## License

Private package for internal use.
