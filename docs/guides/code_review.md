# Code Review Guide

> **AI Context**: Use this checklist when reviewing pull requests in this project. Each finding cites a rule ID so the author can resolve it without re-deriving the standard.

## Severity Levels

| Severity | Meaning |
|---|---|
| 🔴 Blocking | Must fix before merge — bugs, severe violations, broken architecture |
| 🟡 Format | Can leave as TODO — style/formatting, mild violations |
| 🟢 Suggestion | Nice to have — improvements, optimizations |
| 💬 Comment | Cannot be changed retroactively — naming of commits/branches, prior decisions |

## Finding Types

| Type | When |
|---|---|
| Bug | Logic error, broken flow, crash risk, memory/resource leak |
| Severe Violation | Breaks architecture, dependency rules, or project standards |
| Mild Violation | Naming worse than optimal, structural improvement possible |
| Formatting | Whitespace, class size, comment hygiene |
| Non-optimal | Works but misses reuse, pattern, or simplification |

> Tagged `[lint]` = caught by `analysis_options.yaml` or `starter_lints`. Reviewers can skip these — the analyzer flags them.

---

## Architecture (`ARCH-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| ARCH-1 | Severe Violation 🔴 | `package:flutter/*` import in Data or Domain layer `[lint]` | Move Flutter-dependent code to Presentation, or use `package:meta`/`dart:developer` |
| ARCH-2 | Severe Violation 🔴 | BLoC depends on another BLoC (constructor injection) `[lint]` | Coordinate via `BlocListener` / `MultiBlocListener` in UI, or via route extras |
| ARCH-3 | Severe Violation 🔴 | Repository depends on a concrete DataSource | Depend on the abstract `*DataSource` interface in `domain/` |
| ARCH-4 | Severe Violation 🔴 | `GetIt.I` referenced inside Data, Domain, or BLoC | Constructor inject. `GetIt.I` is allowed only in widgets/screens/routes |
| ARCH-5 | Severe Violation 🔴 | UI calls a DataSource directly, skipping Repository | Route through Repository → AbstractDataSource |
| ARCH-6 | Severe Violation 🔴 | New feature has no `configs/{feature}_module.dart extends AppModule` | Add the GetIt module and register it in the root injector |
| ARCH-7 | Severe Violation 🔴 | Repository made `abstract` | Repositories are concrete facades. The `abstract` belongs on the DataSource. |
| ARCH-8 | Mild Violation 🟡 | Repository with 20+ methods | Split per entity / aggregate |
| ARCH-9 | Mild Violation 🟡 | Manual `try/catch` for cross-cutting concerns inside the repo | Use `RawRepositoryExecutor().withErrorHandling().withRetry()` decorators |

---

## BLoC (`BLOC-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| BLOC-1 | Severe Violation 🔴 | Mutable instance variables in BLoC `[lint]` | Put all mutable data in the Freezed state |
| BLOC-2 | Bug 🔴 | Handler missing `catch` for `AppException` | Add `on AppException catch (e) { return emit(MyState.failure(e)); }` |
| BLOC-3 | Bug 🔴 | `failure` factory missing the `AppException` field | Failure must carry the exception so UI can render via `FailureWidgetLarge` |
| BLOC-4 | Severe Violation 🔴 | Hand-rolled sealed event/state classes | Use `@freezed` factory constructors |
| BLOC-5 | Severe Violation 🔴 | UI consumes a UI-model from BLoC state | BLoC stores domain models / `AppException`. Convert to UI model in the widget. |
| BLOC-6 | Mild Violation 🟡 | `BlocListener` uses `maybeMap` with empty `orElse: () {}` `[lint]` | Use `mapOrNull` |
| BLOC-7 | Mild Violation 🟡 | `BlocBuilder` uses `mapOrNull` (returns nullable Widget) `[lint]` | Use `maybeMap`/`maybeWhen` with an `orElse` |
| BLOC-8 | Mild Violation 🟡 | Event names in imperative tense (`SubmitForm`) | Past tense: `Submitted`, `Refreshed` |
| BLOC-9 | Mild Violation 🟡 | Short redirect target (`_Loading`) | Full name: `_LoadingLoginState` |
| BLOC-10 | Mild Violation 🟡 | Variable named `s` for state | Use `successState`, `failureState`, etc. |
| BLOC-11 | Mild Violation 🟡 | Final `emit(...)` without `return` | `return emit(state)` to make control flow explicit |
| BLOC-12 | Formatting 🟢 | No blank line before `emit(...)` | Add blank line per project convention |
| BLOC-13 | Formatting 🟢 | State helper using `maybeWhen` for a `bool` check | `bool get isLoading => this is _LoadingMyState;` |

---

## Exception Handling (`EXC-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| EXC-1 | Severe Violation 🔴 | New `AppException` factory without `@ExceptionUiConfig` | Add the annotation, then run the generator |
| EXC-2 | Severe Violation 🔴 | Manual edits to `exception_ui_mapper.dart` or `exception_ui_mapper_decorator.dart` | These are generated. Run `dart run utils/generators/generate_exception_mapper.dart` |
| EXC-3 | Severe Violation 🔴 | Catching bare `Exception` in BLoC | Catch `AppException` and let other errors crash; wrap data calls with `withErrorHandling()` |
| EXC-4 | Mild Violation 🟡 | `withRetry()` placed inside `withErrorHandling()` | `withErrorHandling()` must be the innermost decorator |
| EXC-5 | Mild Violation 🟡 | Hardcoded English error string in UI | Use the localized message from `ExceptionUiMapper(context).map(exception)` or `FailureWidget*` |

