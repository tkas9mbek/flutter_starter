# Changelog

All notable changes to starter_toolkit will be documented in this file.

## [4.0.0] - 2026-07-25

### Added
- `RepositoryCache` collaborator interface and `InMemoryRepositoryCache` — keyed
  TTL cache with lazy, sweep-on-write eviction; inject as an app-wide singleton

### Removed
- **Breaking**: `CachingExecutor` and the `withCaching()` extension — caching is
  no longer a decorator. Use the `RepositoryCache` collaborator instead

## [3.0.0] - 2026-07-08

### Added
- `RefreshableBloc` mixin (drives `MultiBlocRefreshIndicator`), `Debouncer`, `SemanticVersion`
- `ValidatableTextEditingController` with `validateAll` for single-field screens
- `saveAndValidateForm` — validates a FormBuilder form and scrolls to the first invalid field (replaces `focusOnInvalidStateField`)
- Expanded form validators (required, url, email, password, phone) and phone input formatters

### Changed
- **Breaking**: SDK `^3.12.0`; models regenerated for Freezed 3
- **Breaking**: `repository_executor.dart` no longer re-exports the executor files — import `raw_repository_executor.dart` and `repository_executor_extensions.dart` directly

## [2.1.0] - 2026-05-14

### Changed
- Updated package version to align with the main app `2.1.0` release
- Hardened API client interceptor error normalization and auth refresh behavior
- Preserved repository executor and utility APIs while improving release-readiness docs

## [2.0.0] - 2025-02-01

### Changed
- Updated to match main app version 2.0.0
- Improved code formatting and style consistency

### Maintained
- **Exception Handling System**
  - `AppException` sealed class hierarchy
  - `@ExceptionUiConfig` annotation for UI configuration
  - Type-safe exhaustive pattern matching
- **Repository Executor Pattern**
  - `RawRepositoryExecutor` base implementation
  - `ErrorHandlingExecutor` - Normalizes exceptions to `AppException`
  - `RetryExecutor` - Automatic retry with exponential backoff
  - `CachingExecutor` - Time-based caching with automatic cleanup
- **ApiClient Abstraction**
  - Type-safe generic HTTP methods
  - Interceptor support (auth refresh, error handling)
- **Utilities**
  - Date/time helpers (isToday, isTomorrow, isSameDay)
  - Form validators (phone, email, password, URL)
  - Input formatters and converters

## [1.0.0] - 2025-01-24

### Added
- Initial release with core utilities
- Exception handling infrastructure
- Repository executor decorators
- ApiClient abstraction
- Date/time and form utilities
