# Coding Rules

Consolidated rule set for the flutter_starter project. Rules tagged `[lint]` are auto-enforced by [`starter_lints`](../../packages/starter_lints). Rules without the tag are review-time conventions — see [`../guides/code_review.md`](../guides/code_review.md) for severity mapping.

## Table of Contents

1. [Architecture](#architecture)
2. [Naming](#naming)
3. [File Organization](#file-organization)
4. [Class Size & SRP](#class-size--srp)
5. [Formatting](#formatting)
6. [Class Member Ordering](#class-member-ordering)
7. [Theme](#theme)
8. [Widgets](#widgets)
9. [BLoC](#bloc)
10. [Exceptions](#exceptions)
11. [Models](#models)
12. [Parameters](#parameters)
13. [Data Layer](#data-layer)
14. [Testing](#testing)
15. [Cleanup](#cleanup)
16. [Git](#git)
17. [Lint Rules Reference](#lint-rules-reference)

---

## Architecture

### No Flutter in data/domain `[lint: no_flutter_in_data_domain]`

Files under `**/data/**` and `**/domain/**` must not import `package:flutter/*` or `dart:ui`.

```dart
// ❌ Bad — File: lib/features/user/data/remote_user_data_source.dart
import 'package:flutter/foundation.dart';

// ✅ Good — pure-Dart alternatives
import 'package:meta/meta.dart';
```

### No BLoC-to-BLoC dependency `[lint: bloc_no_bloc_dependency]`

A class extending `Bloc`/`Cubit` cannot accept another `Bloc`/`Cubit` as constructor parameter or field. Coordinate via `BlocListener`/`MultiBlocListener` in the UI layer.

### Repository depends on abstract DataSource

Repositories are concrete facades. They depend on **abstract** data sources defined under `domain/`, never on concrete implementations.

```dart
// ✅ Good
class UserRepository {
  const UserRepository(this._dataSource);
  final UserDataSource _dataSource; // abstract
}
```

### GetIt.I access rules

`GetIt.I` (or the project alias `getIt`) is allowed only in widgets, screens, and routes. **Never** in data, domain, or BLoC code — those layers receive dependencies via constructor injection.

### Per-feature DI module

Every feature has `configs/{feature}_module.dart extends AppModule`, registered in the root injector.

### Repository must be concrete

Repositories are concrete classes. The abstraction lives on the `*DataSource` interface in `domain/`. Do **not** mark a repository `abstract`.

### Use repository executors for cross-cutting concerns

Compose executors in the repository's DI module closure from a single local `base = const RawRepositoryExecutor().withErrorHandling()` and inject them via constructor params, instead of writing manual `try/catch`/retry loops. `withErrorHandling()` must be the innermost (called first in the chain). Caching is the `RepositoryCache` collaborator, not a decorator — see [repository_executor.md](../guides/repository_executor.md).

---

## Naming

### Feature + Description + Type

Classes follow `Feature + [Description] + Type`. Drop `Description` for single implementations.

| Component | Pattern | Example |
|-----------|---------|---------|
| Repository | `FeatureRepository` | `UserRepository` |
| Abstract DS | `FeatureDataSource` | `UserDataSource` |
| Concrete DS | `<Source>FeatureDataSource` | `RemoteUserDataSource` |
| BLoC | `Feature[Description]Bloc` | `UserListBloc` |
| Screen | `Feature[Description]Screen` | `LoginScreen` |
| Widget | `DescriptiveWidget` | `UserProfileCard` |

### Methods start with a verb

`fetchUsers`, `createTask`, `updateProfile` — never `users()` or `data()`. See [naming.md § Functions & Methods](./naming.md#functions--methods).

### Events past-tense, states are nouns

```dart
// ✅ Events — past tense
const factory UserEvent.requested() = _RequestedUserEvent;
const factory UserEvent.refreshed() = _RefreshedUserEvent;

// ✅ States — nouns / adjectives, public case classes
const factory UserState.success(List<User> users) = SuccessUserState;
```

### Concrete implementations: source prefix first

`RemoteUserDataSource`, `LocalUserDataSource`, `MockUserDataSource` — not `UserDataSourceRemote`.

### No naming anti-patterns

Forbid `Impl`, `Module`, `Manager`, `Helper` (in non-helper files), `Data`, `Info`, `Container` (outside Flutter `Container`), `Widget` (outside actual widget classes), and `Model` on domain types. Full Bad → Good table in [naming.md § Anti-Patterns](./naming.md#anti-patterns-bad--good).

---

## File Organization

### File name == class name

`UserRepository` lives in `user_repository.dart`. Multi-word classes use `snake_case`.

### One public class per file

**Exceptions:** BLoC events + states + bloc in one file; private helpers prefixed `_`; tightly-coupled models <5 fields.

### Package imports only

Inside `lib/` and `packages/*/lib/`, use `package:starter/...` — never relative paths.

### Flat widget folders

Keep `ui/widget/` flat. Don't nest by section (`ui/widget/header/`). If folder browsing becomes painful, split the **feature** by flow (`list/`, `details/`) — each with its own flat `widget/`.

### Feature directory layout

```
lib/features/{feature}/
├── data/        # DataSource implementations
├── domain/      # AbstractDataSource + Repository
├── model/       # Domain models
├── configs/     # GetIt module
└── ui/          # bloc/, screen/, widget/
```

---

## Class Size & SRP

### Size guidelines

| Size | Verdict |
|------|---------|
| `< 100 lines` | ✅ good |
| `100–200 lines` | ⚠️ review carefully |
| `> 200 lines` | ❌ split |

### When to split

1. Cannot describe purpose in one sentence without "and".
2. Multiple `// region` blocks of unrelated concerns.
3. Methods cluster around independent state.

### BLoC separation

BLoCs do not depend on other BLoCs. Coordinate via `BlocListener` / route extras / parent widget.

---

## Formatting

### Blank line before return `[lint: blank_line_before_return]`

```dart
// ✅ Good
final result = compute();

return result;
```

### Braces in flow control `[lint: braces_in_flow_control]`

`for`/`while`/`do` always braced. Multi-line `if`/`else` braced. Single-line `if (cond) doIt();` allowed.

### Spread in collections `[lint: always_spread_in_collections]`

```dart
// ✅ Good — even for a single widget
Column(
  children: [
    if (showAvatar) ...[
      UserAvatar(),
    ],
  ],
)
```

### Multi-line ternary → if/else

Single-condition ternary > 10 lines, or nested (2+) ternary ≥ 5 lines, must be rewritten as `if`/`else`. See [code_formatting.md § Multi-line Ternary](./code_formatting.md#multi-line-ternary--ifelse).

### Constructor parameter order `[lint: sort_constructor_params]`

`required → with default → optional → super.key`.

### Arrow except build / nested callbacks `[lint: prefer_arrow_except_build_and_nested]`

`=>` for everything except `build()` and nested callbacks like `() => setState(() {})`.

### Extract complex expressions

Pull complex sub-expressions into named locals before letting the line grow.

### No `_` on local variables

Leading `_` declares class-level privacy. Don't use it on locals — privacy is implicit.

```dart
// ❌ Bad
final _result = await repo.fetch();

// ✅ Good
final result = await repo.fetch();
```

### Line length

100 chars for ordinary code, 200 chars for deeply composed widget chains. Extract before wrapping.

### Single quotes

`'hello'`, never `"hello"` (already enforced by analyzer).

---

## Class Member Ordering

```
1. Constructors (default first, then named)
2. Constants of same type
3. Static factory methods
4. Final fields (from constructor)
5. Other static methods/properties
6. Mutable properties (getter, field, setter together)
7. Read-only properties
8. Operators (except ==)
9. Methods (except toString, build)
10. build (for widgets)
11. operator ==, hashCode, toString
```

---

## Theme

### Theme accessed in build only

Read theme in `build()` (or local helper called from build). Don't store it as a field, parameter, or stream.

### Never pass theme as a parameter

Receive `BuildContext` and resolve `ThemeProvider.of(context).theme` locally instead.

### No hardcoded colors `[lint: no_hardcoded_colors]`

`Color(0xFF…)` and `Colors.X` are forbidden outside `**/theme/**`, `**/constants/**`, `**/tokens/**`. Use `theme.primary`, `theme.onPrimary`, `theme.error`, etc.

### Use ThemeProvider, not Theme.of

The starter's design system flows through `ThemeProvider`. `Theme.of(context)` returns Material's theme, not ours.

```dart
final theme = ThemeProvider.of(context).theme;
final textStyles = ThemeProvider.of(context).textStyles;
```

---

## Widgets

### No widget functions `[lint: avoid_widget_functions]`

```dart
// ❌ Bad
Widget _buildHeader() => Container();

// ✅ Good
class HeaderWidget extends StatelessWidget { ... }
```

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

### `super.initState()` first, `super.dispose()` last

### Modals = StatelessWidget + static `show()`

Bottom sheets and dialogs are `StatelessWidget` classes that expose a static `show(...)` returning the future result.

### Reuse starter_uikit

Before writing new UI, check `starter_uikit` for: `FailureWidget.large`, `EmptyInformationBody`, `CustomCircularProgressIndicator`, `NotificationSnackBar`, `AppTextField`, `AppDropdownField`, `AppDatePickerField`, `AppCheckbox`, `AppElevatedButton`, `AppOutlinedButton`, `TitleAppBar`, `BaseAppBar`, `TransparentAppBar`.

### `mounted` after async

```dart
await operation();
if (!context.mounted) return;
context.read<MyBloc>().add(const Refreshed());
```

---

## BLoC

### No mutable instance fields `[lint: avoid_mutable_bloc_fields]`

All mutable data lives in the Freezed state. Subscriptions, timers, cancel-tokens, and completers are exempt.

### Use Freezed for events and states

`@freezed sealed class` for every event and state union (`abstract class` for single-constructor states). State case classes are public (`SuccessUserState`); event case classes stay private (`_RequestedUserEvent`). Run `build_runner` after editing.

### State pattern decision

| Need | Use |
|------|-----|
| Simple union (no persistent data) | Flat states (`initial`, `loading`, `success`, `failure`) |
| Data persists across status changes | Nested status — see [bloc.md](./bloc.md) and [../guides/freezed_bloc.md](../guides/freezed_bloc.md) |

### Event handler conventions

1. `return emit(...)` for the final emit.
2. Blank line before every `emit(...)`.
3. Variable names: `successState`, `failureState` — never `s`.
4. Catch only `AppException`.

### State helper getters

```dart
const MyState._();          // required for getters

bool get isLoading => this is LoadingMyState;
```

Don't repeat the same inline `is` check across widgets — add a getter.

### `BlocBuilder` uses an exhaustive `switch`

Builder must return a non-null `Widget`. Use an exhaustive `switch` expression/statement over the sealed state so the compiler proves every case returns a `Widget`.

### `BlocListener` uses `if-case` / `is` checks `[lint: prefer_map_or_null]`

Side-effect handlers pattern-match with `if (state case FailureMyState(:final exception))` or `state is SuccessMyState`. (The `prefer_map_or_null` lint applies only to legacy Freezed 2 `maybeMap`/`maybeWhen` code — those methods no longer exist in Freezed 3.)

### Past-tense events

`Submitted`, `Requested`, `Refreshed`, `Deleted` — never imperative (`Submit`, `Request`).

### Refreshed event pattern

Add a `.refreshed()` event so retry callbacks never extract data from state.

```dart
onRetry: () => context.read<MyBloc>().add(const MyEvent.refreshed())
```

---

## Exceptions

### Two-layer model

| Layer | Type | Purpose |
|-------|------|---------|
| Data / Domain | `AppException` (sealed Freezed) | Pure domain error |
| UI | `ExceptionUiModel` (Equatable) | Localized message + icon |

BLoC state holds `AppException`. UI converts at render time via `ExceptionUiMapper(context)`.

### Catch `AppException`, never bare `Exception`

```dart
// ✅ Good
try {
  ...
} on AppException catch (e) {
  return emit(MyState.failure(e));
}
```

Bare `catch (e)` is allowed only with an `// ignore: avoid_catches_without_on_clauses — <reason>` justification (e.g., boot-time fallback that must absorb everything).

### Failure factory carries the exception

```dart
const factory MyState.failure(AppException exception) = FailureMyState;
```

UI consumes via `FailureWidget.large(exception: state.exception, onRetry: …)`.

### Adding a new exception

1. Add a sealed factory under `packages/starter_toolkit/lib/data/exceptions/app_exception.dart` with `@ExceptionUiConfig(...)`.
2. Add the localization key to `packages/starter_uikit/lib/l10n/intl_en.arb`.
3. Run codegen:

```bash
dart run utils/generators/generate_exception_mapper.dart
fvm flutter --no-color pub global run intl_utils:generate
```

### Generated mapper files are read-only

`exception_ui_mapper.dart` and `exception_ui_mapper_decorator.dart` are produced by the generator. Do not edit by hand.

### No hardcoded exception strings

UI must consume the localized message via `ExceptionUiMapper` or `FailureWidget*`. Never hardcode an English error string.

### Repository executor decorator order

```dart
final base = const RawRepositoryExecutor()
  .withErrorHandling()  // innermost — converts raw throws to AppException
  .withRetry();         // outer — sees AppException
```

---

## Models

### Serialized models use `@JsonKey(defaultValue:)`

For models that round-trip through JSON, every field that is logically non-null but might be missing in the response gets `@JsonKey(defaultValue: ...)`. Use `@Default` only on pure UI/state classes that don't have a `fromJson`.

### Drop `Model` suffix

`User`, not `UserModel`. The type tells you it's a model.

### Request/response naming

`LoginRequest` / `LoginResponse` for transport-only types. Domain models stay un-suffixed.

---

## Parameters

### Bool defaults `[lint: prefer_bool_default]`

```dart
// ❌ Bad
void configure({bool? loud}) { ... }

// ✅ Good
void configure({bool loud = false}) { ... }
```

If `null` carries semantic meaning, model the third state as an enum.

### Required-named for 5+ parameters

For functions/constructors with 5 or more parameters, prefer named parameters with `required` so call sites self-document.

```dart
configure(host: 'localhost', port: 8080, secure: true, retries: 3, timeout: 5);
```

---

## Data Layer

### Use the typed `ApiClient`

Repositories call `getIt<ApiClient>()`. Never construct a Dio instance ad-hoc.

### No `print()` in production code

```dart
// ❌ Bad
print('error: $e');

// ✅ Good
debugPrint('error: $e');
log('Failed to fetch payments: $e', name: 'PaymentRepository');
```

`print` is allowed only in `utils/generators/` (developer scripts, excluded from analyzer).

### Throw typed `AppException` subclasses, not bare `Exception`

```dart
// ❌ Bad
throw Exception('Task not found');

// ✅ Good
throw const ServerException(statusCode: 404, message: 'Task not found');
```

---

## Testing

| Layer | Strategy | Mocks |
|-------|----------|-------|
| BLoC | Unit / `blocTest` | Repository |
| Repository + DataSource | Unit | `ApiClient` |
| Integration | Full stack `blocTest` | `ApiClient` only |

### Required practices

- Build mocks via JSON fixture + `fromJson` — never construct domain models inline.
- Cover success, empty, and failure for every BLoC event.
- `registerFallbackValue` for every custom type used in `any(named:)`.
- `blocTest` under retry decorators must match `wait` to retry settings (for example `8s` for `2s × 3 retries`, or `300ms` for `10ms × 3`).

Full guide: [../guides/testing.md](../guides/testing.md).

---

## Cleanup

| Rule | Why |
|------|-----|
| No backwards-compat aliases | Dead code bloat |
| No empty stub methods | File clutter |
| No scattered `// ignore:` lines | Fix the root cause; if unavoidable, use `// ignore_for_file:` at top with `—` justification (e.g. `// ignore_for_file: avoid_print — developer-only generator`). |
| `Key` only when needed | Unused keys defeat Flutter widget reuse |
| Comments only when WHY is non-obvious | Code says WHAT |

---

## Git

Full guide: [git_workflow.md](./git_workflow.md). Quick reference:

| Format | Example |
|--------|---------|
| Branch with ticket | `feature/PROJ-152_payment-redesign` |
| Branch without | `fix/crash-on-login`, `refactor/clean-auth` |
| Commit with ticket | `PROJ-152: Refactor payment module` |
| Commit without | `fix: Resolve null pointer in handler` |
| PR title | Same as commit format |

Capitalize first letter, no period, ≤ 72 chars, imperative mood.

---

## Lint Rules Reference

All 19 lints enforced by [`starter_lints`](../../packages/starter_lints):

| Lint | Severity | Section |
|------|----------|---------|
| `no_flutter_in_data_domain` | ERROR | [Architecture](#architecture) |
| `bloc_no_bloc_dependency` | WARNING | [Architecture](#architecture) |
| `avoid_naming_antipatterns` | WARNING / INFO | [Naming](#naming) |
| `class_size_warning` | INFO | [Class Size & SRP](#class-size--srp) |
| `avoid_widget_functions` | WARNING | [Widgets](#widgets) |
| `avoid_build_context_field` | WARNING | [Widgets](#widgets) |
| `max_widget_nesting` | INFO | [Widgets](#widgets) |
| `no_hardcoded_colors` | WARNING | [Theme](#theme) |
| `theme_in_build_only` | WARNING | [Theme](#theme) |
| `avoid_mutable_bloc_fields` | WARNING | [BLoC](#bloc) |
| `prefer_map_or_null` | INFO | [BLoC](#bloc) |
| `bloc_listener_builder_usage` | INFO | [BLoC](#bloc) |
| `braces_in_flow_control` | WARNING | [Formatting](#formatting) |
| `prefer_arrow_except_build` | WARNING / INFO | [Formatting](#formatting) |
| `always_spread_in_collections` | INFO | [Formatting](#formatting) |
| `blank_line_before_return` | INFO | [Formatting](#formatting) |
| `sort_constructor_params` | INFO | [Formatting](#formatting) |
| `multi_line_ternary` | INFO | [Formatting](#formatting) |
| `prefer_bool_default` | INFO | [Parameters](#parameters) |

Lints run as part of `fvm dart run custom_lint` and during the analyzer pass (`fvm flutter analyze`).

> **Note:** `prefer_map_or_null` (and `bloc_listener_builder_usage` in `starter_lints`) target the legacy Freezed 2 pattern-matching methods (`maybeMap`/`maybeWhen`/`mapOrNull`/`whenOrNull`), which were removed in Freezed 3. They only fire on legacy code — new code uses Dart `switch` / `if-case` pattern matching on the sealed state classes.
