# Changelog

All notable changes to this project will be documented in this file.

## [3.2.0] - 2026-10-21

### Added
- `AppForm` in `starter_uikit`: a `FormBuilder` that stays quiet until the first submit, then re-validates fields as the user edits them (`saveAndValidate()`, `validateField(name)`); login, registration and task create use it
- `TaskRepository.changes`: a stream that fires after a task is created, updated or deleted; the task list, calendar and search blocs listen and reload
- `docs/guides/common_problems.md`: recipes for sign-out, stale data across screens (repository stream or pop with a result), form errors and large text
- `TaskCreateForm.endsAfterStart` and a localized `endTimeMustBeAfterStart` message: the create form rejects an end time that is not after the start time
- `hasLargeText` in `starter_uikit` (`TextScaleContext`)

### Changed
- **Breaking**: `AuthAuthorizedDataSource.logout` takes the `AuthToken` to revoke; `AuthRepository.logout` clears local storage right away and sends the server request in parallel
- `TaskRepository` is a lazy singleton (it owns the `changes` stream) and the task screens no longer reload by hand after a create or delete
- The auth interceptor keeps an explicit `Authorization` header instead of overwriting it from storage
- The environment banner is a slim strip above the app instead of a pill over the app-bar title
- `AppBaseButton.height` is a minimum height, so large text grows the button instead of clipping the label
- Date, time and dropdown fields use the same "Required field" message as text fields; "coming soon" messages use the information snackbar
- Swiping a task away asks for confirmation, like the details screen
- Guides, READMEs and AI-context docs updated for `AppForm`, the repository `changes` stream and the new `logout` signature (`AGENTS.md`, `code_review`, `testing`, `repository_executor`, `pagination`, `uikit` rules, package READMEs)

### Fixed
- A failed logout request left the token on the device, so the next launch signed the user back in
- Deleting a task from the details screen did not update the task list, calendar or search results behind it
- Form field errors stayed on screen after the user fixed the field
- The task details date was always formatted in Russian
- The calendar timeline listed tasks in insertion order instead of by start time
- Tapping a recent search left the search box empty
- Overflow and mid-word wrapping at accessibility text sizes (tab bar, calendar, tiles, buttons, list headers)

## [3.1.0] - 2026-10-19

### Added
- Flat navy design system in `starter_uikit`: new `AppColors` palette (navy brand, blue-tinted slate/ink neutrals, cyan secondary), `AppRadii` radius scale, a 28px title style, and role tokens `accent`, `onSecondary`, `borderStrong`, `successText` and `errorText` on `AppTheme` — navy is the primary color in both themes, status fills are dark green / dark red
- Shared widgets `AppCard`, `GroupedRowsCard`, `AppListTile` and `StatusPill`, with gallery sections and behavior tests
- `TextFieldVisualState` — one place that resolves a text field's idle / focused / error / disabled look — and the shared `FieldErrorText`
- `request_logger` package: in-app HTTP request logger (list, details, JSON view, redaction) wired into Dio and the environment banner
- `MockNetworkBehavior` in `starter_toolkit` for configurable mock latency and failures; mock data sources keep canned data in `mock_*_scenarios.dart` and are picked in DI with `mockOrProd`
- Crashlytics reporting behind `FirebaseConfig`
- CI/CD pipeline for TestFlight and Firebase App Distribution (`docs/guides/deployment.md`)
- `AppStatusScreen` and a "UI Kit Examples" entry in the dev menu
- Mocking, pagination and polymorphism guides, `docs/rules/uikit.md`, and the `planner` agent and `split-large-widget` skill for Claude Code
- Behavior tests for the shared uikit widgets, settings screen and request logger UI
- `AppTapArea` in `starter_uikit` (`InkWell` plus button semantics, no splash), with a gallery section and behavior test; localized `clearField` / `togglePasswordVisibility` screen-reader labels
- `BLOC-14` and `UI-13` review rules, `POLY-10` (`@nonVirtual` template methods), a docs-prose rule in `AGENTS.md`, and `pumpTall()` / `visibleTexts()` test helpers

