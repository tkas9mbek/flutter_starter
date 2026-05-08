# Flutter Starter Template

> **Version 2.0.1** - [View Changelog](CHANGELOG.md)

A production-ready Flutter template for building small to medium-sized applications, refined through years of real-world client projects.

## Background

Working in outsource companies and developing apps for various clients, I needed a reliable, flexible template that could be quickly adapted to different project requirements. After developing each app, I continuously updated and refined this template, incorporating best practices and lessons learned from production deployments.

**Special Thanks:** This template builds upon the excellent foundation created by my former colleague **Andrey Kaschenko**. His original architecture and engineering approach continue to inspire and influence significant portions of this template.

### Why Separate UIKit and Toolkit?

In client projects, it's common to have **multiple apps sharing the same backend or design system** (e.g., customer app + admin app). By separating the UIKit and Toolkit into independent packages:

- **Toolkit** (shared utilities package): Share business logic, API clients, and utilities across apps
- **UIKit** (Flutter widgets): Reuse UI components while allowing customization per app

This modular approach has proven invaluable when building app families for clients, dramatically reducing development time and improving code consistency.

---

## What You Get

This template provides a complete, production-ready foundation with:

### Architecture & Patterns
- **Clean three-layer architecture** (Presentation → Domain → Data)
- **BLoC state management** with Freezed
- **Repository pattern** with abstract DataSources
- **Dependency injection** with GetIt (modular configuration)
- **Repository executors** with decorator pattern (retry, caching, error handling)
- **Two-layer exception handling** (domain exceptions + UI models)

### Features
- **Authentication flow** (login, registration, token management)
- **User profile** management
- **Settings** (theme toggle, language selection)
- **Task management** with calendar (example feature)
- **Theme system** (light/dark mode)
- **Localization** (English & Russian)
- **Environment configuration** (mock, dev, prod)

### Code Quality
- **145 tests passing** (100% pass rate)
- **Comprehensive BLoC and integration tests**
- **Full-stack integration testing** for all features
- **Zero analyzer warnings**
- **Custom lint rules** (starter_lints package)
- **Extensive documentation** (CLAUDE.md + /docs)

### Developer Experience
- **Type-safe API client** with response-based methods
- **Code generation** for routes, models, exceptions
- **UIKit example app** showcasing all components
- **Theme-aware widgets** with consistent styling
- **Complete localization setup**
- **AI-friendly documentation** (optimized for Codex and Claude Code)

---

## Quick Start

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter run
```

### First 10-Minute Bootstrap Checklist

1. Update API base URLs in `lib/core/consts/core_consts.dart`
2. Update store URLs in `lib/core/consts/core_consts.dart`
3. Confirm environment defaults (`mock`, `dev`, `prod`) in `lib/features/application/environment/model/app_environment.dart`
4. Set your app version in `pubspec.yaml` and keep `CoreConsts.appVersion` in sync
5. Run code generation if you changed models/routes/localization:
   - `fvm flutter pub run build_runner build --delete-conflicting-outputs`
   - `fvm flutter --no-color pub global run intl_utils:generate`

## CI

GitHub Actions is configured in `.github/workflows/ci.yml` and runs:

1. `flutter pub get`
2. `dart run custom_lint --no-fatal-infos --no-fatal-warnings`
3. `flutter analyze`
4. `flutter test` split across feature shards in parallel

---

## Project Structure

```
flutter_starter/
├── lib/
│   ├── core/              # App-wide configuration
│   │   ├── consts/        # Constants (API URLs, etc.)
│   │   ├── di/            # Dependency injection modules
│   │   ├── router/        # Navigation (auto_route)
│   │   └── data/          # Core data layer
│   │
│   ├── features/          # Feature modules
│   │   ├── auth/          # Authentication (login, registration)
│   │   ├── profile/       # User profile
│   │   ├── settings/      # App settings (theme, language)
│   │   ├── task/          # Example feature (task management)
│   │   └── application/   # Global app state
│   │
│   ├── l10n/              # Localization files
│   └── main.dart          # App entry point
│
├── packages/
│   ├── starter_toolkit/   # Shared utilities and data infrastructure
│   │   ├── data/          # API client, exceptions, executors
│   │   ├── utils/         # Helpers, validators, formatters
│   │   └── README.md
│   │
│   ├── starter_uikit/     # Flutter UI components
│   │   ├── widgets/       # Reusable widgets
│   │   ├── theme/         # Theme system
│   │   ├── example/       # Demo app
│   │   └── README.md
│   │
│   └── starter_lints/     # Custom lint rules
│       ├── lib/src/lints/ # Lint implementations
│       └── README.md
│
├── test/                  # Tests (145 tests, 100% pass rate)
├── docs/                  # Documentation
├── CLAUDE.md              # AI assistant guide (14.5KB)
└── README.md              # This file
```

### Feature Structure

Each feature follows a consistent pattern:

```
features/feature_name/
├── data/                  # DataSource implementations
│   ├── remote_x_data_source.dart
│   └── local_x_data_source.dart
│
├── domain/                # Repository + abstract DataSource
│   ├── x_repository.dart
│   └── x_data_source.dart
│
├── model/                 # Data models
│   └── x_model.dart
│
├── configs/               # DI module
│   └── x_module.dart
│
└── ui/                    # Presentation layer
    ├── bloc/              # BLoC (state management)
    ├── screen/            # UI screens
    └── widget/            # UI widgets
