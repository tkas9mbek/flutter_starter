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
genhtml coverage/lcov.info -o coverage/html                      # Generate coverage report
open coverage/html/index.html                                    # View coverage
```

**Code Generation:**
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs  # Routes, JSON, Freezed
fvm flutter pub run spider build                                 # Asset references
fvm flutter pub run flutter_launcher_icons                       # Launcher icons
fvm flutter pub run flutter_native_splash:create                 # Splash screen
```

**Localization:**
```bash
fvm flutter --no-color pub global run intl_utils:generate        # Generate localization files
```

### Localization

- **Tool**: `intl_utils` (flutter_intl)
- **Main locale**: Russian (`ru`)
- **Generated**: `lib/l10n/generated/`
- **Class name**: `Localizer`
- **Generate**: Run `fvm flutter --no-color pub global run intl_utils:generate` after modifying ARB files
- **ARB location**: `lib/l10n/intl_ru.arb` (main), `lib/l10n/intl_en.arb` (optional)

**Pluralization Support:**
```json
"yearsOld": "{count, plural, one{{count} год} few{{count} года} other{{count} лет}}"
```
Use `Localizer.of(context).yearsOld(age)` - flutter_intl handles Russian plural forms automatically.

### Code Generation Triggers

Run `build_runner` after modifying:
- Router configurations (`@RoutePage`)
- JSON serializable models
- Freezed classes
- Retrofit service interfaces

Run `intl_utils:generate` after modifying:
- ARB files (`lib/l10n/intl_*.arb`)

---

## Architecture Summary

See [Architecture Guide](./docs/architecture.md) for complete details.

### Layer Structure

```
Presentation (UI, BLoC) → Domain (Repository, Abstract DS) → Data (DS Impl, Services)
```

### Key Principles

1. **Dependency Inversion**: Abstract DataSources enable flexible implementations
2. **Concrete Repositories**: Repositories are concrete (not abstract) as they contain no logic
3. **No Flutter in Data/Domain**: Only Presentation layer can import Flutter
4. **Horizontal Dependencies**: Only widgets can depend on other widgets
5. **Dependency Injection**: All dependencies via GetIt modules

### Repository Pattern

**Repositories are private (concrete) because:**
- No business logic, just facade pattern
- Rarely need multiple implementations
- Reduces unnecessary abstraction

**Make abstract only when:**
- Multiple implementations actually needed
- Clear development time savings

---

## Project Structure

See [Structure Guide](./docs/structure.md) for complete details.

### Feature Layout

```
lib/features/{feature}/
├── data/           # DataSource implementations (remote, local, mock)
├── domain/         # Repository (concrete) + abstract DataSource interface
├── model/          # Domain models (Freezed)
├── configs/        # DI module (extends AppModule)
├── custom/         # Utils, extensions
└── ui/             # BLoC, screens, widgets
```

**Key Pattern:**
- `domain/` contains both Repository (concrete class) and DataSource (abstract interface)
- `data/` contains DataSource implementations (RemoteXDataSource, LocalXDataSource, MockXDataSource)
- Repository depends on abstract DataSource interface, not concrete implementations

### UI Organization

**Simple features**: Flat `bloc/`, `screen/`, `widget/`

**Complex features**: Subdivided by flow
```
ui/
├── list/      # bloc/, screen/, widget/
├── details/   # bloc/, screen/, widget/
└── operation/ # bloc/, screen/, widget/
```

### Core Structure

```
lib/core/
├── consts/     # Constants
├── data/       # Core data layer
├── di/         # DI modules
└── router/     # auto_route configuration
```

---

## Dependency Injection

Modular DI using `AppModule`. Register in `main.dart`:

```dart
final modules = <AppModule>[
  CoreModule(),
  DataModule(),
  FeatureModule(),
];
```

Access via `getIt` from `lib/core/di/injection.dart`.

---

## Testing Requirements

See [Testing Guide](./docs/testing.md) for complete details.

### Minimum Requirement

**Every BLoC** must have integration test:
```
BLoC (Real) → Repository (Real) → DataSource (Real) → Service (Mock)
```

### Test Standards

- **Fast**: < 1 second per class
- **High Coverage**: Aim for 100% on BLoC, Repository, DataSource, Service
- **Independent**: No real backend/network
- **Reliable**: No flaky tests

### Test Packages

