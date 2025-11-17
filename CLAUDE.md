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

### Localization

- **Tool**: `intl_utils`
- **Main locale**: Russian (`ru`)
- **Generated**: `lib/l10n/generated/`
- **Class name**: `Localizer`

### Code Generation Triggers

Run `build_runner` after modifying:
- Router configurations (`@RoutePage`)
- JSON serializable models
- Freezed classes
- Retrofit service interfaces

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
├── data/           # Abstract & concrete DataSources
├── domain/         # Repository (usually concrete)
├── model/          # Domain models (Freezed)
├── configs/        # DI module
├── custom/         # Utils, extensions
└── ui/             # BLoC, screens, widgets
```

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

## Important Instructions

- Do what has been asked; nothing more, nothing less
- **NEVER** create files unless absolutely necessary
- **ALWAYS** prefer editing existing files to creating new ones
- **NEVER** proactively create documentation files (*.md) or README files unless explicitly requested

---

## Documentation

For detailed information, see:

- [Architecture Guide](./docs/architecture.md) - Layered architecture and principles
- [Structure Guide](./docs/structure.md) - File organization and folder structure
- [Naming Conventions](./docs/naming.md) - Class and file naming standards
- [Code Formatting](./docs/code-formatting.md) - Code style and formatting rules
- [Testing Guide](./docs/testing.md) - Testing strategies and requirements
- [BLoC & Freezed Guide](./docs/bloc_freezed.md) - BLoC and Freezed patterns

---

**Last Updated**: January 17, 2025
