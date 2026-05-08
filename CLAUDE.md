# CLAUDE.md

> **AI Context**: This file provides guidance to Claude Code (claude.ai/code) when working with this repository. Follow these instructions precisely.

## Read This First

1. Start with this file for operational rules.
2. Use `docs/ai-context/` for concise per-topic references.
3. Use `docs/guides/` + `docs/rules/` as source-of-truth details when conflicts arise.

## Project Overview

Flutter starter template using:
- **Flutter 3.32.0** (managed via FVM)
- **State Management**: BLoC pattern
- **Navigation**: auto_route
- **DI**: GetIt
- **Architecture**: Three-layer with strict dependency rules

**Local Packages:**
- `starter_toolkit`: Common utilities and configurations
- `starter_uikit`: Reusable UI components and theme system
- `starter_lints`: Custom lint rules for code consistency

---

## Quick Reference

### Essential Commands

**Development:**
```bash
fvm flutter pub get                                              # Install dependencies
fvm flutter run                                                   # Run app
fvm flutter pub run build_runner build --delete-conflicting-outputs  # Generate code
fvm flutter analyze                                              # Run analyzer
fvm dart run custom_lint --no-fatal-infos --no-fatal-warnings   # Run custom lints
fvm dart run custom_lint                                         # Strict custom lints (fatal warnings/infos)
```

**Testing:**
```bash
fvm flutter test                                                 # Run all tests
fvm flutter test --coverage                                      # Run with coverage
```

**Code Generation:**
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs  # Routes, JSON, Freezed
dart run utils/generators/generate_exception_mapper.dart                     # Exception mapper methods
fvm flutter --no-color pub global run intl_utils:generate        # Localization
```

### Localization

- **Tool**: `intl_utils` (flutter_intl)
- **Main locale**: English (`en`)
- **Class name**: `Localizer` (main app), `ToolkitLocalizer` (toolkit), `UikitLocalizer` (uikit)
- **ARB location**: `lib/l10n/intl_en.arb` (main), `intl_ru.arb` (optional)
- **Generate**: `fvm flutter --no-color pub global run intl_utils:generate` after modifying ARB files

**AI Instruction**: ALL user-facing strings must use `Localizer.of(context)` - no hardcoded strings.

### Code Generation Triggers

- **build_runner**: After modifying router configs, JSON models, Freezed models (including BLoC events/states)
- **generate_exception_mapper.dart**: After adding/modifying AppException classes
- **intl_utils**: After modifying ARB files

**Note**: BLoC events and states use Freezed with `@freezed` annotation. Run `build_runner` after modifying any BLoC event/state classes.

---

## Architecture Summary

### Layer Structure

```
Presentation (UI, BLoC) → Domain (Repository, Abstract DS) → Data (DS Impl, ApiClient)
```

### Key Principles

1. **Dependency Inversion**: Abstract DataSources enable flexible implementations
2. **Concrete Repositories**: Repositories are concrete (not abstract) - just facades
3. **No Flutter in Data/Domain**: Only Presentation layer imports Flutter
4. **Dependency Injection**: All dependencies via GetIt modules
5. **Two-Layer Exceptions**: Domain exceptions + UI models (with localization)
6. **Decorator Pattern**: Repository executors and exception mappers use decorators

### Exception Handling

**Two-layer architecture:**
- **Data Layer**: `AppException` - Sealed classes with `@ExceptionUiConfig`
- **UI Layer**: `ExceptionUiModel` - Equatable with localized messages

**Usage:**
```dart
// BLoC stores domain exception
try {
  final data = await _repository.getData();

  return emit(MyState.success(data));
} on AppException catch (e) {
  return emit(MyState.failure(e));
}

// UI handles failure state with Freezed pattern matching
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) => state.maybeMap(
    success: (successState) => SuccessView(data: successState.data),
    failure: (failureState) => FailureWidgetLarge(
      exception: failureState.exception,
      onRetry: _retry,
    ),
    orElse: () => const CustomCircularProgressIndicator(),
  ),
)
```

**Adding new exceptions:**
1. Add sealed class extending `AppException` with `@ExceptionUiConfig`
2. Run `dart run utils/generators/generate_exception_mapper.dart`
3. Generator updates mapper and decorator automatically

### Repository Executors

**Decorator pattern for cross-cutting concerns:**
```dart
final executor = RawRepositoryExecutor()
  .withErrorHandling()  // Converts exceptions to AppException
  .withRetry()          // Automatic retry with exponential backoff
  .withCaching();       // Time-based caching with cleanup
