# Polymorphism — AI Context

Concise rules. Full guide: [../guides/polymorphism.md](../guides/polymorphism.md). Preference source: [../rules/code_preferences.md § 14](../rules/code_preferences.md#prefer-polymorphism-over-a-repeated-switch-openclosed).

One `switch` per enum/sealed type per concern, in one place. The N-th copy is the bug, not the switch.

## When to use

| Variation | Use | Real example |
|---|---|---|
| 1–2 simple values, one style tweak per site | Inline `if` / ternary — build nothing | `task.isCompleted` in `task_list_item_tile.dart` |
| Closed set, data/rendering, consumed in **one** widget or mapper | `sealed class` + exhaustive `switch` there | `CalendarStatusBody`; `ExceptionUiMapper.map` |
| Same type switched in **3+ places**, differences are **data** (label, icon, flag) | Value-variant UI model: one class, `from()` holds the only switch | Shape: `AppEnvironment.prod()/dev()/mock()` + `fromName` |
| 3+ values with differing **behavior** (event to dispatch, fields shown, validation) | `sealed` UI model + private `final` subclass per value + `from()` | Shape: `FailureWidget.large/.small` |
| Variant derived from domain fields, carries payload, rendered in one widget | `@freezed sealed` union with `from()` + getters | [polymorphism.md § Payload variant](../guides/polymorphism.md#payload-variant) |
| Behavior varies by caller / environment, not by data | Strategy — inject the abstract type, choose in DI | `RepositoryExecutor` in `TaskRepository`; `mockOrProd` |
| Same algorithm, different steps | Template Method across subclasses; private `_load(emit)` inside one class | `AppModule.registerDependencies`; `TasksListBloc._load` |
| Stacking optional behaviors | Decorator / mixin / collaborator — never 3-deep inheritance | `withErrorHandling().withRetry()`; `RefreshableBloc` |
| Collaborator that may be "absent" | Null Object | `MockNetworkBehavior.instant()` |

## Pattern (value variant — the common case)

```dart
// ui/list/model/task_status_ui_model.dart — illustrative; TaskStatus is not in the repo
class TaskStatusUiModel {
  const TaskStatusUiModel({required this.label, required this.icon});

  // The ONE switch on TaskStatus in the UI layer.
  factory TaskStatusUiModel.from(TaskStatus status, Localizer localizer) =>
      switch (status) {
        TaskStatus.todo => TaskStatusUiModel(label: localizer.statusTodo, icon: UiSvgIcons.clockTime),
        TaskStatus.done => TaskStatusUiModel(label: localizer.statusDone, icon: UiSvgIcons.checkMark),
      };

  final String label;
  final String icon;
}

// Widget: resolve once in build, read fields — no switch.
final statusUi = TaskStatusUiModel.from(task.status, Localizer.of(context));
```

Behavior variant: same `from()`, but `sealed class TaskStatusUiModel` with `final class _DoneTaskStatusUiModel extends …` overriding `actionLabel` / `toEvent(task)`; the widget `add`s the returned event.

## Rules

| ID | Rule |
|---|---|
| POLY-1 | One `switch` per enum/sealed type per concern, in one place (`from()`, a mapper, or the single consuming widget). Same type switched in 3+ files → UI model or strategy (review `REUSE-1`). |
| POLY-2 | Thresholds = the first three rows of the table: 1–2 simple values → inline; closed set rendered in one place → `sealed` + exhaustive `switch`; 3+ values driving labels/icons/actions → UI model. |
| POLY-3 | Data-only variants → value variant (one class, `from()`). Behavior variants → `sealed` base + private `final` subclass per value. Derived payload → `@freezed sealed` union. |
| POLY-4 | UI models live in `ui/{subfeature}/model/` of the owning subfeature (`packages/starter_uikit/lib/models/` if feature-agnostic), named `<Feature><Thing>UiModel` — the one sanctioned `Model` suffix (lint exempts it). The domain enum stays pure Dart in `model/` (`wireValue` only). |
| POLY-5 | BLoC state and events store the domain enum/model, never the UI model (`BLOC-5`); the widget maps at render time. |
| POLY-6 | Resolve once: `final statusUi = XUiModel.from(…)` at the top of `build`, then read fields — never `from()` per field. Pass `Localizer`/`AppTheme` in; never store a `BuildContext`. |
| POLY-7 | No `default:` / `_ =>` arm in a `switch` over an enum or sealed type you own — exhaustiveness is the point. |
| POLY-8 | Behavior varying by caller/environment → inject: abstract in `domain/`, impls in `data/`, choice in `configs/`. The host holds one field of the abstract type and never asks which one it got (no `bool isMock`, no `switch (runtimeType)`). |
| POLY-9 | Same algorithm with differing steps → extract and parameterize (`REUSE-2`): private method inside one class, template method only across 2+ subclasses. Stacking behaviors → decorator/mixin/collaborator; optional collaborator → Null Object, not `?.` everywhere. |

## Don't

- ❌ The same `switch (task.status)` in the list tile, timeline card and details row.
- ❌ A UI model inside a Freezed state or event payload.
- ❌ `TaskStatusModel` / `TaskStatusHelper` / `TaskStatusMapper` — it is `TaskStatusUiModel`.
- ❌ `bool showTime, bool compact, bool dismissible…` flags that describe a variant — name it (`FailureWidget.large/.small`).
- ❌ `BaseTaskBloc` to share a `_load` between BLoCs — mixin or collaborator.
- ❌ Widget-returning factory classes for route selection — one `switch` at the navigation call site, or a `route` getter on the UI model.
