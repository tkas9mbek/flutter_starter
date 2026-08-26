# Project Structure Guide

## Root Structure

Main directories: `lib/`, `packages/`, `assets/`, `test/`, `docs/`, `work/`

```
flutter_starter/
├── lib/
│   ├── core/              # Core application components
│   ├── features/          # Feature modules
│   └── l10n/             # Localization (generated)
├── packages/
│   ├── starter_toolkit/  # Shared utilities and data infrastructure
│   ├── starter_uikit/    # UI components (Flutter)
│   └── starter_lints/    # Custom lint rules
├── assets/               # Images, icons
├── test/                 # Tests
├── docs/                 # Project context, rules, and guides
└── work/                 # Supplemental product/API/planning docs when present
```

### Generated Files

Never hand-edit generated files — rerun the owning generator:

- `*.gr.dart`, `*.freezed.dart`, `*.g.dart` — build_runner (routes, Freezed, JSON)
- `lib/l10n/generated/`, `packages/*/lib/l10n/generated/` — intl_utils (after ARB changes)
- Exception mapper + decorator — `dart run utils/generators/generate_exception_mapper.dart`
- `packages/starter_uikit/lib/resources/` (`UiSvgIcons`, `Images`, fonts) — `spider build` in `packages/starter_uikit` (after adding/renaming assets; config in `spider.json`)

---

## Core Structure

Only application-wide, feature-independent code

```
lib/core/
├── global/               # Constants, storage keys, global flags
├── data/                 # Core data (NO Flutter imports)
├── di/                   # Dependency injection
├── notifications/        # Push notification setup, FCM/API token data sources
├── remote_config/        # Firebase/asset-backed remote config
└── router/               # auto_route configuration
```

## Feature Structure

Standard pattern: data → domain → model → configs → ui

```
lib/features/{feature}/
├── data/                 # DataSource implementations (Api/Local/Mock)
├── domain/               # Repository (concrete) + abstract DataSource
├── model/                # Freezed models (*.freezed.dart, *.g.dart)
├── configs/              # DI module
└── ui/                   # BLoC + screens + widgets
    └── {ui_feature}/
        ├── bloc/
        ├── screen/
        └── widget/
```

### Layer Rules

Follow these strictly

| Layer | Flutter? | Contains | Rules |
|-------|----------|----------|-------|
| **data/** | ❌ | DataSource implementations (Api/Local/Mock) | Pure Dart, implements Domain |
| **domain/** | ❌ | Repository (concrete), abstract DataSource | Pure Dart, delegates to DS |
| **model/** | ❌ | Freezed classes, JSON | Use `freezed` + `json_serializable` |
| **ui/** | ✅ | BLoC, Screens, Widgets | Horizontal deps OK, no business logic |

## Feature Grouping

Group only small (< 5 files), tightly related features

```
lib/features/application/
├── environment/    # Small feature
├── global/         # Small feature
└── root/          # Small feature
```

**Group when**: Small, tightly related, used together
**Don't group when**: Large, independent, different lifecycles

## UI Organization

`ui/` always contains subfeature folders — never `bloc/`, `screen/`, or `widget/` directly at its root.
Each subfeature owns its own `bloc/`, `screen/`, `widget/` (and `model/` if needed).

```
ui/
├── list/          # List view
│   ├── bloc/
│   ├── screen/
│   └── widget/
├── details/       # Detail view
└── operation/     # Create/Edit
```

A feature with a single flow still gets one subfeature folder, named after the feature
(e.g. `profile/ui/overview/`). Widgets shared across subfeatures live in the subfeature that owns
them; cross-subfeature imports within a feature are fine.

**Common subdivisions**: `list/`, `details/`, `operation/`, `settings/`

## Package Structure

Extract to packages only when used in 3+ features

### starter_toolkit (Shared Utilities & Data Infrastructure)

```
packages/starter_toolkit/lib/
├── configs/              # Shared constants
├── data/
│   ├── client/           # ApiClient, DioApiClient, HttpMethod
│   ├── exceptions/       # AppException hierarchy + @ExceptionUiConfig
│   ├── interceptor/      # Dio interceptors (errors, auth refresh)
│   ├── model/            # Shared data models (pagination, …)
│   ├── repository_cache/ # RepositoryCache + InMemoryRepositoryCache
│   └── repository_executor/  # Raw/ErrorHandling/Retry executors + extensions
├── l10n/                 # ToolkitLocalizer (generated)
└── utils/                # bloc/, converters/, date/, form/, functions/, helpers/, version/
```

**Use when**: Cross-feature helpers, data/client abstractions, reusable infrastructure

### starter_uikit (Flutter)

```
packages/starter_uikit/lib/
├── configs/          # UI constants
├── example/          # In-package example/demo screens
├── l10n/             # UikitLocalizer + ARB files (exception messages live here)
├── models/           # UI models (ExceptionUiModel, …)
├── resources/        # Spider-generated asset refs (UiSvgIcons, Images, fonts)
├── theme/            # AppTheme, AppTextStyles, ThemeProvider
├── utils/            # ExceptionUiMapper (+ decorator), form/image helpers
└── widgets/          # app_bar/, button/, dialogs/, form/, media/, misc/, screen/, size/, status/, text/
```

**Use when**: Used in 3+ features, generic, no feature logic
**Keep in feature when**: Feature-specific or single use

### starter_lints

```
packages/starter_lints/lib/
└── src/lints/        # custom_lint rules
```

**Use when**: A style/architecture rule should be enforced automatically.

## File Naming

`snake_case` for files, `PascalCase` for classes

```
authentication_data_source.dart          → AuthenticationDataSource
api_authentication_data_source.dart      → ApiAuthenticationDataSource
authentication_repository.dart           → AuthenticationRepository
user.dart                                → User
login_bloc.dart                          → LoginBloc
login_screen.dart                        → LoginScreen
authentication_module.dart               → AuthenticationModule
```

**Generated**: `*.g.dart`, `*.freezed.dart`, `*.config.dart`

---

## Adding New Feature

Follow this order

1. Create `lib/features/{feature}/`
2. Add models (freezed classes with JSON serialization)
3. Add domain layer (abstract DataSource + concrete Repository)
4. Add data layer (DataSource implementations: Api/Local/Mock)
5. Add DI module
6. Add UI (BLoC, screens, widgets)
7. Register module in `lib/core/di/app_configurator.dart`
8. Add routes in `app_router.dart`

---

## Related Documentation

- [Architecture](./architecture.md) - Layer structure
- [Naming](../rules/naming.md) - Naming standards
- [Code Standards](../rules/code_standards.md) - Style guide
- [Testing](./testing.md) - Test strategies
