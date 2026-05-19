# Changelog

All notable changes to this project will be documented in this file.

## [2.1.0] - 2026-05-14

### Added
- GitHub Actions CI for linting, analyzer checks, and parallelized per-feature test shards
- Shared app version constant (`CoreConsts.appVersion`) surfaced in the settings UI and release-prep documentation
- `starter_lints` rules: `avoid_build_context_field`, `avoid_mutable_bloc_fields`, `braces_in_flow_control`, `no_flutter_in_data_domain`, `no_hardcoded_colors`, `prefer_bool_default`, `prefer_map_or_null`, `avoid_naming_antipatterns`, `bloc_listener_builder_usage`, `class_size_warning`, `max_widget_nesting`, `multi_line_ternary`, `theme_in_build_only`
- `AGENTS.md` and restructured documentation: human-facing `docs/guides/`, AI-context cheat sheets `docs/ai-context/`, and consolidated `docs/rules/` (new code-review, estimation, Freezed/BLoC, git-workflow, and coding-rules guides)

### Changed
- Stabilized runtime environment reconfiguration to avoid no-op churn and concurrent DI races
- Hardened interceptor and auth-refresh error flow behavior across 401 and logout paths
- Centralized DI unregister helpers and made auth/data re-registration safer and idempotent
- Removed template leakage from product-specific bootstrap values and refreshed bootstrap guidance
- Improved AI-facing and human-facing documentation for architecture, testing, naming, and release workflow
- Refactored unit, BLoC, and integration suites onto shared JSON fixture helpers; rebalanced CI test shards
- Regenerated localization (`intl`) output for the app, `starter_toolkit`, and `starter_uikit`

### Removed
- `starter_lints` rule `prefer_named_parameters`

### Fixed
- Pinned lint pipeline compatibility so `custom_lint` runs reliably in CI and local development
- Cleared warning-level lint debt and stabilized the optional strict lint gate behavior

## [2.0.1] - 2026-02-01

### Fixed
- **CLAUDE.md** - Corrected BLoC documentation to reflect Freezed patterns (not native Dart 3)
- **starter_lints** - Added missing `resolution: workspace` field

---

## [2.0.0] - 2026-02-01

### Added
- **Custom Lint Rules** (`starter_lints` package): `avoid_widget_functions`, `prefer_arrow_except_build`, `always_spread_in_collections`, `bloc_no_bloc_dependency`, `blank_line_before_return`, `sort_constructor_params`

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

[2.1.0]: https://github.com/tkas9mbek/flutter_starter/releases/tag/v2.1.0
[2.0.1]: https://github.com/tkas9mbek/flutter_starter/releases/tag/v2.0.1
[2.0.0]: https://github.com/tkas9mbek/flutter_starter/releases/tag/v2.0.0
[1.0.0]: https://github.com/tkas9mbek/flutter_starter/releases/tag/v1.0.0
