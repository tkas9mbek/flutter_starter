# AGENTS.md

> **AI Context**: Canonical rules for any AI coding agent (Claude Code, Codex, Cursor, …) working in this repository. This is the single source of truth — tool-specific files (e.g. `CLAUDE.md`) layer on top of it, they don't repeat it.

## Read This First

1. Start here for operational rules, commands, and structure.
2. `docs/ai-context/` — per-topic rule-ID references (architecture, bloc, exception, repository-executor, testing, style/naming, code review, git, estimation). Read the relevant one before touching that area; rule IDs below (`A1`, `BLOC-1`, `S1`, `T1`, …) are keys into those files.
3. `docs/guides/` + `docs/rules/` — full prose. Source of truth if anything here conflicts.

## Project Overview

Flutter starter template:
- **Flutter 3.44.5** (managed via FVM) · **State**: BLoC · **Navigation**: auto_route · **DI**: GetIt
- **Architecture**: three-layer (Presentation → Domain → Data) with strict dependency rules

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

**Codegen triggers**: build_runner after router/JSON/Freezed model changes (incl. BLoC events/states) · exception mapper after `AppException` changes · intl_utils after ARB edits · spider after assets change in `packages/starter_uikit` (config: `spider.json`; NEVER hand-edit `lib/resources/`).

**Localization**: `intl_utils`, English base (`intl_en.arb`), optional `intl_ru.arb`. Classes: `Localizer` (app), `ToolkitLocalizer`, `UikitLocalizer`. ALL user-facing strings go through `Localizer.of(context)` — no hardcoded strings (rule `A7`).

---

## Architecture — `docs/ai-context/architecture.md`

```
Presentation (Flutter, BLoC) → Domain (Repo, AbstractDS, Model) ← Data (DS impl, ApiClient)
```

| ID | Rule |
|---|---|
| A1 | Repositories are concrete facades over abstract DataSources — never make a repository abstract. |
| A2 | Abstract DataSource in `domain/`; implementations (remote/local/mock) in `data/`. |
| A3 | BLoCs never depend on other BLoCs — coordinate at UI layer (`BlocListener`, route extras). |
| A4 | Repositories never depend on other repositories. |
| A5 | All deps wired via GetIt modules (`extends AppModule`) under `configs/`. |
| A6 | Errors crossing data → presentation are `AppException` (sealed, Freezed). |
| A7 | User-facing strings via `Localizer.of(context)`. |
| A8 | Colors/typography via `ThemeProvider.of(context)`. |

Cross-cutting repo concerns: modules compose one executor per distinct behavior from a single local `base = const RawRepositoryExecutor().withErrorHandling()` (`withErrorHandling()` innermost) and inject via constructor params; repositories never compose. Caching is the `RepositoryCache` collaborator, not a decorator — see [docs/ai-context/repository_executor.md](docs/ai-context/repository_executor.md). New shared widget/util → check `starter_uikit`/`starter_toolkit` first.

**Feature folder:**
```
lib/features/{feature}/
├── data/        # DS impl (remote/local/mock)
├── domain/      # AbstractDS + Repository
├── model/       # domain models
├── configs/     # GetIt module
└── ui/          # subfeature folders ONLY — no flat bloc/screen/widget
```
`ui/{subfeature}/` holds `bloc/`, `screen/`, `widget/` (+ `model/` for forms), ≥2 files (bloc+screen, or screen+extracted widgets). Cross-subfeature widgets → `starter_uikit` or the owning subfeature. Example: `lib/features/task/ui/{list,details,calendar,search,create}/`.

---

## Exceptions — `docs/ai-context/exception.md`

Two layers: `AppException` (sealed Freezed, data/domain — BLoC stores **this**) → `ExceptionUiModel` (Equatable, localized, UI converts at render via `ExceptionUiMapper(context)`).

```dart
try {
  final data = await _repository.getData();

  return emit(MyState.success(data));
} on AppException catch (e) {
  return emit(MyState.failure(e));
}

// UI
builder: (context, state) => switch (state) {
  SuccessMyState(:final data) => SuccessView(data: data),
  FailureMyState(:final exception) => FailureWidget.large(exception: exception, onRetry: _retry),
  InitialMyState() || LoadingMyState() => const CustomCircularProgressIndicator.adaptive(),
}
```