```

---

## Project Structure

### Feature Layout

```
lib/features/{feature}/
├── data/           # DataSource implementations (remote, local, mock)
├── domain/         # Repository (concrete) + abstract DataSource interface
├── model/          # Domain models
├── configs/        # DI module (extends AppModule)
└── ui/             # BLoC, screens, widgets
```

### UI Organization

**Simple features**: Flat `bloc/`, `screen/`, `widget/`

**Complex features**: Subdivided by flow (list/, details/, operation/)

---

## Testing Requirements

### Current Status (May 2026)

- **145 tests passing** (100% pass rate)
- **Unit Tests**: 111 tests (BLoC, repositories, data sources)
- **Integration Tests**: 34 tests (full-stack flows for all features)

### Test Structure

**AI Instruction**: All tests organized under `test/features/{feature}/`

```
test/features/{feature}/
├── assets/          # JSON test data files
├── model/           # Mock model helpers (use fromJson)
├── data/            # Repository and DataSource unit tests
├── bloc/            # BLoC unit tests
└── integration/     # Full-stack integration tests
```

### Testing Strategy

1. **Data Layer Unit Tests** - Repository + DataSource with mocked dependencies
2. **BLoC Unit Tests** - Test all events (success, empty, failure)
3. **Integration Tests** - Full flow with only ApiClient mocked

**AI Instruction**: ALWAYS use JSON files with fromJson instead of creating mocks in code.

### Mocktail Fallback Values

**AI Instruction**: Integration tests require fallback value registration for types used in `any(named:)` matchers:

```dart
// Required for ApiClient mocking
setUpAll(() {
  registerFallbackValue(HttpMethod.get);
  registerFallbackValue(_fakeFromJson);  // Function matching signature
});

User _fakeFromJson(Map<String, dynamic> json) => User.fromJson(json);
```

**Common issue**: `MissingStubError` when using `any(named: 'method')` or `any(named: 'fromJson')` without registering fallbacks.

### Tests with Retry Logic

**AI Instruction**: Match `wait` to the retry configuration used in that test.

- If using production-like retries (`retryDelay: 2s`, `maxRetries: 3`), use longer waits (around 8s).
- If using test retries (`retryDelay: 10ms`), keep waits short (around 300ms).

---

## Code Style

### Key Rules

- **Trailing commas**: Required
- **Quotes**: Single quotes preferred
- **Imports**: Package imports only (no relative imports in lib/)
- **Widgets**: Never use functions that return widgets - extract to widget classes
- **Class Size**: Keep < 100 lines; split if > 200 lines
- **BLoC Separation**: BLoCs must NOT depend on other BLoCs - use UI layer for coordination
- **Arrow Syntax**: Always use `=>`, except: `build()` method and nested callbacks like `() => setState(() {})`
- **Spread in Collections**: Always use `if (cond) ...[Widget()]` even for single widget

### BLoC Formatting Rules

**AI Instruction**: ALL BLoC event handlers must follow these rules:

1. **Return emit pattern**: Always `return emit(state)` for final emit
2. **Whitespace separation**: Add blank line before every `emit()` call
3. **Variable naming**: Use descriptive names (`successState`) not `s`
4. **Helper methods**: Add `isLoading` getters using `this is _LoadingMyState`
5. **Freezed for BLoC**: Use `@freezed` annotation for all BLoC events and states

**Correct Example:**
```dart
Future<void> _onRequested(
  _RequestedMyEvent event,
  Emitter<MyState> emit,
) async {
  emit(const MyState.loading());

  try {
    final data = await _repository.getData();

    return emit(MyState.success(data));
  } on AppException catch (e) {
    return emit(MyState.failure(e));
  }
}

// State helper (inside Freezed class with const MyState._();)
bool get isLoading => this is _LoadingMyState;
```

### Comments and Documentation

**IMPORTANT**: Write self-documenting code. Minimize inline comments.

- ✅ Public classes in shared modules: 1-3 line `///` summary
- ✅ Public methods if needed: Brief description
- ❌ Do NOT comment obvious code

---

## Reusing Toolkit and UIKit

**AI Instruction**: ALWAYS check toolkit/uikit before implementing new functionality.

### starter_toolkit

**Available:**
- `DateTimeHelpers` extension: `isToday`, `isTomorrow`, `isSameDay`
- Date formatting: `getLocalizedDateLabel()`, `getFormattedTimeRange()`
- Validators: Phone, email, password, URL
- Exception handling: `AppException` hierarchy

### starter_uikit

**Available:**
- **Status Widgets**: `EmptyInformationBody`, `FailureWidgetLarge`, `FailureWidgetSmall`, `CustomCircularProgressIndicator`
- **Notifications**: `NotificationSnackBar`
- **Theme**: `AppTheme`, `AppTextStyles`, `ThemeProvider`
- **AppBars**: `TitleAppBar`, `BaseAppBar`, `TransparentAppBar`
- **Forms**: `AppTextField`, `AppDropdownField`, `AppCheckbox`, `AppDatePickerField`
- **Buttons**: `AppElevatedButton`, `AppOutlinedButton`

