# CLAUDE.md

> **AI Context**: This file provides guidance to Claude Code (claude.ai/code) when working with this repository. Follow these instructions precisely.

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
```

**Testing:**
```bash
fvm flutter test                                                 # Run all tests
fvm flutter test --coverage                                      # Run with coverage
```

**Code Generation:**
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs  # Routes, JSON, Freezed
dart run tool/generate_exception_mapper.dart                     # Exception mapper methods
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

- **build_runner**: After modifying router configs, JSON models, Freezed data models (NOT BLoC events/states)
- **generate_exception_mapper.dart**: After adding/modifying AppException classes
- **intl_utils**: After modifying ARB files

**Note**: BLoC events and states use native Dart 3 sealed classes (no code generation). Freezed is used only for data models that need `fromJson`/`toJson` and `copyWith`.

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
  return emit(SuccessMyState(data));
} on AppException catch (e) {
  return emit(FailureMyState(e));
}

// UI handles failure state with pattern matching
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) {
    if (state case FailureMyState(:final exception)) {
      return FailureWidgetLarge(
        exception: exception,
        onRetry: _retry,
      );
    }
    // ... other states
  },
)
```

**Adding new exceptions:**
1. Add sealed class extending `AppException` with `@ExceptionUiConfig`
2. Run `dart run tool/generate_exception_mapper.dart`
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

### Current Status (January 2025)

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

**AI Instruction**: Tests using `withRetry()` need longer wait times:

```dart
blocTest<UserBloc, UserState>(
  'handles network error through full stack',
  wait: const Duration(seconds: 8),  // Allow time for retries (3 × 2s delay)
  // ...
);
```

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
4. **Helper methods**: Add `isLoading` getters instead of `maybeMap` checks
5. **Native Dart 3 sealed classes**: Use native sealed classes for BLoC events/states (NOT Freezed)

**Correct Example:**
```dart
Future<void> _onRequested(
  RequestedMyEvent event,
  Emitter<MyState> emit,
) async {
  emit(const LoadingMyState());

  try {
    final data = await _repository.getData();

    return emit(SuccessMyState(data));
  } on AppException catch (e) {
    return emit(FailureMyState(e));
  }
}

// State helper
bool get isLoading => this is LoadingMyState;
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
// ✓ Correct - Use uikit widgets with Dart 3 pattern matching
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) => switch (state) {
    LoadingMyState() => const CustomCircularProgressIndicator(),
    EmptyMyState() => EmptyInformationBody(text: Localizer.of(context).noData),
    FailureMyState(:final exception) => FailureWidgetLarge(
      exception: exception,
      onRetry: _retry,
    ),
    SuccessMyState(:final data) => SuccessView(data: data),
  },
)

// ✗ Wrong - Manual implementation
LoadingMyState() => const Center(child: CircularProgressIndicator()),
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
15. **Native Dart 3 for BLoC**: Use native sealed classes for BLoC events/states - NOT Freezed
16. **Dart 3 Pattern Matching**: Use `switch` expressions and `if (state case Type)` instead of Freezed's `when`/`map`

**File Creation:**
- **NEVER** create files unless absolutely necessary
- **ALWAYS** prefer editing existing files
- **NEVER** proactively create documentation files unless requested

---

## BLoC State Patterns

**AI Instruction**: Follow these patterns for better state management. Use native Dart 3 sealed classes for BLoC events and states (NOT Freezed).

### Why Native Dart 3 Sealed Classes for BLoC?

- **Dart 3 pattern matching**: Native `switch` expressions and `if (state case Type)` replace Freezed's `when`/`map` methods
- **Simpler code**: No code generation required for BLoC events/states
- **Better IDE support**: Direct class names without private prefixes
- **Freezed for data models**: Continue using Freezed for domain models that need `fromJson`/`toJson` and `copyWith`

### Standard State Pattern

For simple states without persistent data:

```dart
// Events - sealed class hierarchy
sealed class LoginEvent {
  const LoginEvent();
}

final class SubmittedLoginEvent extends LoginEvent {
  const SubmittedLoginEvent(this.form);
  final LoginForm form;
}

// States - sealed class hierarchy
sealed class LoginState {
  const LoginState();
  bool get isLoading => this is LoadingLoginState;
}

final class InitialLoginState extends LoginState {
  const InitialLoginState();
}