New exception: sealed factory + `@ExceptionUiConfig` in `starter_toolkit` → add ARB key → run the exception-mapper generator + intl_utils. Never hand-edit `ExceptionUiMapper*`. Snackbars: `NotificationSnackBar.showExceptionMessage(context, exception: ...)`.

---

## BLoC — `docs/ai-context/bloc.md`

`@freezed sealed class` for all events/states. States: case classes **public** (`SuccessLoginState`). Events: case classes **private** (`_SubmittedLoginEvent`). Freezed 3 removed `.when()`/`.maybeMap()` — use `switch`/`if-case`/`is` on the sealed classes. Run build_runner after editing events/states.

```dart
@freezed
sealed class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial() = InitialLoginState;
  const factory LoginState.loading() = LoadingLoginState;
  const factory LoginState.success() = SuccessLoginState;
  const factory LoginState.failure(AppException exception) = FailureLoginState;

  bool get isLoading => this is LoadingLoginState;
}
```

Handler rules (`BLOC-*`, see `code_review.md`): `return emit(state)` on the final emit · blank line before every `emit()` · descriptive names (`successState`, never `s`) · `isLoading`-style getters over repeated pattern matching · events past-tense (`.submitted()`, `.refreshed()`). For state with data that must persist across statuses, nest a `CalendarStatus`-style sealed union inside a `@freezed abstract class CalendarState` (full example in `bloc.md`). Add a `.refreshed()` event instead of re-extracting state to re-dispatch.

---

## Testing — `docs/ai-context/testing.md`

Mock-first: test the `Mock*DataSource` path that ships. Optimize coverage-per-effort, not %.

| ID | Rule |
|---|---|
| T1 | No per-repository unit test — delegation is proven by the mandatory feature-flow test. |
| T2 | Feature-flow test (BLoC → Repo → `Mock*DataSource`) is **mandatory per feature**: happy path + one `state.exception != null` case. |
| T3 | Repository executor (error/retry/cache) tested once, centrally — never per-repo. |
| T4 | Build expected models via a per-feature `*MockModels` builder from `assets/*.json`, never inline. |
| T5 | `registerFallbackValue` in `setUpAll` for every custom type used in `any(named:)` (incl. `HttpMethod`, the `fromJson` function type). |
| T6 | `blocTest` `wait:` matches the retry config used (`~8s` for `2s×3`, `~300ms` for `10ms×3`) — never sit through retry backoff to assert a failure. |
| T7 | Widget smoke: `(widget, state)` table → loop, not N hand-written `testWidgets`. |
| T8 | Coverage excludes `*.g.dart`, `*.freezed.dart`, `main.dart`, DI module files. |

Layout: `test/features/{feature}/{assets,model,data,bloc,widget,integration}/`, shared helpers in `test/support/`.

---

## Code Style — `docs/ai-context/rules.md`

| ID | Rule |
|---|---|
| S1 | Trailing commas everywhere they'd improve formatting. |
| S2 | Single quotes. |
| S3 | Package imports only in `lib/` — no relative imports. |
| S4 | Arrow `=>` always, except `build()` and nested callbacks (`() => setState(() {})`). |
| S5 | Spread in collections: `if (cond) ...[Widget()]`, even for one widget. |
| S6 | `var` for locals where the type is inferable. |
| S7 | `if (!context.mounted) return;` after every `await` that uses `BuildContext`. |

Class size: target <100 lines, split at >200. Never `Widget _buildFoo()` — extract to a class. Comments: none unless the *why* is non-obvious; `///` only for public APIs in `starter_*` packages (1-3 lines). Naming: no `Impl`/`Model`/`Helper`/`Manager`/`Data`/`Info`/`Util` suffixes; BLoCs are nouns; file name == class name.

---

## Reusing Toolkit & UIKit

Check before writing anything new.

