# Changelog

All notable changes to this project will be documented in this file.

## [3.0.0] - 2026-07-25

### Added
- OTP verification flow: request/verify endpoints, `OtpBloc`, `OtpScreen` with resend countdown, linked from login via "Sign in with code"
- Task search: debounced type-ahead (`restartable()` + `emit.isDone`), recent-query history, paginated results (`PaginatedListItems` + `PaginatedData`)
- Task creation screen: FormBuilder form with `TaskCreationBloc` (single `submitted(form)` event, standard sealed state) and uikit date/time bottom sheets
- Push notifications core module (Firebase/mock messaging + token repository) and remote config core module (typed registry, JSON asset defaults) — Firebase paths ship as examples behind the disabled `FirebaseConfig.enabled` toggle
- `AuthState.newUser()` first-launch state; pull-to-refresh via `MultiBlocRefreshIndicator` on list screens; shimmer loading states (`AppShimmer` + `AppShimmerBox`/`Circle`/`Text` primitives)
- `PagedResponse<T>` Spring Data page model in `core/data`
- `docs/project/` product/engineering context templates and `work/` porting-analysis notes
- UIKit widget smoke-test table (`test/uikit/`), now actually run in CI alongside `test/core/`
- `RepositoryCache` collaborator (+ `InMemoryRepositoryCache`): keyed, TTL-based caching for repositories, injected alongside an executor instead of wrapped in its decorator chain
- Dedicated Repository Executors guide (`docs/guides/repository_executor.md` + `docs/ai-context/repository_executor.md`), split out of the exception-handling guide, documenting the "compose per-method executors in the DI module, never in the repository" convention
- Full icon set (22 icons) sourced from the real Figma design library, replacing the prior ad hoc/hand-authored SVGs — consistent sizing, weight, and color across the set
- `starter_toolkit`'s first test suite

### Changed
- **Breaking**: Flutter 3.44.5 / Dart 3.12; Freezed 3 sealed-class migration (public state case classes, `switch` pattern matching); auto_route 11, get_it 9, analyzer 8
- **Breaking**: DI modules implement `register()` with declarative `unregisterCallbacks`; `getIt` moved to `core/global/global_variables.dart`; `core/consts` merged into `core/global`; GetIt instance names in `InstanceNames`
- **Breaking**: `ui/` folders contain logic-separated subfeatures only (`profile/ui/overview/`, `environment/ui/switcher/`)
- **Breaking**: every feature bloc now registers via `registerFactory` in its feature module and resolves via `getIt` at the screen — the only exceptions are the app-shell blocs (`AuthBloc`, `EnvironmentCubit`, `LanguageCubit`, `ThemeCubit`), which stay composition-root-constructed because they drive or must survive DI reconfiguration
- Form rules: multi-field screens use FormBuilder + `App*Field`; single-field screens use `ControllerTextField` + `ValidatableTextEditingController`
- Store-ready manifests: `INTERNET`/`POST_NOTIFICATIONS` permissions, `allowBackup=false`, encryption exemption, photo/camera usage descriptions
- iOS minimum deployment target 15.0; UIScene lifecycle and Swift Package Manager migration
- Native splash/launcher icons generated manually from `assets/external/logo.png`
- Mock data source delays standardized at 2 seconds
- `NotificationSnackBar` moved under `widgets/status/`
- Oversized widgets (custom_lint's `class_size_warning`/`max_widget_nesting`) extracted into their own files across the app shell, auth, and task screens

### Removed
- **Breaking**: `starter_uikit.dart` barrel and repository-executor re-exports — all imports are file-specific
- **Breaking**: `CachingExecutor`/`withCaching()` from `starter_toolkit` — caching is no longer a decorator; use the `RepositoryCache` collaborator
- `flutter_native_splash` and `flutter_launcher_icons` (configs and dependencies)
- `TilesShimmer`, superseded by the composable `AppShimmer` primitives

### Fixed
- Release Android builds had no network access (`INTERNET` permission was only in debug/profile manifests)
- `prodBaseUrl`/`devBaseUrl` were identical placeholders, making environment switching silently a no-op — now distinct, with a debug-only assert guarding against shipping the placeholder to a real environment
- Startup auth check swallowed every exception with a bare `catch`, masking real failures (e.g. storage corruption) as a plain "signed out"
- Bloc DI wiring was self-contradictory (some blocs registered but bypassed, some never registered, auth/profile built manually) — see the DI **Breaking** change above
- CI's test matrix silently excluded `test/core/` and `test/uikit/`
- All remaining Material `Icon`/`Icons` usages (app screens and inside `starter_uikit` itself) replaced with `SvgIcon`, closing out the design system's own documented ban
- Various documentation gaps: broken links, a stale lint-count claim (13 vs. the actual 19), an unlinked duplicate doc-map file

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