final class LoadingLoginState extends LoginState {
  const LoadingLoginState();
}

final class SuccessLoginState extends LoginState {
  const SuccessLoginState();
}

final class FailureLoginState extends LoginState {
  const FailureLoginState(this.exception);
  final AppException exception;
}

// Usage in UI with Dart 3 pattern matching
BlocListener<LoginBloc, LoginState>(
  listener: (context, state) {
    if (state case FailureLoginState(:final exception)) {
      NotificationSnackBar.showExceptionMessage(context, exception: exception);
    }
  },
  // ...
)

// In BlocBuilder with switch expression
builder: (context, state) => switch (state) {
  SuccessLoginState() => SuccessView(),
  FailureLoginState(:final exception) => FailureView(exception),
  _ => LoadingView(),
}
```

### Nested Status Pattern

For states with persistent data across status changes:

```dart
// Status (nested state for calendar content)
sealed class CalendarStatus {
  const CalendarStatus();
  bool get isInitial => this is InitialCalendarStatus;
  bool get isLoading => this is LoadingCalendarStatus;
  bool get isSuccess => this is SuccessCalendarStatus;
  bool get isFailure => this is FailureCalendarStatus;
}

final class InitialCalendarStatus extends CalendarStatus {
  const InitialCalendarStatus();
}

final class LoadingCalendarStatus extends CalendarStatus {
  const LoadingCalendarStatus();
}

final class SuccessCalendarStatus extends CalendarStatus {
  const SuccessCalendarStatus({required this.tasks});
  final List<Task> tasks;
}

final class FailureCalendarStatus extends CalendarStatus {
  const FailureCalendarStatus({required this.exception});
  final AppException exception;
}

// State with manual copyWith (only when needed)
final class CalendarState {
  const CalendarState({
    required this.selectedDate,
    required this.status,
  });

  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const InitialCalendarStatus(),
  );

  final DateTime selectedDate;
  final CalendarStatus status;

  bool get isLoading => status is LoadingCalendarStatus;

  CalendarState copyWith({
    DateTime? selectedDate,
    CalendarStatus? status,
  }) => CalendarState(
    selectedDate: selectedDate ?? this.selectedDate,
    status: status ?? this.status,
  );
}

// Usage in UI with switch expression
Widget _buildStatusContent(CalendarStatus status, Localizer localizer) =>
  switch (status) {
    InitialCalendarStatus() => EmptyInformationBody(text: localizer.selectDate),
    LoadingCalendarStatus() => const CustomCircularProgressIndicator(),
    SuccessCalendarStatus(:final tasks) => tasks.isEmpty
        ? EmptyInformationBody(text: localizer.noTasksForDate)
        : TasksTimelineList(tasks: tasks),
    FailureCalendarStatus(:final exception) => FailureWidgetLarge(
        exception: exception,
        onRetry: _retry,
      ),
  };

// Access persistent data
CalendarPicker(selectedDate: state.selectedDate)
```

### Refreshed Event Pattern

Add `RefreshedXxxEvent` to avoid extracting state data for reload:

```dart
// Events
sealed class CalendarEvent {
  const CalendarEvent();
}

final class DateSelectedCalendarEvent extends CalendarEvent {
  const DateSelectedCalendarEvent(this.date);
  final DateTime date;
}

final class RefreshedCalendarEvent extends CalendarEvent {
  const RefreshedCalendarEvent();  // ✓ Add this
}

// ✓ Clean usage
context.read<CalendarBloc>().add(const RefreshedCalendarEvent());

// ✗ Wrong - extracting state
final date = state.selectedDate;
context.read<CalendarBloc>().add(DateSelectedCalendarEvent(date));
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
   - Add `wait: const Duration(seconds: 8)` to blocTest
   - Account for retry attempts × retry delay

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

- [Architecture Guide](./docs/architecture.md) - Layered architecture, dependency inversion
- [Exception Handling](./docs/exception_handling.md) - Custom exceptions, mappers, executors
- [Structure Guide](./docs/structure.md) - File organization
- [Code Formatting](./docs/code_formatting.md) - Code style rules
- [Testing Guide](./docs/testing.md) - Testing strategies
- [BLoC & Freezed Guide](./docs/bloc) - BLoC patterns

---

**Last Updated**: February 2026