```

---

## Key Features Explained

### 1. API Client (Toolkit)

Type-safe HTTP client with response-based methods:

```dart
// Clear intent - returns User object
final user = await client.requestJson<User>(
method: HttpMethod.get,
path: '/users/123',
fromJson: User.fromJson,
);

// Clear intent - returns void
await client.requestVoid(
method: HttpMethod.delete,
path: '/users/123',
);
```

### 2. Exception Handling

Two-layer architecture with sealed classes:

```dart
// In BLoC - store domain exception
try {
final data = await _repository.getData();
return emit(State.success(data));
} on AppException catch (e) {
return emit(State.failure(e));
}

// In UI - map to localized model
final uiModel = ExceptionUiMapper(context).map(exception);
FailureWidgetLarge(exception: exception, onRetry: _retry);
```

### 3. Repository Executors

Decorator pattern for cross-cutting concerns:

```dart
final executor = RawRepositoryExecutor()
        .withErrorHandling()  // Convert exceptions
        .withRetry()          // Exponential backoff
        .withCaching();       // Time-based cache

Future<List<User>> getUsers() {
   return _executor.execute(() => _dataSource.getUsers());
}
```

### 4. Theme System (UIKit)

Centralized theme management:

```dart
final theme = ThemeProvider.of(context).theme;
final textStyles = ThemeProvider.of(context).textStyles;

Container(color: theme.primary)
Text('Hello', style: textStyles.mediumBody14)
```

### 5. Localization

Multi-package localization support:

```dart
// Main app
Localizer.of(context).login

// Toolkit (error messages)
ToolkitLocalizer.of(context).errorMessageNoConnection

// UIKit (widget labels)
UikitLocalizer.of(context).retry
```

---

## Testing

The template includes comprehensive tests:

```bash
# Run all tests
fvm flutter test

# Run with coverage
fvm flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

**Test Summary:**
- **145 tests passing** (100% pass rate)
- **Unit Tests**: 111 tests (BLoC, repositories, data sources)
- **Integration Tests**: 34 tests (full-stack flows)

**Integration Test Coverage:**
- ✅ Auth (LoginBloc, RegistrationBloc)
- ✅ Task (CalendarBloc, TasksListBloc, TaskDeleteBloc)
- ✅ Profile (UserBloc)
- ✅ Settings (LanguageCubit, ThemeCubit)
- ✅ Application (EnvironmentCubit)

---

## Code Generation

The template uses several code generators:

```bash
# Routes, JSON, Freezed models
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Exception mappers (custom tool)
dart run utils/generators/generate_exception_mapper.dart

# Localization files
fvm flutter --no-color pub global run intl_utils:generate

# Asset references
fvm flutter pub run spider build

# App icons
fvm flutter pub run flutter_launcher_icons

# Splash screen
fvm flutter pub run flutter_native_splash:create
```

---

## Available Packages

### Starter Toolkit (Shared Utilities)

**What it provides:**
- API client with type-safe methods
- Exception system with sealed classes
- Repository executors (retry, caching, error handling)
- Date/time helpers and extensions
- Form validators and formatters
- BLoC utilities

**Use it for:** Shared business logic across multiple apps

[📖 Toolkit Documentation](packages/starter_toolkit/README.md)

### Starter UIKit (Flutter Widgets)

**What it provides:**
- Status widgets (loading, empty, error states)
- App bars (title, base, transparent)
- Buttons (elevated, outlined with loading)
- Form components (text fields, dropdowns, date pickers)
- Notifications (snackbar)
- Theme system (light/dark mode)
- Exception UI mapper
- Interactive example app

**Use it for:** Consistent UI across apps sharing design

[📖 UIKit Documentation](packages/starter_uikit/README.md)

