# Project Structure Guide

> **AI Context**: File and folder organization patterns. Follow these when creating features.

## Root Structure

**AI Instruction**: Three main directories: `lib/`, `packages/`, `assets/`

```
flutter_starter/
├── lib/
│   ├── core/              # Core application components
│   ├── features/          # Feature modules
│   └── l10n/             # Localization (generated)
├── packages/
│   ├── starter_toolkit/  # Utilities (pure Dart)
│   └── starter_uikit/    # UI components (Flutter)
├── assets/               # Images, icons
└── test/                 # Tests
```

---

## Core Structure

**AI Instruction**: Only application-wide, feature-independent code

```
lib/core/
├── consts/               # Constants
├── data/                 # Core data (NO Flutter imports)
│   ├── error/
│   ├── network/
│   └── storage/
├── di/                   # Dependency injection
│   └── modules/
└── router/              # auto_route configuration
```

## Feature Structure

**AI Instruction**: Standard pattern: data → domain → model → configs → ui

```
lib/features/{feature}/
├── data/                 # DataSource (abstract + implementations)
├── domain/               # Repository (usually concrete)
├── model/                # Freezed models (*.freezed.dart, *.g.dart)
├── configs/              # DI module
└── ui/                   # BLoC + screens + widgets
    └── {ui_feature}/
        ├── bloc/
        ├── screen/
        └── widget/
```

### Layer Rules

**AI Instruction**: Follow these strictly

| Layer | Flutter? | Contains | Rules |
|-------|----------|----------|-------|
| **data/** | ❌ | DataSource implementations (Remote/Local/Mock) | Pure Dart, implements Domain |
| **domain/** | ❌ | Repository (concrete) | Pure Dart, delegates to DS |
| **model/** | ❌ | Freezed classes, JSON | Use `freezed` + `json_serializable` |
| **ui/** | ✅ | BLoC, Screens, Widgets | Horizontal deps OK, no business logic |

## Feature Grouping

**AI Instruction**: Group only small (< 5 files), tightly related features

```
lib/features/application/
├── environment/    # Small feature
├── global/         # Small feature
└── root/          # Small feature
```

**Group when**: Small, tightly related, used together
**Don't group when**: Large, independent, different lifecycles

## UI Organization

**AI Instruction**: Flat structure for simple, subdivided for complex

### Simple Features (1-2 screens)

```
ui/
├── bloc/
├── screen/
└── widget/
```

### Complex Features (multiple screens/flows)

```
ui/
├── list/          # List view
│   ├── bloc/
│   ├── screen/
│   └── widget/
├── details/       # Detail view
└── operation/     # Create/Edit
```

**Common subdivisions**: `list/`, `details/`, `operation/`, `settings/`

## Package Structure

**AI Instruction**: Extract to packages only when used in 3+ features

### starter_toolkit (Pure Dart)

```
packages/starter_toolkit/lib/
├── extensions/        # Dart extensions
├── utils/            # Utilities
└── validators/       # Input validators
```

**Use when**: Pure Dart, no business logic, multi-feature

### starter_uikit (Flutter)

```
packages/starter_uikit/lib/
├── theme/            # Theming
└── widgets/          # Generic widgets (buttons, inputs, cards)
```

**Use when**: Used in 3+ features, generic, no feature logic
**Keep in feature when**: Feature-specific or single use

## File Naming

**AI Instruction**: `snake_case` for files, `PascalCase` for classes

```
authentication_data_source.dart          → AuthenticationDataSource
remote_authentication_data_source.dart   → RemoteAuthenticationDataSource
authentication_repository.dart           → AuthenticationRepository
user.dart                                → User
login_bloc.dart                          → LoginBloc
login_screen.dart                        → LoginScreen
authentication_module.dart               → AuthenticationModule
```

**Generated**: `*.g.dart`, `*.freezed.dart`, `*.config.dart`

---

## Adding New Feature

**AI Instruction**: Follow this order

1. Create `lib/features/{feature}/`
2. Add models (freezed classes with JSON serialization)
3. Add domain layer (abstract DataSource + concrete Repository)
4. Add data layer (DataSource implementations: Remote/Local/Mock)
5. Add DI module
6. Add UI (BLoC, screens, widgets)
7. Register module in `main.dart`
8. Add routes in `app_router.dart`

---

## Related Documentation

- [Architecture](./architecture.md) - Layer structure
- [Naming](./naming.md) - Naming standards
- [Code Formatting](./code_formatting.md) - Style guide
- [Testing](./testing.md) - Test strategies

---

**Last Updated**: January 18, 2025
