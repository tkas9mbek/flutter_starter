# Code Preferences

Personal stylistic conventions on top of [`code_standards.md`](./code_standards.md),
[`naming.md`](naming.md) and [`bloc.md`](bloc.md) — established in AI-assisted sessions by the
maintainer, not objective/tool-enforced rules (anything a custom lint enforces lives in
`code_standards.md` instead, even if it started life here). Goal: keep future generated code
matching how this codebase is actually meant to evolve, not just what compiles. When one of these
is more specific than a rule in `code_standards.md`, follow this one; when they conflict outright,
flag it instead of silently picking either.

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

---

## Flat widget folders

Keep `ui/widget/` flat — do not nest folders like `ui/widget/header/`, `ui/widget/footer/`. If a screen has so many widgets that flat browsing becomes painful, split the **feature** by flow (`list/`, `details/`, `operation/`) instead, each with its own flat `widget/`.

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

Follow this order strictly:

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

### Constructor Parameters

Order named parameters:

1. Required parameters
2. Parameters with defaults
3. Optional parameters
4. Super parameters (`super.key`)

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

For functions/constructors with 5 or more parameters, prefer named parameters with `required` so
call sites self-document.

```dart
configure(host: 'localhost', port: 8080, secure: true, retries: 3, timeout: 5);
```

---

## Form fields inside a `FormBuilder`

When a field sits inside an ancestor `FormBuilder`, seed its starting value through `FormBuilder(initialValue:
{...})`, not the field's own `initialValue:`.

```dart
// ❌ Bad
AppTextField(name: AddressDetailsForm.cityField, initialValue: initialAddress.city);

// ✅ Good
FormBuilder(
  initialValue: {AddressDetailsForm.cityField: initialAddress.city},
  child: AppTextField(name: AddressDetailsForm.cityField),
);
```

**Goal:** the `FormBuilder` is the single source of truth for what the form starts with; a field-level
`initialValue` only makes sense when the field has no `FormBuilder` ancestor to own it.

---

## Comments stay within two lines

A multi-line explanatory comment should be compressed to at most two lines (≤240 chars total, ~120 chars per
line), not left wrapped across three or more.

```dart
// ❌ Bad
// Creating a task does not make it the active one, so the task the
// user just added is selected in a second call. Editing deliberately
// leaves the current selection alone.

// ✅ Good
// Adding doesn't select the task; this call selects it in a second write. Editing deliberately leaves
// the current selection alone — nothing else touches it.
```

**Goal:** a comment block that takes three lines or more to scan past is worse than a tighter one that says the
same thing — trim the wording until it fits two lines, don't keep a longer version because it's under some other
limit.

---

## Container padding is horizontal-only

`padding: EdgeInsets.all(...)` on a `SingleChildScrollView` (or similar scroll/scaffold container) should carry
only horizontal insets. Vertical spacing is explicit `SizedBox`/`SafeVerticalBox` (`starter_uikit`'s
[`widgets/size/safe_vertical_box.dart`](../../packages/starter_uikit/lib/widgets/size/safe_vertical_box.dart))
widgets inside the child list — prefer `SafeVerticalBox(bottom: true, height: ...)` as the last child of a
bottom-fixed action column instead of wrapping it in `SafeArea`.

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

**Goal:** the top and bottom insets are different concerns (a fixed top gap vs. a bottom gap that must grow for
the safe area) — one `EdgeInsets.all` value can't express both, so keep them as separate, independently
adjustable widgets, and reuse one already-existing widget for "at least this much, more if the safe-area inset is
bigger" instead of re-deriving the same behavior with `SafeArea` per screen.

---

## Top-level private consts go right after imports

A private top-level const like `const _pinSize = 48.0;` goes on the first line after the import block, not
further down next to whatever widget happens to use it. This includes a `static const` class member that's only
used within its own file — convert it to a top-level private const instead of keeping it `static` on the class.