**AI Instruction - Import Strategy:**
- **Recommended**: Import specific files (e.g., `widgets/app_bar/title_app_bar.dart`)
- **Barrel export** (`starter_uikit.dart`): Only for status widgets used together
- Specific imports reduce compilation time and make dependencies explicit

**Import Examples:**
```dart
// Status widgets (barrel export)
import 'package:starter_uikit/starter_uikit.dart';

// Other widgets - explicit imports (recommended)
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
```

**Usage:**
```dart
// ✓ Correct - Use uikit widgets with Freezed pattern matching
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) => state.maybeMap(
    success: (successState) {
      if (successState.data.isEmpty) {
        return EmptyInformationBody(text: Localizer.of(context).noData);
      }
      return SuccessView(data: successState.data);
    },
    failure: (failureState) => FailureWidgetLarge(
      exception: failureState.exception,
      onRetry: _retry,
    ),
    orElse: () => const CustomCircularProgressIndicator(),
  ),
)

// ✗ Wrong - Manual implementation
orElse: () => const Center(child: CircularProgressIndicator()),
```

**Theme Usage:**
```dart
// ✓ Correct - Use ThemeProvider
final theme = ThemeProvider.of(context).theme;
final textStyles = ThemeProvider.of(context).textStyles;

Text('Hello', style: textStyles.mediumBody14)

// ✗ Wrong - Hard-coded styles
Text('Hello', style: TextStyle(fontSize: 14))
```

---

## Important Instructions

**AI Instruction**: Follow these rules strictly:

1. **Read Documentation First**: Check docs for AI Instructions before coding
2. **Reuse Before Creating**: Check toolkit/uikit before implementing new widgets
3. **Localization Required**: ALL user-facing strings use `Localizer.of(context)`
4. **Theme Awareness**: ALL colors/styles use `ThemeProvider`
5. **Form Widgets**: Use uikit widgets, never FormBuilder directly
6. **Single Responsibility**: Extract widgets when class > 100 lines
7. **No Useless Comments**: Only `///` doc comments for public APIs
8. **Descriptive Names**: Never use `s` for state - use `successState`, `failureState`
9. **State Helpers**: Add getters instead of verbose pattern matching in multiple places
10. **Async Context**: Use `if (!mounted) return` after async operations
11. **Dependency Sorting**: SDK dependencies first, then alphabetical
12. **BLoC Independence**: BLoCs must NOT inject other BLoCs - coordinate via UI layer
13. **Arrow vs Block**: Always use `=>`, except `build()` and nested callbacks `() => setState(() {})`
14. **Always Spread**: Use `if (cond) ...[Widget()]` in collections, even for single widget
15. **Freezed for BLoC**: Use `@freezed` for all BLoC events and states with factory constructors
16. **Freezed Pattern Matching**: Use `.when()`, `.maybeMap()`, or `.mapOrNull()` for state handling in UI

**File Creation:**
- **NEVER** create files unless absolutely necessary
- **ALWAYS** prefer editing existing files
- **NEVER** proactively create documentation files unless requested

---

## BLoC State Patterns

**AI Instruction**: Follow these patterns for better state management. Use Freezed for all BLoC events and states.

### Why Freezed for BLoC?

- **Automatic equality**: Freezed generates `==` and `hashCode` for proper state comparison
- **Pattern matching**: Use `.when()`, `.maybeMap()`, `.mapOrNull()` for exhaustive/partial matching
- **copyWith**: Auto-generated for states with multiple fields
- **Consistent codebase**: All BLoCs follow the same Freezed pattern

### Standard State Pattern

For simple states without persistent data:

```dart
// Events - Freezed with factory constructors
@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submitted(LoginForm form) = _SubmittedLoginEvent;
}

// States - Freezed with factory constructors
@freezed
class LoginState with _$LoginState {
  const LoginState._();  // Required for custom getters

  const factory LoginState.initial() = _InitialLoginState;
  const factory LoginState.loading() = _LoadingLoginState;
  const factory LoginState.success() = _SuccessLoginState;
  const factory LoginState.failure(AppException exception) = _FailureLoginState;

  bool get isLoading => this is _LoadingLoginState;
}

// Usage in UI with Freezed pattern matching
BlocListener<LoginBloc, LoginState>(
  listener: (context, state) => state.mapOrNull(
    failure: (state) => NotificationSnackBar.showExceptionMessage(
      context,
      exception: state.exception,
    ),
  ),
  // ...
)

// In BlocBuilder with maybeMap
builder: (context, state) => state.maybeMap(
  success: (_) => const SuccessView(),
  failure: (failureState) => FailureView(failureState.exception),
  orElse: () => const LoadingView(),
)
```

