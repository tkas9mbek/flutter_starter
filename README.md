# Flutter Starter Template

A production-ready Flutter template for building small to medium-sized applications, refined through years of real-world client projects.

## Background

Working in outsource companies and developing apps for various clients, I needed a reliable, flexible template that could be quickly adapted to different project requirements. After developing each app, I continuously updated and refined this template, incorporating best practices and lessons learned from production deployments.

**Special Thanks:** This template builds upon the excellent foundation created by my former colleague **Andrey Kaschenko**. His original architecture and engineering approach continue to inspire and influence significant portions of this template.

### Why Separate UIKit and Toolkit?

In client projects, it's common to have **multiple apps sharing the same backend or design system** (e.g., customer app + admin app, iOS + Android versions with different UIs). By separating the UIKit and Toolkit into independent packages:

- **Toolkit** (pure Dart): Share business logic, API clients, and utilities across all apps
- **UIKit** (Flutter widgets): Reuse UI components while allowing customization per app
- **Flexibility**: Mix and match - use toolkit without UIKit, or create custom UI packages

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
- ✅ **Authentication flow** (login, registration, token management)
- ✅ **User profile** management
- ✅ **Settings** (theme toggle, language selection)
- ✅ **Task management** with calendar (example feature)
- ✅ **Theme system** (light/dark mode)
- ✅ **Localization** (English & Russian)
- ✅ **Environment configuration** (dev, staging, production)

### Code Quality
- 📊 **82.2% test coverage** (108 tests passing)
- 🎯 **Comprehensive BLoC tests**
- 🔄 **Integration tests** for critical flows
- ✅ **Zero analyzer warnings**
- 📝 **Extensive documentation** (CLAUDE.md + /docs)

### Developer Experience
- 🚀 **Type-safe API client** with response-based methods
- 🔧 **Code generation** for routes, models, exceptions
- 📱 **UIKit example app** showcasing all components
- 🎨 **Theme-aware widgets** with consistent styling
- 🌍 **Complete localization setup**
- 📚 **AI-friendly documentation** (optimized for Claude Code)

---

## Quick Start

### Prerequisites

