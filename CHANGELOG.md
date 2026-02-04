# Changelog

All notable changes to this project will be documented in this file.

## [2.0.1] - 2026-02-01

### Fixed
- **CLAUDE.md** - Corrected BLoC documentation to reflect Freezed patterns (not native Dart 3)
- **starter_lints** - Added missing `resolution: workspace` field

---

## [2.0.0] - 2026-02-01

### Added
- **Custom Lint Rules** (`starter_lints` package): `avoid_widget_functions`, `prefer_arrow_except_build`, `always_spread_in_collections`, `bloc_no_bloc_dependency`, `blank_line_before_return`, `prefer_named_parameters`, `sort_constructor_params`

### Changed
- Enhanced `analysis_options.yaml` with categorized rules
- Added `custom_lint` plugin integration

### Fixed
- Removed duplicate localization directory
- Fixed constructor ordering in BLoC files

---

## [1.0.0] - 2026-01-24

### Added
- **Architecture**: Three-layer Clean Architecture with Repository Executor pattern (error handling, retry, caching decorators)
- **State Management**: BLoC + Freezed with nested status pattern
- **Exception Handling**: Two-layer system (domain exceptions + UI models with localization)
- **Features**: Authentication, Task Management (CRUD, calendar, list), Profile, Settings (theme/language)
- **Testing**: 145 tests (111 unit + 34 integration)
- **Packages**: `starter_toolkit` (utilities, validators, API client), `starter_uikit` (theme, widgets, forms)

---

[2.0.1]: https://github.com/tkas9mbek/flutter_starter/releases/tag/v2.0.1
[2.0.0]: https://github.com/tkas9mbek/flutter_starter/releases/tag/v2.0.0
[1.0.0]: https://github.com/tkas9mbek/flutter_starter/releases/tag/v1.0.0