- `bloc_test`: BLoC testing
- `mocktail`: Mocking framework
- `http_mock_adapter`: Mock Dio requests

---

## Code Style

See [Code Formatting Guide](./docs/code-formatting.md) for complete details.

### Key Rules

- **Trailing commas**: Required
- **Quotes**: Single quotes preferred
- **Imports**: Package imports only (no relative imports in lib/)
- **Widgets**: Never use functions that return widgets - extract to widget classes
- **Theme**: Declare in `build()`, not as state
- **File Organization**: One public class per file (exceptions: BLoC states/events, private helpers)
- **Class Size**: Keep classes < 100 lines; split if > 200 lines (SRP violation)

### BLoC Formatting Rules

**AI Instruction**: ALL BLoC event handlers must follow these formatting rules:

1. **Return emit pattern**: Always use `return emit(state)` for final emit
2. **Whitespace separation**: Add blank line before every `emit()` call
3. **Try-catch structure**: Separate try and catch blocks with whitespace
4. **Variable naming**: Use descriptive names (`successState`, `failureState`) instead of `s` in listeners
5. **Helper methods**: Add `isLoading` getters to states instead of using `maybeMap` checks

**Correct Example:**
```dart
Future<void> _onRequested(
  _Requested event,
  Emitter<State> emit,
) async {
  emit(const State.loading());

  try {
    final data = await _repository.getData();

    return emit(State.success(data));
  } on AppException catch (e) {
    return emit(State.failure(e));
  }
}
```

**State Helper Example:**
```dart
@freezed
class MyState with _$MyState {
  const factory MyState.initial() = _InitialMyState;
  const factory MyState.loading() = _LoadingMyState;

  const MyState._();

  // ✓ Add helper instead of maybeMap
  bool get isLoading => this is _LoadingMyState;
}

// ✓ Usage
if (state.isLoading) { ... }

// ✗ Wrong - verbose
final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);
```

### Comments and Documentation

**IMPORTANT**: Write self-documenting code. Minimize inline comments.

**Documentation style (Flutter `///` format):**
- ✅ **Public classes** in shared modules (toolkit, uikit): 1-3 line summary
- ✅ **Public methods** if needed: Brief description of purpose
- ❌ **Do NOT** comment obvious code
- ❌ **Do NOT** over-explain simple logic

**Example:**
```dart
/// A repository for managing user tasks with caching support.
class TaskRepository {
  /// Fetches tasks for a specific date, using cache if available.
  Future<List<Task>> getTasksByDate(DateTime date) { ... }
}
```

### Linter

See `analysis_options.yaml` for full configuration.

**Excluded files**: `*.g.dart`, `*.freezed.dart`, `*.config.dart`, `**/l10n/generated/**`, `lib/gen/**`

**AI Instruction**: Use glob pattern `**/` to exclude directories across all packages, not just `lib/`

---

## Naming Conventions

See [Naming Conventions](./docs/naming.md) for complete details.

### Pattern

**Classes**: `Feature + Description + Type`
- Example: `UserListBloc`, `TaxPaymentScreen`, `RemoteAuthDataSource`

**Files**: `snake_case`
- Example: `user_list_bloc.dart`, `tax_payment_screen.dart`

---

## Resources

### Assets

- **Icons**: `assets/icons/` → Generated as `SvgIcons`
- **Images**: `assets/images/` → Generated as `Images`
- **Generation**: `spider.json` configuration

### Localization

- **Main locale**: Russian (`ru`)
- **Files**: `lib/l10n/generated/`
- **Usage**: `Localizer` class

---

## Reusing Toolkit and UIKit

**AI Instruction**: ALWAYS check toolkit and uikit before implementing new functionality.

### starter_toolkit

**Purpose**: Pure Dart utilities and helpers

**Available:**
- `DateTimeHelpers` extension: `isToday`, `isTomorrow`, `isSameDay`, `onlyDay`
- Date formatting functions: `getLocalizedDateLabel()`, `getFormattedTimeRange()`
- Validators: Phone, email, password, URL validation
- Exception handling: `AppException` hierarchy
- Localization: Error messages, common strings

**Usage:**
```dart
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

// ✓ Correct - Use extension
if (date.isToday) { ... }
if (date.isTomorrow) { ... }

// ✗ Wrong - Manual comparison
if (DateTime.now().year == date.year && ...) { ... }
```