- [Flutter 3.32.0](https://docs.flutter.dev/get-started/install) (managed via [FVM](https://fvm.app))
- [FVM](https://fvm.app) installed globally
- Dart SDK 3.0.0+

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-org/flutter_starter.git
   cd flutter_starter
   ```

2. **Install FVM and Flutter:**
   ```bash
   fvm install 3.32.0
   fvm use 3.32.0
   ```

3. **Install dependencies:**
   ```bash
   fvm flutter pub get
   ```

4. **Generate code:**
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app:**
   ```bash
   fvm flutter run
   ```

### First Steps

1. **Update package names:**
   - Android: `android/app/build.gradle` → Change `applicationId`
   - iOS: Open Xcode → Update bundle identifier
   - Or use: `flutter pub run change_app_package_name:main com.yourcompany.appname`

2. **Configure API URLs:**
   - Edit `lib/core/consts/core_consts.dart`
   - Replace `https://example.com` with your backend URLs

3. **Customize branding:**
   - App name: `pubspec.yaml` → `name:`
   - App icons: `fvm flutter pub run flutter_launcher_icons`
   - Splash screen: `fvm flutter pub run flutter_native_splash:create`

4. **Update localization:**
   - Edit `lib/l10n/intl_en.arb` (main locale)
   - Run: `fvm flutter --no-color pub global run intl_utils:generate`

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
│   ├── starter_toolkit/   # Pure Dart utilities
│   │   ├── data/          # API client, exceptions, executors
│   │   ├── utils/         # Helpers, validators, formatters
│   │   └── README.md
│   │
│   └── starter_uikit/     # Flutter UI components
│       ├── widgets/       # Reusable widgets
│       ├── theme/         # Theme system
│       ├── example/       # Demo app
│       └── README.md
│
├── test/                  # Tests (108 tests, 82.2% coverage)
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
FailureWidgetLarge(uiModel: uiModel, onRetry: _retry);
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

**Test Coverage:**
- Overall: 82.2% (258/314 lines)
- Profile: 100%
- Application: 98.1%
- Task: 89.9%
- Auth: 75.5%

**Test Types:**
- ✅ Unit tests (repositories, data sources)
- ✅ BLoC tests (all states and events)
- ✅ Integration tests (full stack flows)

---

## Code Generation

The template uses several code generators:

```bash
# Routes, JSON, Freezed models
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Exception mappers (custom tool)
dart run tool/generate_exception_mapper.dart

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

### Starter Toolkit (Pure Dart)

**What it provides:**
- API client with type-safe methods
- Exception system with sealed classes
- Repository executors (retry, caching, error handling)
- Date/time helpers and extensions
- Form validators and formatters
- BLoC utilities
- Localization for error messages

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

---

## Documentation

The template includes extensive documentation:

- **[CLAUDE.md](CLAUDE.md)** - Comprehensive guide for AI assistants (14.5KB, optimized for Claude Code)
- **[Architecture Guide](docs/architecture.md)** - Three-layer architecture, dependency inversion
- **[Exception Handling](docs/exception_handling.md)** - Two-layer exception system, code generation
- **[Testing Guide](docs/testing.md)** - Testing strategies, patterns, best practices
- **[Code Formatting](docs/code-formatting.md)** - Code style, BLoC patterns, conventions
- **[Structure Guide](docs/structure.md)** - File organization, feature layout
- **[Naming Conventions](docs/naming.md)** - Consistent naming patterns
- **[BLoC & Freezed Guide](docs/bloc/)** - State management patterns

---

## Customization Guide

### Remove Example Features

If you don't need the task management example:

1. Delete `lib/features/task/`
2. Remove `TaskModule()` from `lib/core/di/app_configurator.dart`
3. Remove task routes from `lib/core/router/app_router.dart`
4. Delete `test/features/task/`

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

## Production Readiness Checklist

Before deploying to production:

### Critical
- [ ] Configure real API URLs in `core_consts.dart`
- [ ] Setup Android release signing (`android/app/build.gradle`)
- [ ] Update package names (Android + iOS)
- [ ] Add crash reporting (Firebase Crashlytics, Sentry)
- [ ] Test on physical devices (iOS + Android)

### Recommended
- [ ] Add analytics (Firebase Analytics, Mixpanel)
- [ ] Create privacy policy and terms
- [ ] Enable code obfuscation for release builds
- [ ] Setup CI/CD pipeline
- [ ] Configure app icons and splash screens
- [ ] Update app metadata (name, version, description)

### Optional
- [ ] Add performance monitoring
- [ ] Setup feature flags
- [ ] Configure deep linking
- [ ] Add push notifications
- [ ] Setup A/B testing

**Note:** The template is production-ready architecturally (82.2% test coverage, zero analyzer warnings) but requires environment-specific configuration.

---

## Common Tasks

### Update Dependencies

```bash
# Check for outdated packages
fvm flutter pub outdated

# Update dependencies
fvm flutter pub upgrade

# Regenerate code after updates
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

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
   dart run tool/generate_exception_mapper.dart
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

## Contributing

This is a personal template, but if you have suggestions or improvements:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## License

Private template for internal use. Feel free to fork and adapt for your projects.

---

## Credits

- **Original Architecture:** Andrey Kaschenko - The foundation and engineering principles
- **Template Evolution:** Refined through multiple client projects
- **Inspiration:** Real-world production requirements and challenges

---

## Support

For questions or issues:
- Check [CLAUDE.md](CLAUDE.md) for detailed architecture documentation
- Review `/docs` folder for specific topics
- Check package READMEs for toolkit/uikit usage

---

**Built with ❤️ for efficient Flutter development**
