# AGENTS.md

> **AI Context**: Canonical rules for any AI coding agent (Claude Code, Codex, Cursor, …) in this repository. Single source of truth — tool-specific files (e.g. `CLAUDE.md`) layer on top, they don't repeat it.

## Read This First

1. Start here for rules, commands, structure.
2. `docs/ai-context/` — per-topic rule-ID references: architecture, bloc, exception, repository_executor, rules (style/naming), mocking, pagination, polymorphism, testing, code_review, git, estimation. Open the relevant one before touching that area; IDs below (`A1`, `S1`, `T1`, `BLOC-1`, …) are keys into those files. Index: [docs/ai-context/README.md](docs/ai-context/README.md).
3. `docs/guides/` + `docs/rules/` — full prose. Source of truth if anything here conflicts.

## Project Overview

Flutter starter template: **Flutter 3.44.5** (`.fvmrc`, via FVM) · **State**: BLoC · **Navigation**: auto_route · **DI**: GetIt · three-layer architecture (Presentation → Domain → Data), strict dependency rules.

**Local packages** (`packages/`): `starter_toolkit` (utilities, exceptions), `starter_uikit` (widgets, theme), `starter_lints` (custom lint rules).

---

## Essential Commands

```bash
fvm flutter pub get                                                   # Install deps
fvm flutter run                                                       # Run app
fvm flutter analyze                                                   # Analyzer
fvm dart run custom_lint --no-fatal-infos --no-fatal-warnings         # Custom lints (soft)
fvm dart run custom_lint                                              # Custom lints (fatal warnings/infos)
fvm flutter test --concurrency 4                                      # Tests
fvm flutter test --coverage --concurrency 4                           # Tests + coverage
fvm flutter pub run build_runner build --delete-conflicting-outputs   # Routes / JSON / Freezed
dart run utils/generators/generate_exception_mapper.dart              # Exception mapper
fvm flutter --no-color pub global run intl_utils:generate             # Localization
cd packages/starter_uikit && spider build                             # Asset refs (UiSvgIcons, Images, fonts)
```

**Codegen triggers**: build_runner after router/JSON/Freezed changes (incl. BLoC events/states) · exception mapper after `AppException` changes · intl_utils after ARB edits · spider after assets change in `packages/starter_uikit` (config `packages/starter_uikit/spider.json`; NEVER hand-edit `packages/starter_uikit/lib/resources/`). Never hand-edit generated files.

**Localization**: `intl_utils`, English base (`intl_en.arb`), optional `intl_ru.arb`. Classes: `Localizer` (app), `ToolkitLocalizer`, `UikitLocalizer`. All user-facing strings via `Localizer.of(context)` (`A7`).

---

## Architecture — `docs/ai-context/architecture.md`

```
Presentation (Flutter, BLoC) → Domain (Repo, AbstractDS, Model) ← Data (DS impl, ApiClient)
```

| ID | Rule |
|---|---|
| A1 | Repositories are concrete facades over abstract DataSources — never make a repository abstract. |
| A2 | Abstract DataSource in `domain/`; implementations (api/local/mock) in `data/`. |
| A3 | BLoCs never depend on other BLoCs — coordinate at UI layer (`BlocListener`, route extras). |
| A4 | Repositories never depend on other repositories. |
| A5 | All deps wired via GetIt modules (`extends AppModule`) under `configs/`. |
| A6 | Errors crossing data → presentation are `AppException` (sealed class hierarchy). |
| A7 | User-facing strings via `Localizer.of(context)`. |
| A8 | Colors/typography via `ThemeProvider.of(context)`. |

Feature folder: `lib/features/{feature}/{data (+ mock/ twins), domain, model, configs, ui}`; `ui/` holds subfeature folders ONLY (`ui/{subfeature}/{bloc,screen,widget}`, ≥2 files) — layout detail in `architecture.md`. Example: `lib/features/task/ui/{list,details,calendar,search,create}/`.

Repo cross-cutting concerns (error handling, retry, cache): executors composed only in the DI module; caching is the `RepositoryCache` collaborator — see [repository_executor.md](docs/ai-context/repository_executor.md). Mock twins and `mockOrProd`: [mocking.md](docs/ai-context/mocking.md) (`M1`–`M10`). Paged lists: [pagination.md](docs/ai-context/pagination.md). Repeated enum switches: [polymorphism.md](docs/ai-context/polymorphism.md).

---

## Exceptions — `docs/ai-context/exception.md`