### starter_uikit

**Purpose**: Reusable UI components and theme

**Available:**
- **Status Widgets** (exported from `starter_uikit.dart`):
  - `EmptyInformationBody`, `FailureWidgetLarge`, `FailureWidgetSmall`, `CustomCircularProgressIndicator`
- **Notifications**: `NotificationSnackBar`
- **Theme**: `AppTheme` (light/dark), `AppTextStyles`, `ThemeProvider`
- **AppBars**: `TitleAppBar`, `BaseAppBar`, `TransparentAppBar`
- **Forms**: `AppTextField`, `AppDropdownField`, `AppCheckbox`, `AppDatePickerField`
- **Buttons**: `AppElevatedButton`, `AppOutlinedButton`

**AI Instruction - Import Strategy:**
- Status widgets are exported from `starter_uikit.dart` - import once
- Other widgets require explicit imports by path
- Always import `NotificationSnackBar` explicitly when using it

**Import Examples:**
```dart
// Status widgets
import 'package:starter_uikit/starter_uikit.dart';

// Other widgets - explicit imports
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
```

**Usage:**
```dart
// ✓ Correct - Use uikit widgets with descriptive names
BlocBuilder<Bloc, State>(
  builder: (context, state) => state.maybeMap(
    loading: (_) => const CustomCircularProgressIndicator(),
    empty: (_) => EmptyInformationBody(text: Localizer.of(context).noData),
    failure: (failureState) => FailureWidgetLarge(
      exception: failureState.exception,
      onRetry: _retry,
    ),
    orElse: () => ...,
  ),
)

// ✗ Wrong - Manual implementation
loading: (_) => const Center(child: CircularProgressIndicator()),
empty: (_) => const Center(child: Text('No data')),

// ✗ Wrong - Using 's' for state variable
failure: (s) => FailureWidgetLarge(exception: s.exception, onRetry: _retry),
```

**Form Widgets:**
```dart
// ✓ Correct - Use AppDatePickerField
AppDatePickerField(
  name: 'birthday',
  label: 'Birthday',
  minDate: DateTime(1900),
  maxDate: DateTime.now(),
  required: true,
)

// ✗ Wrong - Use FormBuilderDateTimePicker directly
FormBuilderDateTimePicker(...)  // Never use directly
```

**Theme Usage:**
```dart
// ✓ Correct - Use ThemeProvider
final theme = ThemeProvider.of(context).theme;
final textStyles = ThemeProvider.of(context).textStyles;

Text('Hello', style: textStyles.mediumBody14)
Container(color: theme.primary)

// ✗ Wrong - Hard-coded colors or styles
Text('Hello', style: TextStyle(fontSize: 14))
Container(color: Color(0xFF6200EE))
```

---

## Important Instructions

**AI Instruction**: Follow these rules strictly:

1. **Read Documentation First**: Before coding, check relevant docs for AI Instructions
2. **Reuse Before Creating**: Check toolkit/uikit before implementing new widgets/helpers
3. **Localization Required**: ALL user-facing strings must use `Localizer.of(context)` - no hardcoded strings
4. **Pluralization**: Use flutter_intl plural syntax in ARB files, never manual pluralization logic
5. **Theme Awareness**: ALL colors/text styles must use `ThemeProvider`
6. **Form Widgets**: Always use uikit form widgets (AppTextField, AppDatePickerField), never FormBuilder widgets directly
7. **Follow AI Instructions**: Documentation contains `**AI Instruction**` markers - follow them exactly
8. **Single Responsibility**: Extract widgets when class > 100 lines
9. **No Useless Comments**: Remove obvious comments that add no value - only use `///` doc comments
10. **Arrow Functions**: Use arrow syntax for single-line callbacks and builders
11. **whenOrNull Over maybeWhen**: For single-case listeners, use `whenOrNull`
12. **Descriptive Variable Names**: Never use `s` for state - use `successState`, `failureState`, etc.
13. **State Helpers**: Add getter methods to states instead of verbose `maybeMap` checks
14. **Async Context**: Use `if (!mounted) return` or capture Navigator before async gaps
15. **Dependency Sorting**: SDK dependencies first, then alphabetical in pubspec.yaml files

**File Creation:**
- Do what has been asked; nothing more, nothing less
- **NEVER** create files unless absolutely necessary
- **ALWAYS** prefer editing existing files to creating new ones
- **NEVER** proactively create documentation files (*.md) or README files unless explicitly requested

