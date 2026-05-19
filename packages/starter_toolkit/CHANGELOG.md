# Changelog

All notable changes to starter_toolkit will be documented in this file.

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