Two layers: `AppException` (sealed hierarchy, data/domain — BLoC stores **this**) → `ExceptionUiModel` (Equatable, localized; UI converts at render via `ExceptionUiMapper(context)`). BLoC catches `AppException`; UI renders `FailureWidget.large(exception:, onRetry:)`; snackbars via `NotificationSnackBar.showExceptionMessage(context, exception: ...)`.

New exception: `final class` subtype of `AppException` (overriding `name` + `canRetry`) with `@ExceptionUiConfig` in `starter_toolkit` → ARB key → run exception-mapper generator + intl_utils. Never hand-edit `ExceptionUiMapper*`.

---

## BLoC — `docs/ai-context/bloc.md`

`@freezed sealed class` for all events/states. State case classes **public** (`SuccessLoginState`), event case classes **private** (`_SubmittedLoginEvent`). Freezed 3 removed `.when()`/`.maybeMap()` — use `switch`/`if-case`/`is`. Run build_runner after editing events/states.

Handler rules (`BLOC-*`, see `code_review.md`): `return emit(state)` on the final emit · blank line before every `emit()` · descriptive names (`successState`, never `s`) · `isLoading`-style getters over repeated pattern matching · past-tense events (`.submitted()`, `.refreshed()`) · a `.refreshed()` event instead of re-extracting state to retry. State data that must persist across statuses → nested `CalendarStatus`-style sealed union inside a `@freezed abstract class` (examples in `bloc.md`).

---

## Testing — `docs/ai-context/testing.md`

Mock-first: test the `Mock*DataSource` path that ships. Optimize coverage-per-effort, not %.

| ID | Rule |
|---|---|
| T1 | No per-repository unit test — delegation is proven by the feature-flow test. |
| T2 | Feature-flow test (BLoC → Repo → `Mock*DataSource`) is **mandatory per feature**: happy path + one `state.exception != null`/failure-state case. |
| T3 | Repository executor (error/retry/cache) tested once, centrally. Retry timing lives here. |
| T4 | Build expected models via a per-feature `*MockModels` builder from `assets/*.json`, never inline. |
| T5 | `registerFallbackValue` in `setUpAll` for every custom type used in `any(named:)` (incl. `HttpMethod`, the `fromJson` function type). |
| T6 | `blocTest` `wait:` is for debounce only — assert failures with an immediately-throwing repo/DS; never sit through retry backoff (`T3`). |
| T7 | Widget smoke: `(widget, state)` table → loop, not N hand-written `testWidgets`. |
| T8 | Coverage excludes `*.g.dart`, `*.freezed.dart`, `main.dart`, DI module files. |

Layout: `test/features/{feature}/{assets,model,data,bloc,integration}/`, helpers in `test/support/`.

---

## Code Style — `docs/ai-context/rules.md`

| ID | Rule |
|---|---|
| S1 | Trailing commas everywhere they'd improve formatting. |
| S2 | Single quotes. |
| S3 | Package imports only inside `lib/` and `packages/*/lib/` — no relative imports. |
| S4 | Arrow `=>` always, except `build()`, nested callbacks, and `if-case` listener bodies — write `onPressed: () { setState(() {...}); }`, never arrow-in-arrow. |
| S5 | Spread in collections: `if (cond) ...[Widget()]`, even for one widget. |
| S6 | `final` for locals by default (type omitted); `var` only when genuinely reassigned. |
| S7 | `if (!context.mounted) return;` after every `await` that uses `BuildContext`. |
| S8 | Tell, don't ask — rule in a named getter/method on the model/state/enum (`task.isOverdue(now)`), not re-derived from raw fields at each call site. |
| S9 | A serialized (`fromJson`) enum has an `unknown` member + `@JsonKey(unknownEnumValue: X.unknown)` so new backend values don't throw. |

Class size: target <100 lines, split at >200. Never `Widget _buildFoo()` — extract a class. Comments: none unless the *why* is non-obvious; `///` only for public APIs in `starter_*` packages (1–3 lines). Naming: no `Impl`/`Model`/`Helper`/`Manager`/`Data`/`Info`/`Util` suffixes (`*UiModel` allowed); BLoCs are nouns; file name == class name.

---

## Reusing Toolkit & UIKit

Check before writing anything new; never re-implement.

- **starter_toolkit**: `DateTimeHelpers`, date formatting (`getLocalizedDateLabel`, `getFormattedTimeRange`), validators, `AppException` hierarchy.
- **starter_uikit**: status (`EmptyInformationBody`, `FailureWidget.large/.small`, `CustomCircularProgressIndicator.adaptive`, `AppStatusScreen`), `NotificationSnackBar`, theme (`AppTheme`, `AppTextStyles`, `ThemeProvider`), app bars (`TitleAppBar`, `BaseAppBar`, `TransparentAppBar`), forms (`AppTextField`, `AppDropdownField`, `AppCheckbox`, `AppDatePickerField`), buttons (`AppElevatedButton`, `AppOutlinedButton`). Shared-widget rules: `docs/rules/uikit.md`.
- **Imports**: the specific file (`package:starter_uikit/widgets/app_bar/title_app_bar.dart`) — no barrel exports.
- **Forms**: never bare `FormBuilder*` fields. Multi-field screens → `FormBuilder` + `AppTextField`/`App*PickerField`; single-field (search) → `ControllerTextField` + `ValidatableTextEditingController`.

