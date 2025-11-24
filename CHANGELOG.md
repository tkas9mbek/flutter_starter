# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-24

### Added

#### Architecture & Foundation
- **Three-layer Clean Architecture** with strict dependency inversion (Data → Domain → Presentation)
- **Repository Executor Pattern** with decorator chain for cross-cutting concerns
  - `ErrorHandlingExecutor` - Normalizes all exceptions to `AppException`
  - `RetryExecutor` - Automatic retry with exponential backoff (2s, 4s, 8s)
  - `CachingExecutor` - Time-based caching with automatic cleanup
- **Two-layer Exception Handling System**
  - Domain exceptions (pure Dart sealed classes)
  - UI exception models with localized messages
  - Custom code generator (`tool/generate_exception_mapper.dart`)
  - Type-safe exhaustive pattern matching with switch expressions

#### State Management
- **BLoC pattern** with flutter_bloc v9.1.1
- **Freezed** for immutable state management
- **Nested Status Pattern** for complex state (persistent + transient data)
- State helper getters (`isLoading`) instead of verbose `maybeMap` checks
- Refreshed event pattern to avoid extracting state data

#### Features
- **Authentication Module**
  - Login with phone/email and password
  - Registration with validation
  - Token-based authentication with secure storage
  - Unauthorized/authorized data source pattern
  - Auto-logout on token expiration
- **Task Management Module**
  - CRUD operations for tasks
  - Calendar view with date filtering
  - Task list with grouping by date
  - Task details and editing
  - Task status management
- **Profile Module**
  - User profile management
  - Profile editing
  - Avatar support
- **Settings Module**
  - Theme switching (Light/Dark/System)
  - Language switching (English/Russian)
  - Persistent preferences with SharedPreferences

#### Testing Infrastructure
- **145 comprehensive tests** (100% pass rate)
  - 111 unit tests (BLoC, Repository, DataSource)
  - 34 integration tests (full-stack flows)
- **JSON test asset pattern** for realistic test data
- **Integration test helper classes** for full-stack testing
- **Mocktail fallback value registration** for complex types
- Test coverage for all critical paths

#### Shared Packages
- **starter_toolkit** (Pure Dart utilities)
  - Exception hierarchy with sealed classes
  - Repository executor decorators
  - ApiClient abstraction with type-safe generics
  - Date/time helpers (isToday, isTomorrow, isSameDay)
  - Validators (phone, email, password, URL)
- **starter_uikit** (Flutter UI components)
  - Status widgets (EmptyInformationBody, FailureWidgetLarge/Small, CustomCircularProgressIndicator)
  - Notification widgets (NotificationSnackBar)
  - Theme system (AppTheme, AppTextStyles, ThemeProvider)
  - Form widgets (AppTextField, AppDropdownField, AppCheckbox, AppDatePickerField)
  - Buttons (AppElevatedButton, AppOutlinedButton)
  - App bars (TitleAppBar, BaseAppBar, TransparentAppBar)
  - Exception mapper with decorator pattern
  
---

[1.0.0]: https://github.com/yourusername/flutter_starter/releases/tag/v1.0.0
