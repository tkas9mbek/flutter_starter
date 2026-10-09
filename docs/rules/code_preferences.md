# Code Preferences

Stylistic conventions on top of [`code_standards.md`](./code_standards.md), [`naming.md`](naming.md) and [`bloc.md`](bloc.md) — established in AI-assisted sessions by the maintainer, not tool-enforced (anything a custom lint enforces lives in `code_standards.md`). Goal: generated code matches how this codebase is meant to evolve, not just what compiles. When one of these is more specific than a rule in `code_standards.md`, follow this one; when they conflict outright, flag it instead of silently picking either.

Section numbers are cited from other docs (`§ 11`, `§ 14`, `§ 15`) — keep them stable.

## Table of Contents

1. [Flat widget folders](#flat-widget-folders)
2. [Class Member Ordering](#class-member-ordering)
3. [Required-named for 5+ parameters](#required-named-for-5-parameters)
4. [Form fields inside a `FormBuilder`](#form-fields-inside-a-formbuilder)
5. [Comments stay within two lines](#comments-stay-within-two-lines)
6. [Container padding is horizontal-only](#container-padding-is-horizontal-only)
7. [Top-level private consts go right after imports](#top-level-private-consts-go-right-after-imports)
8. [Feature word leads the widget name](#feature-word-leads-the-widget-name)
9. [Private classes use a full descriptive name](#private-classes-use-a-full-descriptive-name)
10. [Terminal status screens use `AppStatusScreen`](#terminal-status-screens-use-appstatusscreen)
11. [Enum methods live in the enum body](#enum-methods-live-in-the-enum-body)
12. [Nested status for persistent data](#nested-status-for-persistent-data)
13. [`@JsonKey(fromJson:, toJson:)` over a hand-written `fromJson`](#jsonkeyfromjson-tojson-over-a-hand-written-fromjson)
14. [Prefer polymorphism over a repeated switch (Open/Closed)](#prefer-polymorphism-over-a-repeated-switch-openclosed)
15. [Tell, don't ask](#tell-dont-ask)
16. [Serialized enums need an `unknown` fallback](#serialized-enums-need-an-unknown-fallback)

---

## Flat widget folders

Keep `ui/widget/` flat — no `ui/widget/header/`, `ui/widget/footer/`. If flat browsing gets painful, split the **feature** by flow (`list/`, `details/`, `operation/`) instead, each with its own flat `widget/`.

```
✓ Good                              ✗ Bad
ui/widget/                          ui/widget/
├── user_avatar.dart                ├── header/
├── user_card.dart                  │   ├── user_avatar.dart
├── user_list_header.dart           │   └── user_list_header.dart
└── user_list_item.dart             └── list/
                                        ├── user_card.dart
                                        └── user_list_item.dart
```

---

## Class Member Ordering

1. Constructors (default first, then named)
2. Constants of same type
3. Static factory methods
4. Final fields (from constructor)
5. Other static methods/properties
6. Mutable properties (getter, field, setter together)
7. Read-only properties
8. Operators (except `==`)
9. Methods (except `toString`, `build`)
10. `build` method (for widgets)
11. `operator ==`, `hashCode`, `toString`

Named constructor parameters: required → with default → optional → `super.key` (lint `sort_constructor_params`).

```dart
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,        // 1. Required
    required this.title,
    this.color = Colors.blue,   // 2. With default
    this.icon,                  // 3. Optional
    super.key,                  // 4. Super
  });
}
```

---

## Required-named for 5+ parameters

For functions/constructors with 5 or more parameters, prefer named parameters with `required` so call sites self-document.

```dart
configure(host: 'localhost', port: 8080, secure: true, retries: 3, timeout: 5);
```

---

## Form fields inside a `FormBuilder`

When a field sits inside an ancestor `FormBuilder`, seed its starting value through `FormBuilder(initialValue: {...})`, not the field's own `initialValue:`. The `FormBuilder` is the single source of truth for what the form starts with; a field-level `initialValue` only makes sense when the field has no `FormBuilder` ancestor.

```dart
// ❌ Bad
AppTextField(name: AddressDetailsForm.cityField, initialValue: initialAddress.city);

// ✅ Good
FormBuilder(
  initialValue: {AddressDetailsForm.cityField: initialAddress.city},
  child: AppTextField(name: AddressDetailsForm.cityField),
);
```

---

## Comments stay within two lines

A multi-line explanatory comment is compressed to at most two lines (≤240 chars total, ~120 per line); trim the wording until it fits rather than keeping a longer version because it's under some other limit.

```dart
// ❌ Bad
// Creating a task does not make it the active one, so the task the
// user just added is selected in a second call. Editing deliberately
// leaves the current selection alone.

// ✅ Good
// Adding doesn't select the task; this call selects it in a second write. Editing deliberately leaves
// the current selection alone — nothing else touches it.
```

---

## Container padding is horizontal-only

`padding: EdgeInsets.all(...)` on a `SingleChildScrollView` (or similar scroll/scaffold container) carries only horizontal insets. Vertical spacing is explicit `SizedBox` / [`SafeVerticalBox`](../../packages/starter_uikit/lib/widgets/size/safe_vertical_box.dart) widgets inside the child list — use `SafeVerticalBox(bottom: true, height: ...)` as the last child of a bottom-fixed action column instead of wrapping it in `SafeArea`. Top and bottom insets are different concerns (a fixed gap vs. one that must grow for the safe area); one `EdgeInsets.all` can't express both.

```dart
// ❌ Bad
SafeArea(
  top: false,
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(children: [...]),
  ),
);

// ✅ Good
SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    children: [
      const SizedBox(height: 16),
      ...
      button,
      const SafeVerticalBox(bottom: true, height: 16),
    ],
  ),
);
```

---

## Top-level private consts go right after imports

A private top-level const like `const _pinSize = 48.0;` goes on the first line after the import block, not next to whatever widget uses it. A `static const` class member used only within its own file becomes a top-level private const too. One predictable place for every file-level constant.

```dart
// ❌ Bad
class _CountdownState extends State<Countdown> {
  static const int countdownSeconds = 20;
}

// ✅ Good
const int _countdownSeconds = 20;

class _CountdownState extends State<Countdown> { ... }
```

---

## Feature word leads the widget name

A widget's name starts with the feature/entity noun, then the description, then the type — never a verb or generic action word first. Everything in the `task` feature then sorts and reads together; this sharpens the Feature+Description+Type rule in [`naming.md`](naming.md) even when it reads less like natural English.

```dart
// ❌ Bad
class AddTaskButton extends StatelessWidget { ... }

// ✅ Good
class TaskAddButton extends StatelessWidget { ... }
```

---

## Private classes use a full descriptive name

A private (`_`-prefixed) class still spells out feature + description + type — never a bare `_Segment` or `_Item`. It is read out of context (search results, stack traces, review diffs) as often as a public one.

```dart
// ❌ class _Item extends StatelessWidget { ... }
// ✅
class _TaskListItem extends StatelessWidget { ... }
```

---

## Terminal status screens use `AppStatusScreen`

Full-screen outcome screens — task created/deleted, registration success/expired, startup failure, forced update — are all
[`AppStatusScreen`](../../packages/starter_uikit/lib/widgets/status/app_status_screen.dart), never a hand-rolled `Scaffold` + circle + `Spacer` column. Fixed layout: 120px icon circle, title, subtitle, full-width primary button, optional secondary button.

```dart
AppStatusScreen(
  icon: SvgIcon(UiSvgIcons.checkMark, size: 48, color: theme.primary),  // built widget
  title: localizer.taskCreatedTitle,                 // already localized
  subtitle: localizer.taskCreatedSubtitle,
  primaryButtonLabel: localizer.done,
  onPrimaryPressed: () => context.router.pop(),
  secondaryButtonLabel: localizer.backToList,        // optional, with onSecondaryPressed
  onSecondaryPressed: () => context.router.replaceAll([const TaskListRoute()]),
);
```

The widget reads only `ThemeProvider`; every string, icon and callback is passed in. That is a hard constraint — it must render standalone (e.g. from a DI-failure fallback shell), so no `Localizer`, `getIt`, `AppRouter`, or BLoC lookups inside it.

---

## Enum methods live in the enum body

A getter or method for an enum (a `wireValue` mapping, an `isX` predicate) goes directly inside the enum body — enhanced enums (Dart 2.17+) support members like a class. No separate `extension FooX on Foo` for a `Foo` the same file declares: one declaration to find, and no risk of the extension drifting to another file.

```dart
// ❌ Bad
enum TaskPriority { low, medium, high }

extension TaskPriorityX on TaskPriority {
  String get wireValue => switch (this) { ... };
}

// ✅ Good
enum TaskPriority {
  low,
  medium,
  high;

  String get wireValue => switch (this) {
    TaskPriority.low => 'LOW',
    TaskPriority.medium => 'MEDIUM',
    TaskPriority.high => 'HIGH',
  };
}
```

An extension is still right when the enum isn't locally owned (a Dart/Flutter core type like `DateTime`) or the method converts *between* two different enum types.

---

## Nested status for persistent data

State with fields that must survive a loading/success/failure transition (a filter, a search query, a selected id) nests a status union inside the state instead of duplicating those fields on every variant. Authoritative version with the full worked example: [`bloc.md` § Nested Status Pattern](./bloc.md#nested-status-pattern-persistent-data).

---

## `@JsonKey(fromJson:, toJson:)` over a hand-written `fromJson`

When a Freezed model's `fromJson` is hand-written purely to coerce a few field values (a date with a fallback, a type the backend doesn't guarantee), prefer the generated `fromJson` with per-field `@JsonKey(fromJson: ..., toJson: ...)` converters. Reserve a hand-written factory for real structural decoding a generated one can't express (nested object construction, cross-field logic). The field list stays the one place that documents each field's wire shape.

```dart
// ❌ Bad — hand-written only because one date field needs a fallback
factory Task.fromJson(Map<String, dynamic> json) => Task(
  id: json['id'] as String,
  title: json['title'] as String,
  dueAt: DateTime.tryParse(json['dueAt'] as String? ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
);

// ✅ Good
@Freezed(fromJson: true)
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    @JsonKey(fromJson: _dueAtFromJson) required DateTime dueAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

DateTime _dueAtFromJson(dynamic json) =>
    DateTime.tryParse(json as String? ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0);
```

Shared converters (`PrimitiveTypeConverters`) live in `starter_toolkit`; check there before writing a new one.

---

## Prefer polymorphism over a repeated switch (Open/Closed)

When an enum's per-value behavior (a label, a color, an icon, an action) is computed by a `switch`/if-chain copy-pasted across files, give each variant its own class carrying that behavior instead of adding branches at every call site — a sealed Freezed union, or for a 1:1 mapping with no payload and 3+ values/call sites, a plain value-variant UI model. Adding a variant is then one case in one place, and a forgotten call site is a compile error (non-exhaustive `switch`), not a silent gap a `default`/`orElse` would hide. Skip it for 1–2 simple values. Decision ladder and thresholds: [polymorphism guide](../guides/polymorphism.md).

The base class is `sealed` (an `abstract` one makes the `switch (this)` non-exhaustive).

```dart
// ❌ Bad — the same switch re-derived in every widget that needs a label
String _priorityLabel(TaskPriority priority, Localizer localizer) => switch (priority) {
  TaskPriority.low => localizer.priorityLow,
  TaskPriority.medium => localizer.priorityMedium,
  TaskPriority.high => localizer.priorityHigh,
};

// ✅ Good (illustrative — TaskPriority is not in the repo) — one place, callers stay switch-free
@freezed
sealed class TaskPriorityUiModel with _$TaskPriorityUiModel {
  const factory TaskPriorityUiModel.low() = _LowTaskPriorityUiModel;
  const factory TaskPriorityUiModel.medium() = _MediumTaskPriorityUiModel;
  const factory TaskPriorityUiModel.high() = _HighTaskPriorityUiModel;

  const TaskPriorityUiModel._();

  factory TaskPriorityUiModel.from(TaskPriority priority) => switch (priority) {
    TaskPriority.low => const TaskPriorityUiModel.low(),
    TaskPriority.medium => const TaskPriorityUiModel.medium(),
    TaskPriority.high => const TaskPriorityUiModel.high(),
  };

  String label(Localizer localizer) => switch (this) {
    _LowTaskPriorityUiModel() => localizer.priorityLow,
    _MediumTaskPriorityUiModel() => localizer.priorityMedium,
    _HighTaskPriorityUiModel() => localizer.priorityHigh,
  };
}
```

The `domain enum -> UI model` factory is the *only* switch left, and it lives in the UI layer — never in a BLoC or state. Everything downstream calls a method on the UI model.

---

## Tell, don't ask

Put the decision next to the data it depends on: a named getter/method on the model, enum or state, so callers ask one named question instead of re-deriving the rule from raw fields. When the invariant changes you edit one place, and a new enum/union case can't leave a copy-pasted condition silently stale.

```dart
// ❌ Bad — every caller reassembles the rule from raw fields
if (!task.isCompleted && task.endTime.isBefore(DateTime.now())) { ... }

// ✅ Good — the model owns the rule, the name is greppable (task.dart)
bool isOverdue(DateTime now) => !isCompleted && endTime.isBefore(now);

if (task.isOverdue(now)) { ... }
```

Same for a Freezed state (`bool get isLoading => this is LoadingMyState` instead of `state is LoadedMyState && state.items.isEmpty` at each call site) and for an enum (`bool get isX` in the body instead of `type == A || type == B` in three places). Pass the clock in (`now`) rather than reading `DateTime.now()` inside the model, so the rule stays testable.

---

## Serialized enums need an `unknown` fallback

An enum decoded from JSON declares an `unknown` member and the field carries `@JsonKey(unknownEnumValue: ...)`. Without it, `json_serializable` throws on any wire value the app doesn't know yet, so a backend that adds a value breaks every older client — with it, an unrecognised value degrades to a neutral case.

```dart
// ❌ Bad — a new backend value (e.g. 'URGENT') throws during fromJson
const factory Task({required String id, required TaskPriority priority}) = _Task;

// ✅ Good
enum TaskPriority {
  @JsonValue('LOW')
  low,
  @JsonValue('HIGH')
  high,
  unknown,
}

const factory Task({
  required String id,
  @JsonKey(unknownEnumValue: TaskPriority.unknown) required TaskPriority priority,
}) = _Task;
```

Handle `unknown` explicitly wherever the enum is switched on (a neutral label, no special behavior) — never let it fall through to a real value. For a nullable field, `JsonKey.nullForUndefinedEnumValue` is the alternative when "absent" is a valid state. Enums never decoded from the wire (local UI/state enums) don't need this.