- **starter_toolkit**: `DateTimeHelpers` (`isToday`, `isTomorrow`, `isSameDay`), date formatting (`getLocalizedDateLabel`, `getFormattedTimeRange`), validators (phone/email/password/URL), `AppException` hierarchy.
- **starter_uikit**: status (`EmptyInformationBody`, `FailureWidget.large/.small`, `CustomCircularProgressIndicator.adaptive`), `NotificationSnackBar`, theme (`AppTheme`, `AppTextStyles`, `ThemeProvider`), app bars (`TitleAppBar`, `BaseAppBar`, `TransparentAppBar`), forms (`AppTextField`, `AppDropdownField`, `AppCheckbox`, `AppDatePickerField`), buttons (`AppElevatedButton`, `AppOutlinedButton`).
- **Imports**: always the specific file (e.g. `package:starter_uikit/widgets/app_bar/title_app_bar.dart`) — no barrel exports.
- **Forms**: never bare `FormBuilder*` fields directly. Multi-field screens → `FormBuilder` + `AppTextField`/`App*PickerField`. Single-field (e.g. search) → `ControllerTextField` + `ValidatableTextEditingController`.

---

## Git — `docs/ai-context/git.md`

Branches: `<category>/[<TICKET-ID>_]<kebab-case>` where category ∈ `feature/fix/refactor/research/release`. Ticketed work always uses `feature/`.
Commits: `TICKET-ID: Capitalized imperative` or `type: Capitalized imperative` — ≤72 chars, no trailing period, one logical change per commit.

---

## Hard Rules Checklist

1. Check `docs/ai-context/` before coding in an unfamiliar area.
2. Reuse `starter_toolkit`/`starter_uikit` before writing new widgets/utilities.
3. Never create files unless necessary; never proactively create docs unless asked.
4. Sort `pubspec.yaml` deps: SDK first, then alphabetical.
5. Use Dart pattern matching (`switch`/`if-case`/`is`) on sealed states — Freezed 3 has no `.when()`.

---

## Common Issues

| Symptom | Fix |
|---|---|
| "Dependencies not sorted alphabetically" | SDK deps first, then alphabetical in `pubspec.yaml`. |
| `use_build_context_synchronously` | Add `if (!mounted) return` after the `await`. |
| `omit_local_variable_types` | Use `var` for locals. |
| `MissingStubError` in integration tests | Register fallback values in `setUpAll` (`T5`). |
| Retry test timeout / flaky | Match `wait:` to the retry config (`T6`). |
| Old executor imports (`DefaultRepositoryExecutor`, `RetriableRepositoryExecutor`) | Deprecated — use `RawRepositoryExecutor().withErrorHandling().withRetry()`. |

---

## Documentation Map

| File | Topic |
|---|---|
| [docs/ai-context/architecture.md](docs/ai-context/architecture.md) | Layers, DI, codegen |
| [docs/ai-context/bloc.md](docs/ai-context/bloc.md) | BLoC + Freezed patterns |
| [docs/ai-context/exception.md](docs/ai-context/exception.md) | Exception model + codegen |
| [docs/ai-context/repository_executor.md](docs/ai-context/repository_executor.md) | Executor composition, caching, testing |
| [docs/ai-context/rules.md](docs/ai-context/rules.md) | Style, naming, forbidden patterns |
| [docs/ai-context/testing.md](docs/ai-context/testing.md) | Test layout + mocktail rules |
| [docs/ai-context/code_review.md](docs/ai-context/code_review.md) | Full severity-tagged rule-ID checklist (ARCH/BLOC/EXC/UI/NAME/FILE/TEST/STYLE) |
| [docs/ai-context/git.md](docs/ai-context/git.md) | Branch / commit / PR format |
| [docs/ai-context/estimation.md](docs/ai-context/estimation.md) | Story-point model |

Full prose guides: `docs/guides/`. Full rule prose: `docs/rules/`. If a rule here conflicts with a full guide, the guide wins — flag it.

When starting a new app from this starter, fill in the context templates under `docs/project/` (`product-context.md`, `engineering-context.md`).
