# Code Review — AI Context

Concise checklist. Full rules: [../guides/code_review.md](../guides/code_review.md).

## Severity

| Symbol | Meaning |
|--------|---------|
| 🔴 Blocking | Must fix before merge |
| 🟡 Mild | TODO acceptable |
| 🟢 Suggestion | Nice to have (incl. low-stakes formatting nits) |
| 💬 Comment | Cannot be changed retroactively — naming of commits/branches, prior decisions |

Rules tagged `[lint]` are auto-enforced — skip in manual review.

## ARCH (architecture)

| ID | Severity | Rule |
|---|---|---|
| ARCH-1 | 🔴 `[lint]` | No Flutter / `dart:ui` in data or domain |
| ARCH-2 | 🔴 `[lint]` | No BLoC depends on another BLoC |
| ARCH-3 | 🔴 | Repository depends on **abstract** DataSource |
| ARCH-4 | 🔴 | `getIt`/`GetIt.I` only in widgets / screens / routes / DI-module registration closures |
| ARCH-5 | 🔴 | UI never calls DataSource directly |
| ARCH-6 | 🔴 | New feature has `configs/{feature}_module.dart extends AppModule` |
| ARCH-7 | 🔴 | Repositories are concrete; the abstract is the DataSource |
| ARCH-8 | 🟡 | Repository with 20+ methods → split per entity |
| ARCH-9 | 🟡 | Manual try/catch instead of `RawRepositoryExecutor` decorators |

## BLOC

| ID | Severity | Rule |
|---|---|---|
| BLOC-1 | 🔴 `[lint]` | No mutable instance fields on Bloc/Cubit |
| BLOC-2 | 🔴 | Handler catches `AppException` |
| BLOC-3 | 🔴 | Failure factory carries `AppException` |
| BLOC-4 | 🔴 | Events + states are `@freezed sealed class` |
| BLOC-5 | 🔴 | BLoC stores domain models / `AppException`, not UI models |
| BLOC-6 | 🟡 `[lint]` | `BlocListener` uses `if-case` / `is` checks (lint fires only on legacy Freezed 2 `maybeMap`/`mapOrNull` code) |
| BLOC-7 | 🟡 | `BlocBuilder` uses an exhaustive `switch` over the sealed state (always returns Widget) |
| BLOC-8 | 🟡 | Events are past-tense (`Submitted`, `Refreshed`) |
| BLOC-9 | 🟡 | Full Freezed redirect targets (`LoadingMyState`, not `_Loading`; states public, events private) |
| BLOC-10 | 🟡 | Variable names: `successState`, `failureState` — never `s` |
| BLOC-11 | 🟡 | Final emit uses `return emit(...)` |
| BLOC-12 | 🟢 `[lint]` | Blank line before every `emit(...)` |
| BLOC-13 | 🟢 | `bool get isLoading => this is LoadingMyState` |

## EXC (exceptions)

| ID | Severity | Rule |
|---|---|---|
| EXC-1 | 🔴 | New `AppException` subtype has `@ExceptionUiConfig` |
| EXC-2 | 🔴 | Don't edit `exception_ui_mapper*.dart` by hand — run generator |
| EXC-3 | 🔴 | Catch `AppException`, never bare `Exception` (in BLoC) |
| EXC-4 | 🟡 | Decorator order — `withErrorHandling()` is innermost |
| EXC-5 | 🟡 | No hardcoded UI error strings — use `ExceptionUiMapper` / `FailureWidget*` |

## UI

| ID | Severity | Rule |
|---|---|---|
| UI-1 | 🔴 | All user-facing strings via `Localizer.of(context)` |
| UI-2 | 🟡 `[lint]` | No hardcoded `Color()` / `Colors.X` outside theme/constants/tokens |
| UI-3 | 🔴 | Reuse `starter_uikit` widgets before writing your own |
| UI-4 | 🔴 `[lint]` | No `Widget _buildFoo()` — extract to a class |
| UI-5 | 🟡 `[lint]` | Spread `if (cond) ...[Widget()]` even for one |
| UI-6 | 🟡 `[lint]` | `=>` except `build()`, nested callbacks, and `if-case` listener bodies |
| UI-7 | 🟡 | `if (!context.mounted) return;` after every `await` that uses context |
| UI-8 | 🟡 | Use `starter_uikit` form widgets, not bare `FormBuilder*` |
| UI-9 | 🟡 `[lint]` | `build()` widget nesting ≤ 10 levels — extract deep subtrees |

## NAME

| ID | Severity | Rule |
|---|---|---|
| NAME-1 | 🟡 | No `Impl` suffix |
| NAME-2 | 🟡 | No `Model` suffix on domain types |
| NAME-3 | 🟡 | No `Helper` / `Manager` / `Data` / `Info` / `Util` suffixes |
| NAME-4 | 🟡 | BLoCs are nouns (`LoginBloc`, not `SubmitLoginBloc`) |
| NAME-5 | 🟡 | Methods start with a verb |
| NAME-6 | 🟡 | Source prefix first: `ApiUserDataSource` |
| NAME-7 | 🟡 | File name == class name |

## FILE

| ID | Severity | Rule |
|---|---|---|
| FILE-1 | 🟡 | Route + screen split (`*_route.dart` + `*_screen.dart`) |
| FILE-2 | 🟡 | Class > 200 lines → split |
| FILE-3 | 🟡 | Feature has `data/`, `domain/`, `model/`, `configs/`, `ui/` |
| FILE-4 | 🟡 | UI subfolder layout matches feature complexity |

## TEST

| ID | Severity | Rule |
|---|---|---|
| TEST-1 | 🔴 | Build mocks via JSON + `fromJson` |
| TEST-2 | 🔴 | Register fallback values for custom types in `any(named:)` |
| TEST-3 | 🟡 | `blocTest` never sits through retry backoff — assert failure with an immediately-throwing repo; `wait:` only for debounce (retry timing is the central executor test's job) |
| TEST-4 | 🟡 | Cover success / empty / failure per event |
| TEST-5 | 🟡 | Feature-flow (integration) test wires real BLoC → real Repo → real `Mock*DataSource`, stubbing nothing; the `ApiClient` contract is locked separately in the API-DS test |

## STYLE

| ID | Severity | Rule |
|---|---|---|
| STYLE-1 | 🟡 | No comments restating what the code does |
| STYLE-2 | 🟡 | TODOs include owner + ticket: `// TODO(@user, #123): …` |
| STYLE-3 | 🟡 | Public APIs in `starter_*` packages have `///` summary |
| STYLE-4 | 🟢 | Trailing commas |
| STYLE-5 | 🟢 `[lint]` | Single quotes |
| STYLE-6 | 🟢 `[lint]` | Package imports inside `lib/` |

## Workflow

1. Pull, run `fvm flutter analyze` and `fvm flutter test --concurrency 4` — fail = block.
2. Read diff against this checklist; tag findings as `<RULE-ID>: <severity> <comment>`.
3. Cluster: blockers first, then mild, then suggestions.
4. Approve only when 🔴 are resolved and 🟡 are fixed or TODO'd with rule ID.
