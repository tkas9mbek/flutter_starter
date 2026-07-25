# Engineering Context for AI Agents

> **Template**: Fill this in when starting a new app from the starter. Read it with
> `CLAUDE.md`/`AGENTS.md` and `docs/ai-context/` before making code changes.

<!-- Source snapshot: YYYY-MM-DD. Update the snapshot date when this doc changes. -->

## Stack

- Flutter app, package `<name>`, version `<x.y.z+n>`. <!-- from pubspec.yaml -->
- Flutter 3.44.5 via FVM; state: BLoC + Freezed sealed unions.
- Routing: `auto_route`; DI: GetIt modules extending `AppModule`.
- Networking: `DioApiClient` from `starter_toolkit`.
- Localization: `intl_utils`, generated `Localizer`, ARB files in `lib/l10n/`.
- Local packages: `starter_toolkit` (API client, exceptions, executors, validators),
  `starter_uikit` (theme, widgets), `starter_lints` (custom lint rules).

## Architecture

Feature layout: `lib/features/{feature}/` with `configs/`, `data/`, `domain/`, `model/`, `ui/`.

Rules that matter most:

- Domain owns abstract data-source contracts and concrete repositories (no abstract repositories).
- Data owns mock/API implementations; domain/data must not import Flutter.
- BLoCs must not depend on other BLoCs; coordinate via the UI layer.
- Package imports only in `lib/`; user-facing strings via `Localizer.of(context)`.

## Runtime Configuration

<!-- Base URLs from CoreConsts (dev/prod), registered API clients (authorized vs
     unauthorized, auth interceptor + token storage key), and how `useMock` toggles
     mock vs. API data sources per module. -->

## Feature Map

| Feature | Key code | Current data posture |
| --- | --- | --- |
| Application/root/shell | `features/application`, `core/router` | <!-- AutoRoute shell, auth wrappers --> |
| Auth | `features/auth` | <!-- mock/API, token storage --> |
| Task | `features/task` | <!-- calendar/list/details; mock or API --> |
| Profile | `features/profile` | <!-- --> |
| Settings | `features/settings` | <!-- local language/theme --> |
<!-- Add a row per new feature; keep "data posture" honest (mock, API, partial). -->

## Routing Map

<!-- Root routes and shell tabs. Starter baseline:
     - `/` login (initial), `/register`.
     - `/authenticated` with RootRoute tabs: calendar (initial), tasks, settings, profile.
     - Child flows above the shell: `task/:taskId`. -->

When adding a route, update `app_router.dart`, run build_runner, and keep generated files in sync.

## API Notes

<!-- Data-source paths relative to the base URL (which already includes the API version).
     List confirmed endpoints per feature, e.g.:
     - Auth: `/auth/login`, `/auth/register`.
     Then document flow-level contracts (token refresh, OTP order) and known caveats
     found in code comments (broken filters, polling intervals, naming mismatches). -->

## Testing And Commands

See `CLAUDE.md` "Essential Commands": `fvm flutter analyze`, `fvm dart run custom_lint`,
`fvm flutter test --concurrency 4`, and build_runner for codegen.

Run build_runner after changing routes, Freezed unions, or JSON models; `intl_utils` after ARB
changes; `generate_exception_mapper.dart` after adding `AppException` classes; `spider build`
(in `packages/starter_uikit`) after adding or renaming assets to regenerate `lib/resources/`.

## Agent Workflow

1. Read `CLAUDE.md`, then the relevant `docs/ai-context/*` files.
2. Inspect the feature module and existing mock/API data sources before editing.
3. Prefer `starter_uikit` widgets and `starter_toolkit` helpers over new local abstractions.
4. Add focused tests for changed BLoCs, data sources, and integration flows.
5. Run the narrowest useful verification; report anything not run.

<!-- Add a "Documentation Caveats" section if planning docs are deleted/stale, so agents
     know which files are durable starting points. -->
