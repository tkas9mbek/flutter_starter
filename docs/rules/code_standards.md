# Code Standards

Objective, tool-enforced, and architecture rules for flutter_starter. Rules tagged `[lint]` are auto-enforced by [`starter_lints`](../../packages/starter_lints) — the full list is in [Lint Rules Reference](#lint-rules-reference). Untagged rules are review-time conventions — see [`../guides/code_review.md`](../guides/code_review.md) for severity mapping.

Personal/AI-session stylistic conventions that are more specific than (but must not contradict) this file live in [`code_preferences.md`](./code_preferences.md).

## Table of Contents

1. [Architecture](#architecture)
2. [Naming](#naming)
3. [File Organization](#file-organization)
4. [Class Size & SRP](#class-size--srp)
5. [Formatting](#formatting)
6. [Theme](#theme)
7. [Widgets](#widgets)
8. [BLoC](#bloc)
9. [Exceptions](#exceptions)
10. [Models](#models)
11. [Parameters](#parameters)
12. [Data Layer](#data-layer)
13. [Testing](#testing)
14. [Cleanup](#cleanup)
15. [Code Generation](#code-generation)
16. [Dependencies](#dependencies)
17. [Git](#git)
18. [Lint Rules Reference](#lint-rules-reference)

---

## Architecture

### No Flutter in data/domain `[lint: no_flutter_in_data_domain]`

Files under `**/data/**` and `**/domain/**` must not import `package:flutter/*` or `dart:ui`. Use pure-Dart alternatives (`package:meta/meta.dart` instead of `foundation.dart`).

### No BLoC-to-BLoC dependency `[lint: bloc_no_bloc_dependency]`

A class extending `Bloc`/`Cubit` cannot accept another `Bloc`/`Cubit` as constructor parameter or field. Coordinate via `BlocListener`/`MultiBlocListener` in the UI layer (or route extras / a parent widget).

### Repository depends on abstract DataSource

Repositories are **concrete** facades (never mark one `abstract`). They depend on the **abstract** data source defined under `domain/`, never on a concrete implementation (`Api*`, `Local*`, `Mock*`) — the abstraction lives on the `*DataSource` interface.

```dart
class UserRepository {
  const UserRepository(this._dataSource);

  final UserDataSource _dataSource; // abstract
}
```

### GetIt.I access rules

`GetIt.I` (or the project alias `getIt`) is allowed only in widgets, screens, routes, and DI-module registration closures (`configs/*_module.dart`). **Never** in data, domain, or BLoC code — those layers receive dependencies via constructor injection.

### Per-feature DI module

Every feature has `configs/{feature}_module.dart extends AppModule`, registered in the root injector. The module picks the mock twin or the API data source with `mockOrProd(mock: ..., prod: ...)` — nothing else branches on the environment.

### Use repository executors for cross-cutting concerns

Compose executors in the repository's DI module closure from a single local `base = const RawRepositoryExecutor().withErrorHandling()` and inject them via constructor params, instead of writing manual `try/catch`/retry loops. `withErrorHandling()` must be the innermost (first in the chain — it converts raw throws to `AppException` for the outer decorators to see). Baseline is `.withErrorHandling()` alone; append `.withRetry(maxRetries: 3, retryDelay: ...)` only for idempotent reads (today `ProfileRepository`, `PushTokenRepository`, `RemoteConfigRepository` do). Caching is the `RepositoryCache` collaborator (`InMemoryRepositoryCache`), not a decorator — it ships in `starter_toolkit` but has no consumer yet. See [repository_executor.md](../guides/repository_executor.md).

---

## Naming

Classes follow `Feature + [Description] + Type` (description dropped for single implementations); methods start with a verb. Patterns, the DataSource prefix table (`Api*` / `Local*` / `Mock*`, source first) and the full Bad → Good table live in [naming.md](./naming.md).

- **Events past-tense, states nouns:** `UserEvent.requested()` → `_RequestedUserEvent`; `UserState.success(...)` → public `SuccessUserState`.
- **No naming anti-patterns `[lint: avoid_naming_antipatterns]`:** the lint flags an `Impl` suffix, `Module` in a Repository/DataSource/Bloc/Service name, and a `Model` suffix on classes under `model/` (`*UiModel` is exempt — it is the presentation-variant suffix). Review-time on top of that: `Manager`, `Helper` (outside helper files), `Data`, `Info`, `Container` (outside Flutter's), `Widget` (outside actual widget classes). `Module` stays on DI config classes (`configs/{feature}_module.dart extends AppModule`).

---

## File Organization

### File name == class name

`UserRepository` lives in `user_repository.dart`; multi-word classes use `snake_case`.

### One public class per file

**Exceptions:** a larger BLoC is **two files** forming one library via `part` / `part of` — `{feature}_bloc.dart` (Bloc class) + `{feature}_event_state.dart` (`@freezed` events + states), see [bloc.md](./bloc.md); private helpers prefixed `_`; tightly-coupled models <5 fields.

### Package imports only

Inside `lib/` and `packages/*/lib/`, use `package:starter/...` — never relative paths.

### Feature directory layout

```
lib/features/{feature}/
├── data/        # DataSource implementations (Api*/Local*); mock/ holds Mock* twins + scenarios
├── domain/      # AbstractDataSource + Repository
├── model/       # Domain models
├── configs/     # GetIt module
└── ui/          # subfeature folders only
    └── {subfeature}/   # bloc/, screen/, widget/
```

`ui/` never holds `bloc/`, `screen/`, or `widget/` directly — a single-flow feature uses one subfeature folder named after the feature (e.g. `profile/ui/overview/`).

> Widget folder layout inside `ui/{subfeature}/widget/` (flat vs. nested) is a stylistic convention — see [code_preferences.md § Flat widget folders](./code_preferences.md#flat-widget-folders).

---

## Class Size & SRP

| Size | Verdict |
|------|---------|
| `< 100 lines` | ✅ good |
| `100–200 lines` | ⚠️ review carefully (`[lint: class_size_warning]`, info, fires at >100) |
| `> 200 lines` | ❌ split ([`split-large-widget`](../../.claude/skills/split-large-widget/SKILL.md) skill) |

Split when: you cannot describe the purpose in one sentence without "and"; there are `// region` blocks of unrelated concerns; methods cluster around independent state.

---

## Formatting

### Blank line before return `[lint: blank_line_before_return]`

```dart
final result = compute();

return result;
```

### Braces in flow control `[lint: braces_in_flow_control]`

`for`/`while`/`do` always braced. Multi-line `if`/`else` braced. Single-line `if (cond) doIt();` allowed.

### Spread in collections `[lint: always_spread_in_collections]`

```dart
Column(
  children: [
    if (showAvatar) ...[
      UserAvatar(),  // spread even for a single widget
    ],
  ],
)
```

### Multi-line ternary → if/else `[lint: multi_line_ternary]`

Convert to `if`/`else` with early returns when a single-condition ternary spans **more than 10 lines** or a nested (2+) ternary spans **5+ lines**. A short one-line ternary stays a ternary.

```dart
// ❌ Bad — nested ternary
final label = state.isLoading
    ? localizer.loading
    : state.hasError
        ? localizer.error
        : localizer.ready;

// ✅ Good
String _resolveLabel(MyState state, Localizer localizer) {
  if (state.isLoading) return localizer.loading;
  if (state.hasError) return localizer.error;

  return localizer.ready;
}
```

### Constructor parameter order `[lint: sort_constructor_params]`

`required → with default → optional → super.key`.

### Arrow except build / nested callbacks / if-case listeners `[lint: prefer_arrow_except_build]`

`=>` for everything except `build()` (block body required), nested callbacks (write `onPressed: () { setState(() {...}); }`, never arrow-in-arrow), and listener bodies that use `if-case` statements.

### Extract complex expressions

Pull complex sub-expressions into named locals before letting the line grow.

### No `_` on local variables

Leading `_` declares class-level privacy; locals are `final result = ...`, never `final _result = ...`.

### Line length

`dart format` enforces an 80-character page width (`analysis_options.yaml: page_width: 80`) — the real limit for all code, including widget chains. Extract a named local, split a builder into its own widget class, or put each `.method()` call on its own line rather than hard-wrapping mid-expression.

### Comments and documentation

Write self-documenting code first. Comments and docs are concise but give enough context for non-obvious purpose, constraints, invariants, or workarounds.

- Comment / doc lines may exceed the 80-character code limit but stay **under 120 characters**.
- Describe only non-trivial behavior; never comment what the code already says.
- `///` summaries for public APIs in shared packages (1–3 lines).

AI-session comment length (≤2 lines per block): [code_preferences.md § Comments stay within two lines](./code_preferences.md#comments-stay-within-two-lines).

### Single quotes

`'hello'`, never `"hello"` (enforced by the analyzer).

---

## Theme

[`uikit.md`](./uikit.md) has the token rules for `starter_uikit` widgets; the app-level rules are below.

### Theme accessed in build only `[lint: theme_in_build_only]`

Read the theme in `build()` (or a local helper called from build). Don't store it as a field, stream, or constructor parameter — resolve `ThemeProvider.of(context).theme` locally.

### No hardcoded colors `[lint: no_hardcoded_colors]`

`Color(0xFF…)` and `Colors.X` are forbidden outside `**/theme/**`, `**/constants/**`, `**/tokens/**`. Use `theme.primary`, `theme.onPrimary`, `theme.error`, etc.

### Use ThemeProvider, not Theme.of

`Theme.of(context)` returns Material's theme, not ours.

```dart
final theme = ThemeProvider.of(context).theme;
final textStyles = ThemeProvider.of(context).textStyles;
```

---

## Widgets

### No widget functions `[lint: avoid_widget_functions]`

`Widget _buildHeader() => ...` is forbidden — extract a `StatelessWidget` class. Keep `build()` nesting ≤ 8 levels `[lint: max_widget_nesting]` by extracting inner widgets.

### No BuildContext fields `[lint: avoid_build_context_field]`

Pass `BuildContext` to methods. Never store it on a class.

### State class is private, state methods are public

```dart
class _MyScreenState extends State<MyScreen> {
  @override
  void initState() { ... }     // public

  void onSubmit() { ... }      // public — `_` only on instance vars
}
```

`super.initState()` first, `super.dispose()` last.

### Modals = StatelessWidget + static `show()`

Bottom sheets and dialogs are `StatelessWidget` classes that expose a static `show(...)` returning the future result.

### Reuse starter_uikit and starter_toolkit

Before writing new UI, check `starter_uikit` (the component list is in `AGENTS.md` § Reusing Toolkit & UIKit). Before hand-writing a date/time computation, check `starter_toolkit`:

```dart
// ❌ Bad — manual date comparison
final isToday = DateTime.now().year == date.year && ...;

// ✅ Good — starter_toolkit's DateTimeHelpers extension
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

final isToday = date.isToday;
```

### Icons via `SvgIcon`, never material `Icons`

Every glyph comes from the Spider-generated `UiSvgIcons` set in `starter_uikit`, rendered through `SvgIcon`. Material `Icon`/`Icons.*` are forbidden in app and uikit code.

```dart
// ❌ Icon(Icons.chevron_right, size: 20, color: theme.textTertiary)
// ✅
SvgIcon(UiSvgIcons.chevronRight, size: 20, color: theme.textTertiary);
```

### All user-facing strings are localized

```dart
// ❌ Text('No tasks yet')
// ✅
Text(Localizer.of(context).noTasksYet)
```

### Forms use a form UI model

Every multi-field form has a UI model in `ui/{subfeature}/model/` with static field-name constants and a `fromForm(Map<String, dynamic>)` factory. Field widgets and value reads reference the constants — never raw string keys. The model owns normalization (trimming, empty-to-null) inside `fromForm`, so screens hand the BLoC a ready value object.

```dart
// ❌ AppTextField(name: 'phone', ...);  formKey.currentState!.value['phone'] as String
// ✅
AppTextField(name: LoginForm.phoneField, label: localizer.phoneNumber);
final form = LoginForm.fromForm(formKey.currentState!.value);
```

### `mounted` after async

```dart
await operation();
if (!context.mounted) return;
context.read<MyBloc>().add(const MyEvent.refreshed());
```

---

## BLoC

File layout, state/event patterns and UI integration with full examples: [bloc.md](./bloc.md).

### No mutable instance fields `[lint: avoid_mutable_bloc_fields]`

All mutable data lives in the Freezed state. Subscriptions, timers, cancel-tokens, and completers are exempt.

### Use Freezed for events and states

`@freezed sealed class` for every event and state union (`abstract class` for single-constructor states). State case classes are public (`SuccessUserState`); event case classes stay private (`_RequestedUserEvent`). Events are past-tense (`Submitted`, `Requested`, `Refreshed`, `Deleted` — never `Submit`, `Request`). Run `build_runner` after editing.

| Need | Use |
|------|-----|
| Simple union (no persistent data) | Flat states (`initial`, `loading`, `success`, `failure`) |
| Data persists across status changes | Nested status — [bloc.md](./bloc.md#nested-status-pattern-persistent-data), [freezed_bloc.md](../guides/freezed_bloc.md) |

### Event handler conventions

1. `return emit(...)` for the final emit.
2. Blank line before every `emit(...)`.
3. Variable names: `successState`, `failureState` — never `s`.
4. Catch only `AppException`.
5. Add a `.refreshed()` event so retry callbacks never extract data from state.

### State helper getters

Add a getter (`const MyState._();` is required) instead of repeating an inline `is` check across widgets:

```dart
bool get isLoading => this is LoadingMyState;
```

### `BlocBuilder` uses an exhaustive `switch`

The builder returns a non-null `Widget`; an exhaustive `switch` over the sealed state lets the compiler prove every case does.

### `BlocListener` uses `if-case` / `is` checks `[lint: prefer_map_or_null]`

Side-effect handlers pattern-match with `if (state case FailureMyState(:final exception))` or `state is SuccessMyState`. `prefer_map_or_null` and `bloc_listener_builder_usage` target legacy Freezed 2 `maybeMap`/`maybeWhen`/`whenOrNull` code — those methods no longer exist in Freezed 3, so neither fires on current code.

---

## Exceptions

### Two-layer model

| Layer | Type | Purpose |
|-------|------|---------|
| Data / Domain | `AppException` (sealed class hierarchy) | Pure domain error |
| UI | `ExceptionUiModel` (Equatable) | Localized messages + retry flag |

BLoC state holds `AppException` (`const factory MyState.failure(AppException exception) = FailureMyState;`). UI converts at render time via `ExceptionUiMapper(context)`; `FailureWidget.large(exception: state.exception, onRetry: …)` does it for you. Never hardcode an English error string.

### Catch `AppException`, never bare `Exception`

```dart
try {
  ...
} on AppException catch (e) {
  return emit(MyState.failure(e));
}
```

Bare `catch (e)` is allowed only with an `// ignore: avoid_catches_without_on_clauses — <reason>` justification (e.g., a boot-time fallback that must absorb everything).

### Adding a new exception

1. Add a `final class` subtype of `AppException` in `packages/starter_toolkit/lib/data/exceptions/app_exception.dart`, annotated with `@ExceptionUiConfig(...)` (`descriptionKey` required, `titleKey`/`snackbarKey` optional).
2. Add the localization key to `packages/starter_uikit/lib/l10n/intl_en.arb`.
3. Run codegen:

```bash
dart run utils/generators/generate_exception_mapper.dart
fvm flutter --no-color pub global run intl_utils:generate
```

`exception_ui_mapper.dart` and `exception_ui_mapper_decorator.dart` are generator output — never edit by hand.

---

## Models

- **Serialized models use `@JsonKey(defaultValue:)`** — every logically non-null field that might be missing from the response. Use `@Default` only on pure UI/state classes with no `fromJson`. Serialized enums also need an `unknown` fallback ([code_preferences § 16](./code_preferences.md#serialized-enums-need-an-unknown-fallback)).
- **Drop the `Model` suffix** — `User`, not `UserModel`.
- **Transport-only types** are `LoginRequest` / `LoginResponse`; domain models stay un-suffixed.

---

## Parameters

### Bool defaults `[lint: prefer_bool_default]`

```dart
// ❌ void configure({bool? loud})
// ✅ void configure({bool loud = false})
```

If `null` carries semantic meaning, model the third state as an enum.

Five or more parameters → named + `required`: [code_preferences § Required-named for 5+ parameters](./code_preferences.md#required-named-for-5-parameters).

---

## Data Layer

### Use the typed `ApiClient`

`Api*DataSource` classes receive the typed `ApiClient` via constructor injection (wired in the feature's DI module). Never construct a Dio instance ad-hoc; repositories never call GetIt or touch the `ApiClient` — they see only the abstract data source.

### No `print()` in production code

Use `log('Failed to fetch payments: $e', name: 'PaymentRepository')` from `dart:developer` — it works in every layer. `debugPrint` is a Flutter symbol: fine in presentation code, forbidden in `data/`/`domain/` by `no_flutter_in_data_domain`. `print` is allowed only in `utils/generators/` (developer scripts, excluded from analyzer).

### Throw typed `AppException` subclasses, not bare `Exception`

```dart
// ❌ throw Exception('Task not found');
// ✅
throw const ServerException(statusCode: 404, message: 'Task not found');
```

---

## Testing

Mock-first doctrine — full guide: [../guides/testing.md](../guides/testing.md).

| Layer | Strategy | Mocks |
|-------|----------|-------|
| BLoC | Unit / `blocTest` | Repository (throws immediately for failure paths) |
| API data source | Unit — lock the `ApiClient` contract, run real `fromJson`/`toJson` | `ApiClient` only |
| Feature-flow (integration) | Real BLoC → real Repo → real `Mock*DataSource` | Nothing |
| Repository executor | Once, centrally in `starter_toolkit` | Data source |

- Build mocks via JSON fixture + `fromJson` — never construct domain models inline.
- Cover success, empty, and failure for every BLoC event.
- `registerFallbackValue` for every custom type used in `any(named:)`.
- **No per-repository unit tests** — delegation is proven by the feature-flow test.
- `blocTest` `wait:` is for debounce only. Never size it to sit through retry backoff; retry timing is tested once in the central executor test.

---

## Cleanup

| Rule | Why |
|------|-----|
| No backwards-compat aliases | Dead code bloat |
| No empty stub methods | File clutter |
| No scattered `// ignore:` lines | Fix the root cause; if unavoidable, `// ignore_for_file:` at the top with a `—` justification (e.g. `// ignore_for_file: avoid_print — developer-only generator`) |
| `Key` only when needed | Unused keys defeat Flutter widget reuse |
| Comments only when WHY is non-obvious | Code says WHAT; lines ≤ 120 chars |
| No leftover `_unused` renamed locals after a refactor | Delete instead |

---

## Code Generation

All generated files are produced by tools — never edit them by hand.

| Tool | Command | Run after changing | Generates |
|------|---------|--------------------|-----------|
| build_runner | `fvm flutter pub run build_runner build --delete-conflicting-outputs` | Routes, JSON models, Freezed BLoC events/states | `*.freezed.dart`, `*.g.dart`, `*.gr.dart` |
| Exception mapper | `dart run utils/generators/generate_exception_mapper.dart` | `AppException` subtypes / `@ExceptionUiConfig` | `exception_ui_mapper.dart`, `exception_ui_mapper_decorator.dart` |
| intl_utils | `fvm flutter --no-color pub global run intl_utils:generate` | ARB files (`en`, `ru`) | `l10n/generated/` localizers |
| Spider | `(cd packages/starter_uikit && spider build)` | SVG/image assets in `starter_uikit` | `lib/resources/ui_svg_icons.dart` from `spider.json` |

Install Spider once with `dart pub global activate spider`.

---

## Dependencies

The repo is a pub workspace: the root `pubspec.yaml` lists all packages under `workspace:`, and each package opts in with `resolution: workspace`.

- Declare dependencies in package pubspecs **without version constraints** (`shimmer:`, not `shimmer: ^3.0.0`) — the workspace resolves one version for the whole repo.
- Order: Flutter SDK deps first, then alphabetical; `dev_dependencies` follow the same rule independently.

---

## Git

Branch / commit / PR formats are owned by [git_workflow.md](./git_workflow.md) (`feature/PROJ-152_payment-redesign`, `fix: Resolve null pointer in handler`, `feat(starter_lints): Port advisory rules`). Capitalized imperative, no trailing period, ≤ 72 chars; PR title = commit format.

---

## Lint Rules Reference

All 19 [`starter_lints`](../../packages/starter_lints) rules, run by `fvm dart run custom_lint` (and surfaced during `fvm flutter analyze`). Severity is what the rule reports:

| Severity | Lints |
|---|---|
| ERROR | `no_flutter_in_data_domain` |
| WARNING | `avoid_build_context_field`, `avoid_mutable_bloc_fields`, `avoid_widget_functions`, `bloc_no_bloc_dependency`, `braces_in_flow_control`, `no_hardcoded_colors`, `theme_in_build_only`; `avoid_naming_antipatterns` (`Impl`, `Module`); `prefer_arrow_except_build` (arrow-bodied `build()`) |
| INFO | `always_spread_in_collections`, `blank_line_before_return`, `bloc_listener_builder_usage`, `class_size_warning`, `max_widget_nesting`, `multi_line_ternary`, `prefer_bool_default`, `prefer_map_or_null`, `sort_constructor_params`; `avoid_naming_antipatterns` (`Model`); `prefer_arrow_except_build` (single-expression callbacks) |
