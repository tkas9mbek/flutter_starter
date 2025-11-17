# Project Structure Guide

> **AI Context**: This document defines the file and folder organization for the Flutter starter project. Follow these patterns when creating new features.

## Table of Contents

1. [Root Structure](#root-structure)
2. [Core Structure](#core-structure)
3. [Feature Structure](#feature-structure)
4. [Feature Grouping](#feature-grouping)
5. [UI Organization](#ui-organization)
6. [Package Structure](#package-structure)

---

## Root Structure

```
flutter_starter/
├── lib/
│   ├── core/              # Core application components
│   ├── features/          # Feature modules
│   ├── l10n/             # Localization files (generated)
│   └── main.dart         # Application entry point
├── packages/
│   ├── starter_toolkit/  # Common utilities and configurations
│   └── starter_uikit/    # Reusable UI components and theme
├── assets/
│   ├── images/           # Image assets
│   └── icons/            # Icon assets
├── test/                 # Unit and integration tests
├── android/              # Android platform code
├── ios/                  # iOS platform code
├── docs/                 # Project documentation
└── pubspec.yaml          # Project dependencies
```

---

## Core Structure

The `lib/core/` directory contains application-wide components:

```
lib/core/
├── consts/               # Application constants
│   ├── api_constants.dart
│   └── app_constants.dart
├── data/                 # Core data layer
│   ├── error/           # Error handling
│   ├── network/         # Network configuration
│   └── storage/         # Local storage utilities
├── di/                   # Dependency injection
│   ├── injection.dart    # GetIt configuration
│   └── modules/         # DI modules
└── router/              # Navigation
    ├── app_router.dart   # auto_route configuration
    └── app_router.gr.dart # Generated routes
```

### Key Rules

- **No Flutter Dependencies**: `core/data/` must not import Flutter framework
- **Global Scope**: Only truly application-wide code belongs in core
- **Feature Independence**: Core should not depend on specific features

---

## Feature Structure

Each feature follows a consistent structure based on the layered architecture:

### Standard Feature Layout

```
lib/features/{feature_name}/
├── data/                 # Data Layer
│   ├── {feature}_data_source.dart        # Abstract DataSource
│   └── remote_{feature}_data_source.dart # Concrete implementation
├── domain/               # Domain Layer
│   └── {feature}_repository.dart         # Repository (usually concrete)
├── model/                # Data Models
│   ├── {feature}_model.dart
│   ├── {feature}_model.freezed.dart      # Generated
│   └── {feature}_model.g.dart            # Generated
├── configs/              # Configuration
│   └── {feature}_module.dart             # DI module
├── custom/               # Utilities & Extensions
│   ├── extensions/
│   └── utils/
└── ui/                   # Presentation Layer
    └── {ui_feature}/
        ├── bloc/         # State management
        │   ├── {feature}_bloc.dart
        │   ├── {feature}_event.dart
        │   ├── {feature}_state.dart
        │   └── {feature}_bloc.freezed.dart
        ├── screen/       # Screens and routes
        │   └── {feature}_screen.dart
        ├── widget/       # Feature-specific widgets
        │   └── {feature}_widget.dart
        └── custom/       # Additional helpers
```

### Example: Authentication Feature

```
lib/features/authentication/
├── data/
│   ├── authentication_data_source.dart
│   └── remote_authentication_data_source.dart
├── domain/
│   └── authentication_repository.dart
├── model/
│   ├── user.dart
│   ├── user.freezed.dart
│   ├── user.g.dart
│   ├── login_request.dart
│   └── auth_token.dart
├── configs/
│   └── authentication_module.dart
└── ui/
    ├── login/
    │   ├── bloc/
    │   │   ├── login_bloc.dart
    │   │   ├── login_event.dart
    │   │   └── login_state.dart
    │   ├── screen/
    │   │   └── login_screen.dart
    │   └── widget/
    │       ├── login_form.dart
    │       └── login_button.dart
    └── registration/
        ├── bloc/
        ├── screen/
        └── widget/
```

### Layer Rules

#### Data Layer (`data/`)

**Purpose**: Handle external data operations

**Contents**:
- Abstract DataSource definitions
- Concrete DataSource implementations (Remote, Local)
- API Services (Retrofit)
- DTOs (Data Transfer Objects)

**Rules**:
- ❌ No Flutter framework imports
- ✅ Implements Domain abstractions
- ✅ Pure Dart code only

#### Domain Layer (`domain/`)

**Purpose**: Define business contracts

**Contents**:
- Repository implementations (usually concrete)
- Abstract Repository (only when multiple implementations needed)

**Rules**:
- ❌ No Flutter framework imports
- ✅ Pure Dart code only
- ✅ Delegates to Abstract DataSources

#### Model Layer (`model/`)

**Purpose**: Define data structures

**Contents**:
- Domain models
- Request/Response models
- Freezed data classes
- JSON serialization

**Rules**:
- ✅ Use `freezed` for immutability
- ✅ Use `json_serializable` for API models
- ❌ No business logic in models

#### UI Layer (`ui/`)

**Purpose**: Presentation and user interaction

**Contents**:
- BLoCs for state management
- Screens with routes
- Feature-specific widgets

**Rules**:
- ✅ Can import Flutter framework
- ✅ Can have horizontal dependencies (widget ↔ widget)
- ❌ Should not contain business logic (use BLoC)

---

## Feature Grouping

### When to Group Features

Small, related features can be grouped under a common directory:

```
lib/features/application/
├── environment/
│   ├── data/
│   ├── domain/
│   ├── model/
│   └── configs/
├── global/
│   ├── data/
│   ├── domain/
│   └── ui/
└── root/
    ├── ui/
    └── configs/
```

### Examples of Grouped Features

**Application-level features:**
```
features/application/
├── environment/    # Environment configuration
├── global/         # Global app state
└── root/          # App initialization
```

**Settings features:**
```
features/settings/
├── profile/        # User profile
├── preferences/    # User preferences
└── notifications/  # Notification settings
```

### Grouping Guidelines

**Group features when:**
- Features are small (< 5 files each)
- Features are tightly related
- Features are always used together

**Don't group when:**
- Features are large and complex
- Features can be used independently
- Features have different lifecycles

---

## UI Organization

The `ui/` folder structure depends on feature complexity.

### Simple Features

For features with 1-2 simple screens:

```
ui/
├── bloc/
│   ├── feature_bloc.dart
│   ├── feature_event.dart
│   └── feature_state.dart
├── screen/
│   └── feature_screen.dart
└── widget/
    ├── feature_header.dart
    └── feature_footer.dart
```

**Use when:**
- Single screen or simple flow
- Minimal UI complexity
- Few widgets

### Complex Features

For features with multiple screens and flows:

```
ui/
├── list/
│   ├── bloc/
│   │   ├── feature_list_bloc.dart
│   │   ├── feature_list_event.dart
│   │   └── feature_list_state.dart
│   ├── screen/
│   │   └── feature_list_screen.dart
│   └── widget/
│       ├── feature_list_item.dart
│       └── feature_list_filter.dart
├── details/
│   ├── bloc/
│   ├── screen/
│   └── widget/
└── operation/
    ├── bloc/
    ├── screen/
    └── widget/
```

**Use when:**
- Multiple distinct screens (list, details, create, edit)
- Complex user flows
- Many widgets per screen
- Different BLoCs for different screens

### UI Subdivision Guidelines

**Common subdivisions:**
- `list/` - List or grid views
- `details/` - Detail or view screens
- `operation/` - Create, edit, delete operations
- `settings/` - Configuration screens

**Each subdivision contains:**
- `bloc/` - State management for that UI section
- `screen/` - Screens and routes
- `widget/` - Widgets specific to that UI section

---

## Package Structure

### starter_toolkit

Common utilities shared across projects:

```
packages/starter_toolkit/
├── lib/
│   ├── extensions/        # Dart extensions
│   ├── utils/            # Utility functions
│   ├── validators/       # Input validators
│   └── helpers/          # Helper classes
└── pubspec.yaml
```

**Purpose**: Code that can be reused across multiple projects

**Examples**:
- Date formatting utilities
- String extensions
- Validation helpers
- Common constants

### starter_uikit

Reusable UI components and theming:

```
packages/starter_uikit/
├── lib/
│   ├── theme/            # App theming
│   │   ├── colors.dart
│   │   ├── typography.dart
│   │   └── theme_data.dart
│   ├── widgets/          # Reusable widgets
│   │   ├── buttons/
│   │   ├── cards/
│   │   ├── inputs/
│   │   └── dialogs/
│   └── assets/           # UI kit assets
└── pubspec.yaml
```

**Purpose**: UI components reused across multiple features

**Examples**:
- Custom buttons
- Form inputs
- Cards and containers
- Loading indicators
- Theme configurations

### When to Use Packages

**Use starter_toolkit when:**
- Code is pure Dart (no Flutter)
- Code is used by multiple features
- Code has no business logic

**Use starter_uikit when:**
- Widget is used in 3+ features
- Widget is generic and configurable
- Widget has no feature-specific logic

**Keep in feature when:**
- Code is feature-specific
- Code contains business logic
- Code is used only in one feature

---

## File Naming Conventions

### General Rules

- **Files**: `snake_case` (e.g., `user_profile_screen.dart`)
- **Classes**: `PascalCase` (e.g., `UserProfileScreen`)
- **Generated files**: `*.g.dart`, `*.freezed.dart`, `*.config.dart`

### Pattern Examples

**Data Layer:**
```
authentication_data_source.dart
remote_authentication_data_source.dart
local_authentication_data_source.dart
authentication_service.dart
```

**Domain Layer:**
```
authentication_repository.dart
user_repository.dart
```

**Models:**
```
user.dart
login_request.dart
auth_token.dart
```

**UI Layer:**
```
login_screen.dart
login_bloc.dart
login_event.dart
login_state.dart
login_form_widget.dart
```

**Configuration:**
```
authentication_module.dart
app_module.dart
```

---

## Migration Guidelines

### Adding a New Feature

1. **Create feature directory**: `lib/features/{feature_name}/`
2. **Add data layer**: Abstract DataSource, implementation, service
3. **Add domain layer**: Repository
4. **Add models**: Domain models with freezed
5. **Add DI module**: Configure dependency injection
6. **Add UI**: BLoC, screens, widgets
7. **Register module**: Add to `main.dart` modules list
8. **Add routes**: Configure in `app_router.dart`

### Refactoring Existing Code

When moving code to packages:

1. **Identify reusable code**: Used in 3+ features
2. **Remove dependencies**: Ensure no feature-specific logic
3. **Move to package**: `starter_toolkit` or `starter_uikit`
4. **Update imports**: Change to package imports
5. **Test thoroughly**: Ensure no regressions

---

## Related Documentation

- [Architecture Guide](./architecture.md) - Layered architecture principles
- [Naming Conventions](./naming.md) - Naming standards for classes
- [Code Formatting](./code-formatting.md) - Code style guidelines
- [Testing Guide](./testing.md) - Testing strategies

---

**Last Updated**: January 17, 2025