**Reference implementations**: `lib/features/task/` is the canonical end-to-end example (BLoC states, exceptions, forms, executor wiring, pagination, mock twins). `packages/starter_uikit/lib/example/` is the live widget gallery — in a debug build tap the hidden `DevModeActivator` (7 taps) → "UI Kit Examples". Read both before writing a new feature or widget.

---

## Git — `docs/ai-context/git.md`

Branches: `<category>/[<TICKET-ID>_]<kebab-case>`, category ∈ `feature/fix/refactor/research/release`; ticketed work always `feature/`.
Commits: `TICKET-ID: Capitalized imperative` or `type: Capitalized imperative` (optional scope: `feat(starter_lints): …`) — ≤72 chars, no trailing period, one logical change each. `type` ∈ `feature|feat, fix, refactor, research, release, docs, style, test, chore`.

---

## Hard Rules Checklist

1. Check `docs/ai-context/` before coding in an unfamiliar area; reuse toolkit/uikit first.
2. Never create files unless necessary; never proactively create docs unless asked.
3. Sort `pubspec.yaml` deps: SDK first, then alphabetical (no version constraints in workspace-package pubspecs).
4. Pattern-match (`switch`/`if-case`/`is`) on sealed states — no `.when()`.

## Common Issues

| Symptom | Fix |
|---|---|
| "Dependencies not sorted alphabetically" | SDK deps first, then alphabetical in `pubspec.yaml`. |
| `use_build_context_synchronously` | `if (!context.mounted) return;` after the `await` (`S7`). |
| `omit_local_variable_types` | Drop the annotation — `final x = ...`. |
| `MissingStubError` in integration tests | Register fallback values in `setUpAll` (`T5`). |
| Retry test timeout / flaky | Assert failure with an immediately-throwing repo/DS (`T6`); retry timing is the central executor test (`T3`). |

---

## Documentation Map

| File | Topic |
|---|---|
| [docs/ai-context/architecture.md](docs/ai-context/architecture.md) | Layers, DI, codegen, feature folders |
| [docs/ai-context/bloc.md](docs/ai-context/bloc.md) | BLoC + Freezed patterns |
| [docs/ai-context/exception.md](docs/ai-context/exception.md) | Exception model + codegen |
| [docs/ai-context/repository_executor.md](docs/ai-context/repository_executor.md) | Executor composition, caching, testing |
| [docs/ai-context/rules.md](docs/ai-context/rules.md) | Style, naming, forbidden patterns |
| [docs/ai-context/mocking.md](docs/ai-context/mocking.md) | `Mock*DataSource` twins, scenarios, `MockNetworkBehavior` |
| [docs/ai-context/pagination.md](docs/ai-context/pagination.md) | `PaginatedData`, load-more, refresh |
| [docs/ai-context/polymorphism.md](docs/ai-context/polymorphism.md) | Sealed/UI-model patterns instead of repeated enum switches |
| [docs/ai-context/testing.md](docs/ai-context/testing.md) | Test layout + mocktail rules |
| [docs/ai-context/code_review.md](docs/ai-context/code_review.md) | Severity-tagged rule-ID checklist (ARCH/BLOC/EXC/UI/NAME/FILE/PAG/MODEL/REUSE/TEST/STYLE) |
| [docs/ai-context/git.md](docs/ai-context/git.md) | Branch / commit / PR format |
| [docs/ai-context/estimation.md](docs/ai-context/estimation.md) | Story-point model |
| [docs/guides/deployment.md](docs/guides/deployment.md) | CI/CD: TestFlight + Firebase App Distribution, secrets, fastlane |
| [docs/guides/ai_agent.md](docs/guides/ai_agent.md) | AI agents: context layers, subagent/command choice, `work/` savepoints |
| [docs/rules/uikit.md](docs/rules/uikit.md) | `starter_uikit` rules: token-only theming, folder layout, gallery + test per widget |

Full prose: `docs/guides/`, `docs/rules/`. If a rule here conflicts with a full guide, the guide wins — flag it. Starting a new app from this starter: fill in the templates under `docs/project/`.