### Starter Lints (Custom Lint Rules)

**What it provides:**
- `avoid_widget_functions` - Prohibit `_build*` functions returning Widget
- `prefer_arrow_except_build` - Arrow for callbacks, block for `build()` only
- `always_spread_in_collections` - Require spread operator in collections
- `bloc_no_bloc_dependency` - BLoCs cannot inject other BLoCs
- `blank_line_before_return` - Require blank line before return
- `sort_constructor_params` - Order: required → defaults → optional → super

**Use it for:** Enforcing consistent code style across the project

[📖 Lints Documentation](packages/starter_lints/README.md)

---

## Documentation

The template includes extensive documentation:

- **[AGENTS.md](AGENTS.md)** - Comprehensive guide for Codex and agentic coding assistants
- **[CLAUDE.md](CLAUDE.md)** - Companion guide for Claude Code workflows
- **[AI Context](docs/ai-context/)** - Concise AI-friendly cheat-sheets per topic
- **[Architecture Guide](docs/guides/architecture.md)** - Three-layer architecture, dependency inversion
- **[BLoC & Freezed Guide](docs/guides/freezed_bloc.md)** - State management patterns
- **[Code Review Guide](docs/guides/code_review.md)** - Severity-based review checklist
- **[Estimation Guide](docs/guides/estimation.md)** - Story-point estimation method
- **[Exception Handling](docs/guides/exception_handling.md)** - Two-layer exception system, code generation
- **[Structure Guide](docs/guides/structure.md)** - File organization, feature layout
- **[Testing Guide](docs/guides/testing.md)** - Testing strategies, patterns, best practices
- **[Coding Rules](docs/rules/coding_rules.md)** - Consolidated rule set + lint mapping
- **[BLoC File Rules](docs/rules/bloc.md)** - File layout & basic flow
- **[Code Formatting](docs/rules/code_formatting.md)** - Code style, BLoC patterns, conventions
- **[Git Workflow](docs/rules/git_workflow.md)** - Branch / commit / PR naming
- **[Naming Conventions](docs/rules/naming.md)** - Consistent naming patterns

---

## Customization Guide

### Add New Features

1. Create feature directory: `lib/features/my_feature/`
2. Follow the feature structure pattern (data, domain, model, ui, configs)
3. Create DI module extending `AppModule`
4. Register module in `app_configurator.dart`
5. Add routes to `app_router.dart`
6. Write tests in `test/features/my_feature/`

### Customize Theme

Edit theme files in `packages/starter_uikit/lib/theme/`:
- `app_theme.dart` - Colors, dimensions
- `app_text_styles.dart` - Typography
- Update example app to preview changes

### Add Localizations

1. Add language code to `pubspec.yaml` → `flutter_intl:`
2. Create `lib/l10n/intl_[lang].arb`
3. Run: `fvm flutter --no-color pub global run intl_utils:generate`
4. Repeat for toolkit and uikit packages

---

## Common Tasks

### Add New Exception Type

1. Create exception class with `@ExceptionUiConfig`:
   ```dart
   @ExceptionUiConfig(
     titleKey: 'errorTitle',
     descriptionKey: 'errorDescription',
     snackbarKey: 'errorSnackbar',
   )
   final class MyException extends AppException {
     const MyException();
     // ...
   }
   ```

2. Run generator:
   ```bash
   dart run utils/generators/generate_exception_mapper.dart
   ```

3. Add localization keys to ARB files

### Change Main Locale

1. Update `pubspec.yaml` in all packages: `main_locale: [code]`
2. Create main ARB file: `lib/l10n/intl_[code].arb`
3. Regenerate: `fvm flutter --no-color pub global run intl_utils:generate`

---

## Tech Stack

**Core:**
- Flutter 3.32.0 (managed via FVM)
- Dart 3.0.0+

**State Management:**
- flutter_bloc 9.1.1
- freezed 2.5.8

**Navigation:**
- auto_route 9.2.2

**Dependency Injection:**
- get_it 8.2.0

**Networking:**
- dio 5.9.0

**Storage:**
- flutter_secure_storage 9.2.4

**Forms:**
- flutter_form_builder 10.1.0

**Localization:**
- intl 0.20.2
- intl_utils 2.8.8

**Testing:**
- bloc_test
- mocktail
- http_mock_adapter

---

## License

Private template for internal use. Feel free to fork and adapt for your projects.

---

## Credits

- **Original Architecture:** Andrey Kaschenko - The foundation and engineering principles
- **Template Evolution:** Refined through multiple client projects
- **Inspiration:** Real-world production requirements and challenges