### Nested Status Pattern

For states with persistent data across status changes:

```dart
// Status (nested Freezed for calendar content)
@freezed
class CalendarStatus with _$CalendarStatus {
  const factory CalendarStatus.initial() = _InitialCalendarStatus;
  const factory CalendarStatus.loading() = _LoadingCalendarStatus;
  const factory CalendarStatus.success({required List<Task> tasks}) = _SuccessCalendarStatus;
  const factory CalendarStatus.failure({required AppException exception}) = _FailureCalendarStatus;
}

// State with Freezed (auto copyWith)
@freezed
class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    required DateTime selectedDate,
    required CalendarStatus status,
  }) = _CalendarState;

  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const CalendarStatus.initial(),
  );

  bool get isLoading => status is _LoadingCalendarStatus;
}

// Usage in UI with Freezed .when()
Widget _buildStatusContent(CalendarStatus status, Localizer localizer) =>
  status.when(
    initial: () => EmptyInformationBody(text: localizer.selectDate),
    loading: () => const CustomCircularProgressIndicator(),
    success: (tasks) {
      if (tasks.isEmpty) {
        return EmptyInformationBody(text: localizer.noTasksForDate);
      }
      return TasksTimelineList(tasks: tasks);
    },
    failure: (exception) => FailureWidgetLarge(
      exception: exception,
      onRetry: _retry,
    ),
  );

// Access persistent data (copyWith auto-generated by Freezed)
CalendarPicker(selectedDate: state.selectedDate)
```

### Refreshed Event Pattern

Add `.refreshed()` event to avoid extracting state data for reload:

```dart
// Events with Freezed
@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.dateSelected(DateTime date) = _DateSelectedCalendarEvent;
  const factory CalendarEvent.refreshed() = _RefreshedCalendarEvent;  // ✓ Add this
}

// ✓ Clean usage
context.read<CalendarBloc>().add(const CalendarEvent.refreshed());

// ✗ Wrong - extracting state
final date = state.selectedDate;
context.read<CalendarBloc>().add(CalendarEvent.dateSelected(date));
```

---

## Common Issues & Solutions

**AI Instruction**: Reference this section when encountering these issues.

### Analyzer Errors

1. **"Dependencies not sorted alphabetically"**
   - Sort pubspec.yaml: SDK dependencies first, then alphabetical

2. **"use_build_context_synchronously"**
   - Add `if (!mounted) return` after async operations

3. **"omit_local_variable_types"**
   - Use `var` instead of explicit types for locals

### Testing Issues

1. **MissingStubError in integration tests**
   - Register fallback values for custom types in `setUpAll()`
   - Required for `HttpMethod` and function types used in `any(named:)`

2. **Tests timeout with retry logic**
   - Set `wait` based on retry settings used in the test
   - Example: `2s × 3 retries` needs around `8s`; `10ms × 3` needs around `300ms`

### Import Issues

- Status widgets: `import 'package:starter_uikit/starter_uikit.dart'`
- Other widgets: Import specific files directly
- Always import `NotificationSnackBar` explicitly

### Repository Executor Issues

1. **Old executor imports**
   - ✗ `DefaultRepositoryExecutor`, `RetriableRepositoryExecutor` deprecated
   - ✓ Use: `RawRepositoryExecutor().withErrorHandling().withRetry()`

2. **Missing error handling**
   - Always include `.withErrorHandling()` as first decorator

---

## Documentation

For detailed information, see:

**AI-tailored short references:** [docs/ai-context/](./docs/ai-context/)

**Full guides:**
- [Architecture Guide](./docs/guides/architecture.md) - Layered architecture, dependency inversion
- [BLoC & Freezed Guide](./docs/guides/freezed_bloc.md) - BLoC patterns
- [Code Review Guide](./docs/guides/code_review.md) - Severity-based review checklist
- [Estimation Guide](./docs/guides/estimation.md) - Story-point estimation method
- [Exception Handling](./docs/guides/exception_handling.md) - Custom exceptions, mappers, executors
- [Structure Guide](./docs/guides/structure.md) - File organization
- [Testing Guide](./docs/guides/testing.md) - Testing strategies

**Rules:**
- [Coding Rules](./docs/rules/coding_rules.md) - Consolidated rule set with lint mapping
- [BLoC File Rules](./docs/rules/bloc.md) - File layout & basic flow
- [Code Formatting](./docs/rules/code_formatting.md) - Code style rules
- [Git Workflow](./docs/rules/git_workflow.md) - Branch / commit / PR naming
- [Naming Conventions](./docs/rules/naming.md) - Naming patterns

---

**Last Updated**: May 2026
