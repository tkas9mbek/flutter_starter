# Polymorphism Guide

How to replace repeated `switch`/`if` chains, duplicated algorithms, flag parameters and scattered
null checks with a type that carries its own behavior — and when *not* to, because Dart 3 `sealed`
types with an exhaustive `switch` often solve it in one place.

Detail source for [`../rules/code_preferences.md` § 14](../rules/code_preferences.md#prefer-polymorphism-over-a-repeated-switch-openclosed).
Rule IDs `POLY-*`: [`../ai-context/polymorphism.md`](../ai-context/polymorphism.md).

Related: BLoC state variants → [`freezed_bloc.md`](./freezed_bloc.md) (states are not UI models);
retry/error decorators → [`repository_executor.md`](./repository_executor.md); reviewing a repeated
switch → [`../ai-context/code_review.md`](../ai-context/code_review.md) `REUSE-*`.

> **Real vs. illustrative.** **Real** blocks quote existing files. **Illustrative** code uses
> types that do *not* exist (`TaskStatus`, `TaskStatusUiModel`, `TaskTileUiModel`, `statusDone`…);
> do not grep for them. Line numbers drift — open the file.

---

## The one rule

**Every enum or sealed type gets one `switch` per concern, and that switch lives in one place.**

The *N-th copy* of a `switch` is the problem, not the switch. Adding a variant should mean one new
case in one file (plus a compiler error at every exhaustive switch that forgot it).

The repo already does this for exceptions: `AppException` is a sealed hierarchy
(`packages/starter_toolkit/lib/data/exceptions/app_exception.dart`), the single switch is
`ExceptionUiMapper.map` (`packages/starter_uikit/lib/utils/mappers/exception_ui_mapper.dart`), and
`FailureWidget` / `NotificationSnackBar` read `uiModel.description` / `canRetry` without switching
on the exception.

---

## Decision ladder

Climb only as far as the variation forces you.

| Variation looks like | Use | Real example |
|---|---|---|
| 1–2 simple values; each site tweaks one style | Inline `if` / ternary | `task.isCompleted` ternaries in `lib/features/task/ui/list/widget/task_list_item_tile.dart` |
| Closed set; rendering only; **one** consumer | `sealed` + exhaustive `switch` there | `CalendarStatusBody` over `CalendarStatus` (`lib/features/task/ui/calendar/widget/calendar_status_body.dart`) |
| Same type switched in **3+ places**; differences are **data** | Value-variant UI model — `from()` holds the only switch | Shape: `AppEnvironment.prod()/dev()/mock()` + `fromName` (`lib/features/application/environment/model/app_environment.dart`) |
| 3+ values with differing **behavior** (event, fields, validation) | Behavior-variant UI model — `sealed` base, private `final` subclass per value | Shape: `FailureWidget.large/.small` (`packages/starter_uikit/lib/widgets/status/failure_widget.dart`) |
| Variant *derived* from domain data, carries payload, one widget renders it | `@freezed sealed` union with `from()` | [Payload variant](#payload-variant) |
| Behavior varies by **caller or environment** | Strategy — inject abstract type, choose in DI | `RepositoryExecutor` in `TaskRepository`; `mockOrProd` (`lib/core/di/mock_or_prod.dart`) |
| Same skeleton, different steps | Template Method (subclasses) or private shared method (one class) | `AppModule.registerDependencies`; `TasksListBloc._load` |
| Stacking optional behaviors | Decorator / mixin / collaborator — never 3-deep inheritance | `withErrorHandling().withRetry()`; `RefreshableBloc` |
| Collaborator that may be "absent" | Null Object | `MockNetworkBehavior.instant()` |

Threshold: UI model when 3+ values drive differing labels/icons/actions or the switch is already in
3+ files (`REUSE-1`).

---

## Code smells

### Smell 1: the same conditional in many widgets

**Real — below the threshold today.** Four widgets branch on the `bool task.isCompleted`
(`task_list_item_tile.dart`, `task_timeline_content_card.dart`, `task_timeline_item_card.dart`,
`task_details_content.dart`), each changing one style. Leave it alone. The day `isCompleted`
becomes `status: TODO | IN_PROGRESS | DONE`, those become four copies of one `switch (task.status)`;
the next status means four edits, or a `_ =>` arm that silently renders it as `todo`. Fix:
[UI Model Pattern](#ui-model-pattern).

### Smell 2: the same algorithm with small differences

**Real, both sides.** `TasksListBloc._load(emit)` holds the load-emit-catch sequence, called by
`_onRequested` and `_onRefreshed`. `CalendarBloc` still repeats the same
`try { … } on AppException catch` body in `_onDateSelected` and `_onRefreshed`, differing only in
which date it reads — a `REUSE-2` finding: extract and parameterize.

### Smell 3: boolean flags and long parameter lists

Flags that describe a variant without naming it — `TaskTile(showTimeRange:, showDescription:,
dismissible:, compact:)` (illustrative) makes the caller know which combination is "timeline card".
**Real fix shape:** `FailureWidget` is abstract; `const factory FailureWidget.large` / `.small`
redirect to private subclasses that each own their layout. The call site names the variant.

### Smell 4: null checks everywhere

An optional collaborator leaks `await _network?.simulate()` into every mock method. **Real fix:**
twins hold a non-nullable `MockNetworkBehavior`; tests pass `.instant()` — see
[Null Object](#null-object).

---

## Dart 3 first: sealed types and exhaustive switch

Before adding a class, check whether a `sealed` type with **one** exhaustive `switch` suffices.

**Real.** `CalendarStatus` (`@freezed sealed`) is mapped by exactly one `switch` in
`CalendarStatusBody` (`lib/features/task/ui/calendar/widget/calendar_status_body.dart`) — rendering
only, one consumer, no UI model. `AppException` → `ExceptionUiMapper.map` → `ExceptionUiModel` →
`FailureWidget` / `NotificationSnackBar` is a value-variant UI model already shipped.

- Never write `default:` / `_ =>` over an enum or sealed type you own — the non-exhaustive
  error is the feature. (`AppException.fromDioResponse` defaults on an `int?` status code, an open
  set — the legitimate use.)
- When a second widget needs the same switch, move it into a `from()` factory. Three is the review
  threshold; two is the smell.

---

## UI Model Pattern

**When:** a domain enum/sealed type renders differently per value (labels, icons, actions) with 3+
values or 3+ call sites. **How:** one presentation type whose `from(…)` factory holds the *only*
switch; widgets resolve it once and read fields; BLoCs never see it.

| Concern | Rule |
|---|---|
| Folder | `ui/{subfeature}/model/` of the owning subfeature (siblings may import it); feature-agnostic → `packages/starter_uikit/lib/models/` (`ExceptionUiModel`) |
| Name | `<Feature><Thing>UiModel`. `NAME-2` forbids a `Model` suffix on *domain* types; the `avoid_naming_antipatterns` lint exempts `UiModel`. `*Helper` / `*Mapper` / `*Model` are wrong here |
| Domain enum | Pure Dart in `model/`, wire mapping only (`wireValue`, `fromString`) — no `Localizer`, no `UiSvgIcons` (`ARCH-1`) |
| BLoC state/event | Holds the domain enum/model, never the UI model (`BLOC-5`); the widget maps at render time |

### Value variant — data-only differences

One class, `from()` holds the switch. Illustrative worked example:

```dart
// lib/features/task/ui/list/model/task_status_ui_model.dart
class TaskStatusUiModel {
  const TaskStatusUiModel({required this.label, required this.icon, this.isStruckThrough = false});

  // The ONE switch on TaskStatus in the UI layer.
  factory TaskStatusUiModel.from(TaskStatus status, Localizer localizer) => switch (status) {
    TaskStatus.todo => TaskStatusUiModel(label: localizer.statusTodo, icon: UiSvgIcons.clockTime),
    TaskStatus.inProgress => TaskStatusUiModel(label: localizer.statusInProgress, icon: UiSvgIcons.refreshArrow),
    TaskStatus.done => TaskStatusUiModel(label: localizer.statusDone, icon: UiSvgIcons.checkMark, isStruckThrough: true),
  };

  final String label;
  final String icon; // asset path from UiSvgIcons
  final bool isStruckThrough;
}

// Widget: resolve once at the top of build, then read fields — no switch.
final statusUi = TaskStatusUiModel.from(task.status, Localizer.of(context));
```

- Pass `Localizer` / `AppTheme` into `from()`; never store a `BuildContext`.
- Direct construction (defaults, tests)? Add named factories and have `from()` delegate — the
  `AppEnvironment.prod()/dev()/mock()` + `fromName` shape.
- Borderline real case: `ThemeModeOption`'s three data-only variants are switched in
  `theme_mode_helper.dart` and `theme_settings_tile.dart`; a UI model would fit but is not a mandate.

### Behavior variant — values differ in behavior

Use when the details screen's primary button must dispatch a different event per status, or a
variant needs an extra field; a value variant would bring `if (status == …)` back to the call site.

```dart
// Illustrative — lib/features/task/ui/details/model/task_status_ui_model.dart
sealed class TaskStatusUiModel {
  const TaskStatusUiModel(this._localizer);

  // Still the ONE switch on TaskStatus.
  factory TaskStatusUiModel.from(TaskStatus status, Localizer localizer) => switch (status) {
    TaskStatus.todo => _TodoTaskStatusUiModel(localizer),
    TaskStatus.inProgress => _InProgressTaskStatusUiModel(localizer),
    TaskStatus.done => _DoneTaskStatusUiModel(localizer),
  };

  final Localizer _localizer;

  String get actionLabel;

  /// Event the primary button dispatches — the behavior that differs.
  TaskStatusEvent toEvent(Task task);
}

final class _TodoTaskStatusUiModel extends TaskStatusUiModel {
  const _TodoTaskStatusUiModel(super.localizer);

  @override
  String get actionLabel => _localizer.startTask;

  @override
  TaskStatusEvent toEvent(Task task) => TaskStatusEvent.started(task.id);
}
// …_InProgress / _Done likewise

// Widget: no `if (task.status == …)`
final statusUi = TaskStatusUiModel.from(task.status, localizer);
AppElevatedButton(
  text: statusUi.actionLabel,
  onPressed: () => context.read<TaskStatusBloc>().add(statusUi.toEvent(task)),
)
```

- Subclasses stay **private** in the base class's file (same layout as `FailureWidget`); promote one
  to its own file only when something must reference it or the file passes ~200 lines (`FILE-2`).
- `sealed` keeps a later `switch (statusUi)` exhaustive. The model returns an **event** the widget
  `add`s; it never touches a BLoC, repository or `BuildContext` (`ARCH-4`, `ARCH-5`). Flows needing
  more than an event get a flag (`bool get requiresDatePicker => false`).

### Payload variant

Variant **computed** from several domain fields, carrying its own payload, rendered in one widget:
a `@freezed sealed class TaskTileUiModel` with `.upcoming(task)`, `.overdue(task, overdueBy)`,
`.done(task)` and a `factory TaskTileUiModel.from(Task task, {required DateTime now})` that is the
only place deriving the variant (illustrative). The tile does one exhaustive `switch`; if a second
widget switches on it, add getters to the union instead. Without a payload, prefer the value variant.

### Screen and route selection

An enum choosing which screen to push is one `switch` at the navigation call site. If 3+ places
choose, add `PageRouteInfo get route` to the UI model. No widget-returning factory classes.

Rules: one switch in `from()`; resolve once at the top of `build` (never `from()` per field);
nothing in BLoC state; context passed in, not stored (`POLY-3`…`POLY-6`).

---

## Strategy

Behavior differs by *who calls* or *which environment runs it*, not by a data value. The host holds
one field of the abstract type and never asks which one it got; the choice lives in DI.

**Real.** `TaskRepository` depends on abstract `TaskDataSource` and a `RepositoryExecutor`;
`TaskModule` registers the data source via `mockOrProd(mock: …, prod: …)` and the repository with
`const RawRepositoryExecutor().withErrorHandling()` (`lib/features/task/configs/task_module.dart`).
The repository has no `if (useMock)` and does not know whether it retries. When the strategy is one
stateless method, a function type beats a class (`optionLabelBuilder:`, `FormValidators.*`).

Placement: abstract type in `domain/`, implementations in `data/`, choice in `configs/`.
**Don't** put `bool isMock` or a `switch` on "which strategy am I holding" in the host.

---

## Factory

Lightest that fits: (1) a **factory constructor holding the single switch** (`TaskStatusUiModel.from`,
most uses); (2) a **static factory from an open input to a closed set** (`AppException.fromDioResponse`,
`AppEnvironment.fromName`); (3) **environment-dependent creation** — the DI module is the factory,
`mockOrProd` the only place that knows both implementations. An abstract-factory *class* is not
needed until several collaborating objects vary together; if it ever is, it lives in `configs/` so
`getIt` never leaks into BLoCs (`ARCH-4`).

---

## Template Method

Base class owns the sequence, subclasses override steps. **Real:** `AppModule.registerDependencies`
runs `unregisterCallbacks` then `register()`; `TaskModule` overrides only those two members, so the
ordering guarantee lives once (`lib/core/di/app_module.dart`).

Inside one class, the idiom is a private method parameterized by what differs: `TasksListBloc._load`
(Smell 2); `CalendarBloc` would use `_load(DateTime date, Emitter<CalendarState> emit)`.

**Don't** add a `BaseTaskBloc` to share a `_load`; share across BLoCs with a mixin
(`RefreshableBloc`, `packages/starter_toolkit/lib/utils/bloc/refreshable_bloc.dart`) or a
collaborator. A template method that `switch`es on `runtimeType` is the conditional again.

---

## Composition over inheritance

Inheritance depth is `abstract base → final concrete`; anything deeper becomes a decorator, mixin or
collaborator.

- **Decorators.** `ErrorHandlingExecutor` and `RetryExecutor` extend `RepositoryExecutorDecorator`,
  composed by `RawRepositoryExecutor().withErrorHandling().withRetry(maxRetries: 3)`
  (`packages/starter_toolkit/lib/data/repository_executor/`). `TaskRepository` holds *one* executor.
- **Collaborator.** `RepositoryCache` is injected *beside* the executor: it needs a key per call and
  cross-call state `execute(fn)` cannot express.
- **Validators / mixin.** Each `FormValidators.*` checks one thing and call sites compose a list;
  `RefreshableBloc` adds a `refreshing` stream to any BLoC without taking its superclass.

---

## Null Object

A do-nothing implementation of the same interface, injected instead of `null`.

**Real.** `MockNetworkBehavior.instant()` (zero wait, zero failure rate) — every
`Mock*DataSource` holds a non-nullable `MockNetworkBehavior` and always awaits `simulate()`; tests
pass `.instant()` (`../ai-context/mocking.md` `M5`). `AppModule.unregisterCallbacks => const []`
is the null object for "nothing to unregister".

**Illustrative** — an optional cache becomes a `NoOpRepositoryCache extends RepositoryCache` whose
`getOrFetch` just calls `fetch()` and `invalidate` does nothing, not a `RepositoryCache?` with
`?.` at every call.

---

## Testing variants

A UI model is pure Dart: test it as a table of `(input, expected)` records (like `T7`); behavior
variants also assert `toEvent(task)`. Strategies are covered by the feature-flow test (`T2`) — add a
per-strategy test only when it has logic of its own (executor tests, `T3`).

---

## Review checklist

Keyed to [`../ai-context/polymorphism.md`](../ai-context/polymorphism.md):

- Same enum/sealed type switched in 3+ places → `REUSE-1`; fix is a `from()` factory (`POLY-1`, `POLY-3`).
- Same try/emit/catch or loop body repeated with one varying input → `REUSE-2` (`POLY-9`).
- `default:` / `_ =>` on a type the PR owns → `POLY-7`.
- UI model in a Freezed state or event → `BLOC-5` / `POLY-5`.
- `TaskStatusModel` / `Helper` / `Mapper` → `NAME-2` / `NAME-3`; it is `TaskStatusUiModel` (`POLY-4`).
- `bool isMock` or `switch (runtimeType)` beside an injected strategy → `POLY-8`.
- Nullable collaborator with `?.` at every call → `POLY-9`.

## See also

- [`../rules/code_preferences.md`](../rules/code_preferences.md) §§ 11, 14 · [`exception_handling.md`](./exception_handling.md) — the shipped `AppException` → `ExceptionUiModel` pipeline
- [`../rules/naming.md`](../rules/naming.md) — `*UiModel` is the presentation suffix