```dart
// ❌ Bad
class _CountdownState extends State<Countdown> {
  static const int countdownSeconds = 20;
  ...
}

// ✅ Good
const int _countdownSeconds = 20;

class _CountdownState extends State<Countdown> {
  ...
}
```

**Goal:** one predictable place to find and tune every file-level constant, instead of hunting through the file.

---

## Feature word leads the widget name

A widget's name starts with the feature/entity noun, then the description, then the type — never a verb or
generic action word first.

```dart
// ❌ Bad
class AddTaskButton extends StatelessWidget { ... }

// ✅ Good
class TaskAddButton extends StatelessWidget { ... }
```

**Goal:** everything belonging to the `task` feature sorts and reads together; this sharpens the
Feature+Description+Type rule already in [`naming.md`](naming.md) — the *feature* word specifically is the part
that must lead, even when it reads slightly less like natural English (`AddTaskButton`).

---

## Private classes use a full descriptive name

A private (`_`-prefixed) class name still spells out feature + description + type in full — never a bare generic
noun like `_Segment` or `_Item` just because it's private to the file.

```dart
// ❌ Bad
class _Item extends StatelessWidget { ... }

// ✅ Good
class _TaskListItem extends StatelessWidget { ... }
```

**Goal:** a private class is still read out of context (search results, stack traces, review diffs) just as
often as a public one — privacy is not a reason to drop the same Feature+Description+Type naming this file
already requires everywhere else.

---

## Terminal status screens use `AppStatusScreen`

Full-screen outcome screens — task created/deleted, registration success/expired, startup failure,
forced update — are all `AppStatusScreen`
(`packages/starter_uikit/lib/widgets/status/app_status_screen.dart`), never a hand-rolled
`Scaffold` + circle + `Spacer` column. It renders a fixed layout: 120px circular icon, then
title/subtitle, then a full-width primary button, then an optional secondary action.

> `AppStatusScreen` may not exist yet in `starter_uikit` — this rule states the target shape and
> location for it regardless; if it's missing, build it before relying on this rule (see the widget
> gallery under `packages/starter_uikit/lib/example/` for where to demo it once added).

```dart
AppStatusScreen(
  icon: SvgIcon(UiSvgIcons.checkMark, size: 48, color: theme.onPrimary), // required
  iconCircleColor: theme.primary,      // required
  title: localizer.taskCreatedTitle,   // required — already localized
  primaryButtonLabel: localizer.done,           // required
  onPrimaryPressed: () => context.router.pop(), // required
  subtitle: localizer.taskCreatedSubtitle,      // optional
  secondaryButtonLabel: localizer.backToList,   // optional — omit if there is none
  onSecondaryPressed: () => context.router.replaceAll([const TaskListRoute()]),
);
```

The widget reads only `ThemeProvider`; every string and callback is passed in via the constructor.
That is a hard constraint, not an accident — a full-screen status widget must be able to render
standalone (e.g. from a DI-failure fallback shell), so no `Localizer`, `getIt`, `AppRouter`, or BLoC
lookups may be added inside it. Icon-before-title ordering is fixed by design.

---

## Enum methods live in the enum body

When an enum needs a getter or method (e.g. a `wireValue` mapping, an `isX` predicate), add it
directly inside the enum body — Dart's enhanced enums (2.17+) support members just like a class.
Do not reach for a separate `extension FooX on Foo { ... }` block for a `Foo` this file already
declares.

