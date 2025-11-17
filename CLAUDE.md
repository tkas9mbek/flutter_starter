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

**Excluded files**: `*.g.dart`, `*.freezed.dart`, `*.config.dart`, `lib/l10n/generated/`

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
- **Status Widgets**: `EmptyInformationBody`, `FailureWidgetLarge`, `FailureWidgetSmall`, `CustomCircularProgressIndicator`
- **Notifications**: `NotificationSnackBar`
- **Theme**: `AppTheme` (light/dark), `AppTextStyles`, `ThemeProvider`
- **AppBars**: `TitleAppBar`, `BaseAppBar`, `TransparentAppBar`
- **Forms**: `AppTextField`, `AppDropdownField`, `AppCheckbox`, `AppDatePickerField`
- **Buttons**: `AppElevatedButton`, `AppOutlinedButton`

**IMPORTANT**: Many widgets are NOT exported from `starter_uikit.dart`. Use explicit imports:
```dart
import 'package:starter_uikit/starter_uikit.dart';  // For status widgets, theme
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
```

**Usage:**
```dart
// ✓ Correct - Use uikit widgets
BlocBuilder<Bloc, State>(
  builder: (context, state) => state.maybeMap(
    loading: (_) => const CustomCircularProgressIndicator(),
    empty: (_) => EmptyInformationBody(text: Localizer.of(context).noData),
    failure: (s) => FailureWidgetLarge(exception: s.exception, onRetry: _retry),
    orElse: () => ...,
  ),
)

// ✗ Wrong - Manual implementation
loading: (_) => const Center(child: CircularProgressIndicator()),
empty: (_) => const Center(child: Text('No data')),
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

**Last Updated**: January 18, 2025