---

## Documentation

**AI Instruction**: ALL documentation files contain `**AI Instruction**` markers for important rules. Read and follow them.

For detailed information, see:

- [Architecture Guide](./docs/architecture.md) - Layered architecture and principles with AI Instructions
- [Structure Guide](./docs/structure.md) - File organization with AI Instructions
- [Naming Conventions](./docs/naming.md) - Naming standards with AI Instructions
- [Code Formatting](./docs/code_formatting.md) - **READ THIS FIRST** - Code style with AI Instructions
- [Testing Guide](./docs/testing.md) - Testing strategies with AI Instructions
- [BLoC & Freezed Guide](./docs/bloc_freezed.md) - BLoC patterns with AI Instructions

---

## BLoC State Patterns

**AI Instruction**: Follow these patterns for better state management:

### Nested Status Pattern

For states that need persistent data (like selectedDate) across status changes:

```dart
// ✓ Correct - Nested status
@freezed
class CalendarStatus with _$CalendarStatus {
  const factory CalendarStatus.initial() = _InitialCalendarStatus;
  const factory CalendarStatus.loading() = _LoadingCalendarStatus;
  const factory CalendarStatus.success({required List<Task> tasks}) = _SuccessCalendarStatus;
  const factory CalendarStatus.failure({required AppException exception}) = _FailureCalendarStatus;
}

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({
    required DateTime selectedDate,
    required CalendarStatus status,
  }) = _CalendarState;

  const CalendarState._();

  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const CalendarStatus.initial(),
  );

  bool get isLoading => status is _LoadingCalendarStatus;
}

// Usage in UI
state.status.when(
  initial: () => EmptyView(),
  loading: () => LoadingView(),
  success: (tasks) => SuccessView(tasks),
  failure: (exception) => FailureView(exception),
)

// Access persistent data
CalendarPicker(selectedDate: state.selectedDate)
```

### Refreshed Event Pattern

Add a `refreshed()` event to avoid extracting state data for reload:

```dart
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

## Feature-Specific Guidelines

### Authentication (auth/)
- **Responsibilities**: Login, registration, token management, logout
- **Note**: User profile data moved to `profile/` feature

### Profile (profile/)
- **Responsibilities**: User profile data, user information display
- **Models**: `User` model (id, name, phone, birthday)
- **Repository**: ProfileRepository for getUserProfile()

### Settings (settings/)
- **Responsibilities**: App preferences (language, theme)
- **Note**: Merged from old `preferences/` feature
- **Repository**: SettingsRepository for language preferences

### Task (task/)
- **Responsibilities**: Task management, calendar views
- **Mock Data**: Uses MockTaskDataSource in dev environment

---

---

## Common Issues & Solutions

**AI Instruction**: Reference this section when encountering these issues:

### Analyzer Errors

1. **"Target of URI doesn't exist: 'package:starter_uikit/starter_uikit.dart'"**
   - Create/update `packages/starter_uikit/lib/starter_uikit.dart` export file
   - Export commonly used widgets (status widgets)

2. **"Dependencies not sorted alphabetically"**
   - Sort pubspec.yaml: SDK dependencies first, then alphabetical
   - Pattern: `flutter:`, `flutter_localizations:`, then `a-z` packages

3. **"use_build_context_synchronously"**
   - Add `if (!mounted) return` after async operations
   - Or capture Navigator/context before async: `final nav = Navigator.of(context)`

4. **"omit_local_variable_types"**
   - Use `var` instead of explicit types for local variables
   - Example: `var attempt = 0` not `int attempt = 0`

5. **Deprecated API warnings**
   - `Color.value` → `Color.toARGB32()`
   - Check Flutter migration guides for replacements

### Import Issues

- Status widgets: `import 'package:starter_uikit/starter_uikit.dart'`
- NotificationSnackBar: `import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart'`
- ThemeProvider: `import 'package:starter_uikit/theme/theme_provider.dart'`
- TitleAppBar: `import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart'`

### Empty Directories in Git

Add `.gitkeep` files to track empty but necessary directories:
- `assets/icons/.gitkeep`
- `assets/images/.gitkeep`
- `packages/starter_uikit/assets/images/.gitkeep`

---

**Last Updated**: November 18, 2025