```dart
// ❌ Bad
enum TaskPriority { low, medium, high }

extension TaskPriorityX on TaskPriority {
  String get wireValue => switch (this) {
    TaskPriority.low => 'LOW',
    TaskPriority.medium => 'MEDIUM',
    TaskPriority.high => 'HIGH',
  };
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

An extension is still the right tool when the enum isn't locally owned (a Dart/Flutter core type
like `DateTime`) or the method converts *between* two different enum types rather than adding a
member to one enum's own surface — there's no single enum body that conversion naturally belongs
in.

**Goal:** one declaration to find instead of two, and no risk of the extension drifting to a
different file than the enum it describes.

---

## Nested status for persistent data

Restated here for visibility — the authoritative version with the full worked example is
[`bloc.md` § 4, Nested Status Pattern](./bloc.md#4-nested-status-pattern-for-persistent-data). When
a state has fields that must survive a loading/success/failure transition (a filter, a search
query, a selected id), nest a status union inside the state instead of duplicating those fields on
every variant and hand-writing union-forwarding getters to expose them at the top level.

---

## `@JsonKey(fromJson:, toJson:)` over a hand-written `fromJson`

When a Freezed model's `fromJson` is hand-written purely to coerce a few field values (a date with
a fallback default, a type the backend doesn't guarantee), prefer a generated `fromJson` with
per-field `@JsonKey(fromJson: ..., toJson: ...)` converters over hand-parsing the whole class.
Reserve a genuinely hand-written `fromJson` factory for real structural decoding a generated one
can't express (nested object construction, cross-field logic).

```dart
// ❌ Bad — the only reason this is hand-written is one date field needing a fallback
factory Task.fromJson(Map<String, dynamic> json) {
  final epoch = DateTime.fromMillisecondsSinceEpoch(0);

  return Task(
    id: json['id'] as String,
    title: json['title'] as String,
    dueAt: PrimitiveTypeConverters.dateTimeFromJsonOrDefault(json['dueAt'], orElse: epoch),
  );
}

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
    PrimitiveTypeConverters.dateTimeFromJsonOrDefault(json, orElse: DateTime.fromMillisecondsSinceEpoch(0));
```

**Goal:** the field list stays the one place that documents what each field's wire shape is; a
hand-written factory hides that behind manual `json['x']` lookups that drift from the field list
over time.

---

## Prefer polymorphism over a repeated switch (Open/Closed)

When an enum's per-value behavior (a label, a color, an icon, an action) is computed by a
`switch`/if-chain that is copy-pasted or re-derived across multiple files, stop adding branches to
every call site and instead give each variant its own class carrying that behavior — a sealed
Freezed union or, for a simple 1:1 mapping with no payload, per-enum-value data. Adding a new
variant should mean adding one case in one place, not hunting down every switch that mentions the
enum.

```dart
// ❌ Bad — the same switch re-derived in every widget that needs a label
String _priorityLabel(TaskPriority priority, TaskLocalizer localizer) => switch (priority) {
  TaskPriority.low => localizer.priorityLow,
  TaskPriority.medium => localizer.priorityMedium,
  TaskPriority.high => localizer.priorityHigh,
  // ...repeated, slightly differently, in another widget file
};

// ✅ Good — one place, callers stay switch-free
@freezed
abstract class TaskPriorityUiModel with _$TaskPriorityUiModel {
  const factory TaskPriorityUiModel.low() = _LowTaskPriorityUiModel;
  const factory TaskPriorityUiModel.medium() = _MediumTaskPriorityUiModel;
  const factory TaskPriorityUiModel.high() = _HighTaskPriorityUiModel;

  const TaskPriorityUiModel._();

  factory TaskPriorityUiModel.from(TaskPriority priority) => switch (priority) {
    TaskPriority.low => const TaskPriorityUiModel.low(),
    TaskPriority.medium => const TaskPriorityUiModel.medium(),
    TaskPriority.high => const TaskPriorityUiModel.high(),
  };

  String label(TaskLocalizer localizer) => switch (this) {
    _LowTaskPriorityUiModel() => localizer.priorityLow,
    _MediumTaskPriorityUiModel() => localizer.priorityMedium,
    _HighTaskPriorityUiModel() => localizer.priorityHigh,
  };
}
```

The mapping `domain enum -> UI model` is the *only* switch left, and it lives in one UI-layer
factory — never in a BLoC or state. Everything downstream calls a method on the UI model instead of
re-matching the raw enum.

**Goal:** one switch to maintain instead of N, and a compiler error (a non-exhaustive `switch`) the
moment a new variant is added but a call site forgets to handle it — instead of a silent gap a
runtime `default`/`orElse` branch would hide.