### Changed
- **Breaking**: flat design everywhere — no shadows, elevation, ripples or surface tint; the app bar and scaffold share `theme.background`, and cards, sheets, dialogs, fields and snackbars are separated by 1px borders. `AppTheme` gains new tokens and `AppColors` is a new palette
- **Breaking**: the old `AppColors` names (`mainBlue`, `darkBlue`, `pureWhite`, …) are gone; widgets must read `AppTheme` tokens
- **Breaking**: remote data sources renamed `Remote*` → `Api*`; mocks moved to `data/mock/`
- `FilledTextFieldDecoration.hasBorder` is deprecated and ignored (fields are always bordered)
- Restyled every uikit widget (app bars, bottom nav, buttons, bottom sheets, form fields, checkbox/radio groups, snackbars, status screens, shimmer, avatars) and the widget gallery; `DropdownBottomSheet` options are now selectable cards, and `TitleSubtitle` uses `mediumTitle24`
- Redesigned auth, profile, settings, task (list, calendar, details, search, create), root navigation and request logger screens on `AppCard` / `GroupedRowsCard` / `AppListTile` / `StatusPill`; task rows show their time range and status pill instead of the description
- Request logger status pills are colored by HTTP class (2xx green, 4xx orange, 5xx/failed red)
- Feature tests migrated to mock-first feature-flow tests; documentation reorganized (`code_standards` / `code_preferences` split, contradictions and stale references fixed, jetjat_mobile fixes synced)

- Package versions: `starter_uikit` and `starter_toolkit` aligned to 3.1.0 (uikit has breaking theme/palette changes), new `request_logger` 0.1.0
- CI runs the `starter_uikit` and `request_logger` test suites; package READMEs and changelogs, guides, rules and AI-context docs brought up to date
- **Breaking**: `withRetry(maxRetries:)` / `RetryExecutor.maxRetries` renamed to `maxAttempts` — it always counted total calls (first call plus retries), so `3` meant two retries; the executor now asserts `maxAttempts >= 1`
- `UnknownException.canRetry` is now `false` (retrying a bug only repeats it); `ExceptionUiMapper` regenerated to match
- Submit, resend and delete handlers (`LoginBloc`, `RegistrationBloc`, `OtpBloc`, `TaskCreationBloc`, `TaskDeleteBloc`) use `droppable()`, so a second tap while a request runs is ignored
- `AppCard`, `AppListTile`, `AppCheckboxField`, the text-field clear / show-password icons and the calendar date item are tappable through `AppTapArea` (reachable by screen readers and keyboard)
- The app shell (`Application`, `ThemedMaterialApp`) composes providers and the `GlobalRouteWrapper` / `ApplicationWrapper` with `Nested` (`nested` is now a direct dependency); both wrappers are `SingleChildStatelessWidget`s
- `TapActivator` moved from `starter_uikit` into the app (`features/application/environment/ui/switcher/widget/`) — it only serves the hidden dev menu
- BLoC rules live only in `docs/rules/bloc.md`; the `freezed_bloc` and `ai_agent` guides were removed (the ai-context maintenance notes moved to `docs/ai-context/README.md`)

### Removed
- Hand-rolled `SettingsCard`, `SettingsTile`, `ProfileInfoTile` and the gallery `ExampleTile`, superseded by the shared widgets
- Per-repository unit tests superseded by the feature-flow tests
- CocoaPods leftovers from the iOS Runner project

### Fixed
- Registration screen was titled "Login"
- Search icon rendered as a solid disk (replaced with a stroked magnifier)
- Mock tasks did not persist because each repository got its own `TaskDataSource`
- Error cause was lost in `AppException` and the request logger — error type, message and server body are now shown
- Auth token save bypassed the repository executor
- Swift 6 build errors from `app_settings` (overridden)

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