---

## UI / Theming (`UI-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| UI-1 | Severe Violation 🔴 | Hardcoded user-facing string | `Localizer.of(context).{key}` |
| UI-2 | Mild Violation 🟡 | Hardcoded color or `TextStyle` `[lint: no_hardcoded_colors]` | `ThemeProvider.of(context).theme` / `.textStyles` |
| UI-3 | Severe Violation 🔴 | Reimplements a widget that exists in `starter_uikit` | Use `FailureWidgetLarge`, `EmptyInformationBody`, `AppElevatedButton`, `AppTextField`, etc. |
| UI-4 | Severe Violation 🔴 | `Widget _buildFoo()` builder method | Extract to a `StatelessWidget`/`StatefulWidget` class |
| UI-5 | Mild Violation 🟡 | Single widget added to a `children:` list as a literal element | Use spread: `if (cond) ...[Widget()]` even for one |
| UI-6 | Mild Violation 🟡 | Block body where arrow body fits | Use `=>` (except `build()` and nested callbacks) |
| UI-7 | Mild Violation 🟡 | `BuildContext` used after `await` without `mounted` check | `if (!mounted) return;` after the await |
| UI-8 | Mild Violation 🟡 | `FormBuilder*` used directly | Use `starter_uikit` form widgets (`AppTextField`, `AppDropdownField`, …) |

---

## Naming (`NAME-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| NAME-1 | Mild Violation 🟡 | `Impl` suffix on class `[lint]` | Concrete name describing the source: `RemoteUserDataSource`, not `UserDataSourceImpl` |
| NAME-2 | Mild Violation 🟡 | `Model` suffix on a domain data class `[lint]` | Drop the suffix: `User`, not `UserModel` |
| NAME-3 | Mild Violation 🟡 | Anti-pattern suffix: `Helper`, `Manager`, `Data`, `Info`, `Util` `[lint]` | Use `Feature + Description + Type` |
| NAME-4 | Mild Violation 🟡 | Verb-based BLoC name | Noun-based: `LoginBloc`, not `SubmitLoginBloc` |
| NAME-5 | Mild Violation 🟡 | Method missing a verb prefix | `fetchUsers`, not `users` |
| NAME-6 | Mild Violation 🟡 | Concrete data source name has source suffix | Source prefix first: `RemoteUserDataSource`, `LocalUserDataSource`, `MockUserDataSource` |
| NAME-7 | Mild Violation 🟡 | File name doesn't match class | `user_repository.dart` for `UserRepository` |

---

## File Organization (`FILE-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| FILE-1 | Mild Violation 🟡 | Route + screen in one file | Split: `{feature}_route.dart` and `{feature}_screen.dart` |
| FILE-2 | Mild Violation 🟡 | Class > 200 lines | Split into widgets / mixins |
| FILE-3 | Mild Violation 🟡 | Feature missing one of: `data/`, `domain/`, `model/`, `configs/`, `ui/` | Match the layout from [structure guide](./structure.md) |
| FILE-4 | Mild Violation 🟡 | UI subfolder layout doesn't match feature complexity | Simple → `bloc/`, `screen/`, `widget/`. Complex → split by flow (`list/`, `details/`, `operation/`) |

---

## Testing (`TEST-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| TEST-1 | Severe Violation 🔴 | Domain models constructed inline in tests | Build via JSON fixture + `fromJson` in `test/features/{feature}/assets/` |
| TEST-2 | Severe Violation 🔴 | `MissingStubError` because `any(named: ...)` lacks fallback | `registerFallbackValue` for every custom type used inside `any(named:)` |
| TEST-3 | Mild Violation 🟡 | `blocTest` under retry decorator without `wait:` | Add `wait: const Duration(seconds: 8)` (3 retries × 2s) |
| TEST-4 | Mild Violation 🟡 | BLoC test missing failure-path coverage | Cover success, empty, and failure for every event |
| TEST-5 | Mild Violation 🟡 | Integration test mocking the Repository | Mock only `ApiClient`. Everything else stays real. |

---

## Comments & Style (`STYLE-*`)

| ID | Type | Description | Suggested Fix |
|---|---|---|---|
| STYLE-1 | Mild Violation 🟡 | Comment restating what the code does | Remove. Self-document via better names. |
| STYLE-2 | Mild Violation 🟡 | TODO without an owner or ticket | `// TODO(@user, #123): …` |
| STYLE-3 | Mild Violation 🟡 | Public API in `starter_*` package missing `///` doc | Add 1–3 line doc summary |
| STYLE-4 | Formatting 🟢 | Missing trailing comma | Add — required by formatter |
| STYLE-5 | Formatting 🟢 | Double quotes for a string `[lint]` | Single quotes |
| STYLE-6 | Formatting 🟢 | Relative import inside `lib/` `[lint]` | `package:` import |

---

## Review Workflow

1. **Pull** the branch, run `fvm flutter analyze` and `fvm flutter test`. Fail → block.
2. **Read the diff** top-to-bottom against this checklist. Tag findings as `<ID>: <severity> <comment>`.
3. **Cluster** findings: blockers first, then mild, then suggestions.
4. **Approve only when** all 🔴 are resolved and 🟡 either fixed or tagged with TODO referencing the rule ID.
