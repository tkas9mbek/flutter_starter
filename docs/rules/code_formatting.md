# Code Formatting Guide

## Table of Contents

1. [File Organization](#file-organization)
2. [Class Size & SRP](#class-size--srp)
3. [Whitespace & Brackets](#whitespace--brackets)
4. [Class Member Ordering](#class-member-ordering)
5. [Widget Rules](#widget-rules)
6. [Comments](#comments)
7. [Validation Checklist](#validation-checklist)

---

## File Organization

One public class per file. File name matches class name.

**Exceptions:**
- Private helper classes (prefix `_`)
- BLoC states/events in same file
- Simple related models (< 5 fields)
- Extension groups (`FeatureExtensions.dart`)

```dart
// ✓ Correct
// File: user_bloc.dart
@freezed
sealed class UserEvent with _$UserEvent { ... }
@freezed
sealed class UserState with _$UserState { ... }
class UserBloc extends Bloc<UserEvent, UserState> { ... }

// ✗ Wrong
// File: models.dart
class User { ... }
class Task { ... }
class Settings { ... }
```

### Flat widget folders

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

## Class Size & SRP

Use class size as SRP heuristic:
- **< 100 lines**: ✅ Good
- **100-200 lines**: ⚠️ Review carefully
- **> 200 lines**: ❌ Split it!

### When to Split

**1. Can I describe it in one sentence without "and"?**

```dart
// ✗ Wrong
class ItemManager {
  Future<List<Item>> fetch() { ... }
  Future<void> delete(String id) { ... }
  Future<List<Item>> search(String query) { ... }
}

// ✓ Correct - Split by responsibility
class ItemRepository { Future<List<Item>> getItems() { ... } }
class ItemDeletionService { Future<void> delete(String id) { ... } }
class ItemSearchService { Future<List<Item>> search(String query) { ... } }
```

**2. How many reasons does it have to change?**

One reason to change = One responsibility ✅

**3. Are there logical groupings of methods?**

If yes, split into separate classes.

### Screen Widgets

Split large screens into smaller widgets:

```dart
// ✗ Wrong - 220+ lines
class TasksListScreen extends StatelessWidget {
  Widget _buildAppBar() { ... }      // 30 lines
  Widget _buildSearchBar() { ... }   // 25 lines
  Widget _buildFilters() { ... }     // 35 lines
  Widget _buildList() { ... }        // 80 lines
}

// ✓ Correct - Split into focused widgets
class TasksListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TasksAppBar(),
      body: Column(
        children: [
          const TaskSearchBar(),
          const TaskFilterChips(),
          const TasksList(),
        ],
      ),
    );
  }
}
```

### BLoC Separation

BLoCs must NOT depend on other BLoCs. Use UI layer for coordination.

```dart
// ✗ Wrong - Direct BLoC dependency
@injectable
class ItemsListBloc extends Bloc<ItemsListEvent, ItemsListState> {
  final ItemDeletionBloc _deletionBloc;  // ✗ Creates tight coupling!

  ItemsListBloc(this._repository, this._deletionBloc) : super(...) {
    _deletionBloc.stream.listen((state) {
      if (state is SuccessItemDeletionState) {
        add(const ItemsListEvent.refreshed());
      }
    });
  }
}

// ✓ Correct - UI layer coordinates BLoCs
class ItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ItemDeletionBloc, ItemDeletionState>(
          listener: (context, state) {
            if (state is SuccessItemDeletionState) {
              context.read<ItemsListBloc>().add(
                const ItemsListEvent.refreshed(),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ItemsListBloc, ItemsListState>(...),
    );
  }
}
```

**Why?**
- ✅ BLoCs remain testable independently
- ✅ No circular dependencies
- ✅ Clear separation of concerns
- ✅ UI controls orchestration

---

## Whitespace & Brackets

### Whitespace Rules

Add blank line before control structures:

```dart
// ✓ Correct
void process(String input) {
  final data = parseInput(input);

  if (validated) {  // Blank line before if
    save(data);
  }

  return;  // Blank line before return
}
```

### Bracket Rules

Always use brackets for control structures in regular code:

```dart
// ✓ Correct
if (condition) {
  doSomething();
}

// ✗ Wrong
if (condition) doSomething();
```

### Spread in Collections

Always use spread operator `...[` after `if`/`for` in collections, even for single widget:

```dart
// ✓ Correct - Spread for multiple widgets
Column(
  children: [
    Text('Title'),

    if (showItems) ...[
      Item1(),
      Item2(),
    ],
  ],
)

// ✓ Correct - Spread even for single widget (consistency)
Column(
  children: [
    Text('Title'),

    if (showSingle) ...[
      SingleItem(),
    ],
  ],
)

// ✗ Wrong - No spread operator
Column(
  children: [
    Text('Title'),

    if (showSingle)
      SingleItem(),  // Hard to see where condition ends
  ],
)
```

### Underscore Prefix is for Class Members Only

A leading `_` declares a private class-level member. Don't use it on local variables inside methods — local privacy is implicit.

```dart
// ✗ Wrong
final _result = await _repository.fetch();
final _filtered = _result.where((e) => e.active).toList();

return _filtered;

// ✓ Correct
final result = await _repository.fetch();
final filtered = result.where((e) => e.active).toList();

return filtered;
```

### Multi-line Ternary → if/else

A ternary expression that spans many lines reads worse than an explicit `if`/`else`. Convert when:

- A single-condition ternary spans **more than 10 lines**.
- A nested (2+) ternary spans **5+ lines**.

```dart
// ✗ Wrong - nested ternary, hard to scan
final label = state.isLoading
    ? localizer.loading
    : state.hasError
        ? localizer.error
        : state.isEmpty
            ? localizer.empty
            : localizer.ready;

// ✓ Correct - explicit if/else with early returns
String _resolveLabel(MyState state, Localizer localizer) {
  if (state.isLoading) return localizer.loading;
  if (state.hasError) return localizer.error;
  if (state.isEmpty) return localizer.empty;

  return localizer.ready;
}
```

A short ternary on one line stays a ternary — this rule is about long, branching ones.

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

## Widget Rules

### 1. No Functions Returning Widgets

Never create functions that return widgets. Extract to widget classes.

```dart
// ✗ Wrong
Widget _buildAvatar() => CircleAvatar(...);

// ✓ Correct
class UserAvatar extends StatelessWidget { ... }
```

**Why?** Better performance, cleaner code, easier testing.

### 2. StatefulWidget State

StatefulWidget should be public, State class should be private:

```dart
class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;  // Public variable (no underscore)

  void increment() { ... }  // Public method
  void _reset() { ... }     // Private helper
}
```

### 3. Arrow Expressions

Always use arrow `=>` for callbacks, with three exceptions:
1. `build()` method - always uses block body `{}`
2. Nested callbacks - avoid `() => setState(() {})` pattern
3. Listeners with `if-case` statements - statements need a block body

```dart
// ✓ Correct - Arrow for callbacks
ElevatedButton(
  onPressed: () => _submit(),
  child: const Text('Submit'),
)

// ✓ Correct - Arrow for builders
BlocBuilder<Bloc, State>(
  builder: (context, state) => AnimatedSwitcher(...),
)

// ✓ Correct - Listeners use if-case pattern matching (block body)
BlocListener<Bloc, State>(
  listener: (context, state) {
    if (state case FailureState(:final exception)) {
      showError(exception);
    }
  },
)

// ✓ Correct - build() ALWAYS uses block body
@override
Widget build(BuildContext context) {
  return Container();
}

// ✓ Correct - Nested callback uses block body (avoid arrow-in-arrow)
onPressed: () {
  setState(() {
    _counter++;
  });
},

// ✗ Wrong - Arrow in build method
@override
Widget build(BuildContext context) => Container();

// ✗ Wrong - Nested arrow callbacks (hard to read)
onPressed: () => setState(() => _counter++),
```

**Summary**: Always use `=>` except for `build()` method, nested callbacks like `setState`, and listeners that use `if-case` statements.

### 4. Use if-case Pattern Matching in Listeners

For listeners, pattern-match on the sealed state with `if-case` (or plain `is` checks). Freezed 3 removed the generated `whenOrNull` / `maybeWhen` methods.

```dart
// ✓ Correct
listener: (context, state) {
  if (state case FailureLoginState(:final exception)) {
    showError(exception);
  }
},

// ✗ Wrong - Legacy Freezed 2 methods (removed in Freezed 3)
listener: (context, state) {
  state.maybeWhen(
    failure: (exception) => showError(exception),
    orElse: () {},
  );
},
```

### 4a. BlocBuilder Uses an Exhaustive switch

`BlocBuilder` must always return a non-null `Widget`. Use an exhaustive `switch` expression (or statement) over the sealed state so the compiler guarantees every case returns a Widget.

The pairing is:

| Widget | Use | Why |
|--------|-----|-----|
| `BlocBuilder` | exhaustive `switch` on the sealed state | must return a Widget for every state |
| `BlocListener` | `if-case` / `is` checks | side-effects only, no return |

```dart
// ✓ Correct
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) => switch (state) {
    SuccessMyState(:final data) => SuccessView(data: data),
    FailureMyState(:final exception) => FailureWidget.large(
      exception: exception,
      onRetry: _retry,
    ),
    InitialMyState() || LoadingMyState() =>
      const CustomCircularProgressIndicator.adaptive(),
  },
)

// ✗ Wrong - Legacy Freezed 2 maybeMap (removed in Freezed 3)
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) => state.maybeMap(
    success: (s) => SuccessView(data: s.data),
    orElse: () => const CustomCircularProgressIndicator.adaptive(),
  ),
)
```

### 5. Localization Required

All user-facing strings MUST use localization:

```dart
// ✗ Wrong - Hard-coded strings
Text('Tasks')
Text('No tasks yet')

// ✓ Correct - Localized
Text(Localizer.of(context).tasks)
Text(Localizer.of(context).noTasksYet)
```

### 6. Use Toolkit/UIKit Helpers

Reuse existing helpers from toolkit/uikit:

```dart
// ✗ Wrong - Manual date comparison
final isToday = DateTime.now().year == date.year &&
    DateTime.now().month == date.month &&
    DateTime.now().day == date.day;

// ✓ Correct - Use DateTimeHelpers extension
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

final isToday = date.isToday;
final isTomorrow = date.isTomorrow;
```

### 7. No Useless Comments

Remove obvious comments that add no value:

```dart
// ✗ Wrong
// Date Header
Padding(...)

// Task Info
Expanded(...)

// Checkbox
Checkbox(...)

// ✓ Correct - No comment needed, code is self-explanatory
Padding(...)
Expanded(...)
Checkbox(...)
```

### 8. Super Method Calls

Call `super` at start, except `dispose()`/`deactivate()` at end:

```dart
@override
void initState() {
  super.initState();  // At start
  _controller = TextEditingController();
}

@override
void dispose() {
  _controller.dispose();  // Cleanup first
  super.dispose();        // At end
}
```

---

## Comments

Write self-documenting code. Minimize inline comments.

### Minimize Code Comments

```dart
// ✗ Wrong - Over-commented
void calculateTotal(List<Item> items) {
  // Initialize total
  double total = 0;
  // Loop through items
  for (final item in items) {
    // Add price
    total += item.price;
  }
  return total;
}

// ✓ Correct - Self-documenting
double calculateTotal(List<Item> items) =>
    items.fold(0, (sum, item) => sum + item.price);
```

### Public API Documentation

Document public APIs in shared modules (toolkit, uikit):

- ✅ 1-3 line summary using `///`
- ✅ Brief description of purpose
- ❌ No obvious comments

```dart
/// Repository executor with automatic retry logic.
///
/// Retries failed operations up to [maxRetries] times.
class RetriableRepositoryExecutor extends RepositoryExecutor { ... }
```

**When to document:**
- Public classes in shared modules
- Complex algorithms
- Non-obvious behavior

**What NOT to document:**
- Obvious getters/setters
- Simple private methods
- Self-explanatory code

---

## Line Length Limits

- **100 characters** for ordinary code.
- **200 characters** for deeply composed widget trees where a chain still reads cleaner on one line than broken up.

When a line approaches the limit, prefer:

1. Extracting a complex sub-expression to a named local variable.
2. Splitting a builder into a private widget class.
3. Method chaining onto a new line (each `.method()` aligned).

Hard-wrapping a single expression mid-argument is the worst option — extract first.

---

## Data Layer

### No `print()` in production code

```dart
// ❌ BAD — strips no metadata, lands in production logs
print(error);

// ✅ FIX — use Flutter's debug-aware logger or dart:developer
debugPrint('$error');
log('Failed to fetch payments: $error', name: 'PaymentRepository');
```

`print` is allowed only inside `utils/generators/` (developer scripts).

### Generated mappers are read-only

`exception_ui_mapper.dart` and `exception_ui_mapper_decorator.dart` are produced by `dart run utils/generators/generate_exception_mapper.dart`. Never edit them by hand — the next codegen run will overwrite your changes. Add new mappings by adding `@ExceptionUiConfig` factories to `AppException` and re-running the generator.

---

## Cleanup & Anti-Patterns

| Rule | Why |
|------|-----|
| No backwards-compat aliases | Dead code bloat; confuses new readers |
| No empty stub methods | File clutter; signal that a TODO was abandoned |
| No scattered `// ignore:` lines | Fix the root cause. When unavoidable, use `// ignore_for_file:` at the top of the file with a `—` justification, e.g. `// ignore_for_file: avoid_print — developer-only generator script`. Prefer file-level over per-line ignores. |
| Add `Key` only when needed | Unnecessary keys defeat Flutter's widget-reuse optimization |
| Comments only when WHY is non-obvious | The code already says WHAT |
| No leftover `_unused` renamed locals after a refactor | Delete instead — name is not load-bearing context |

---

## Validation Checklist

| Category | Rules |
|----------|-------|
| **Files** | One public class per file • File name = class name |
| **Size** | Classes < 100 lines • Screens split into widgets • BLoCs independent |
| **Lines** | < 100 chars (simple) • < 200 chars (complex widget chains) |
| **Brackets** | Always brackets for control structures • Always `if (cond) ...[Widget()]` in collections |
| **Ordering** | Constructors → final fields → methods → `build()` → `==`/`hashCode`/`toString` |
| **Params** | required → defaults → optional → `super.key` |
| **Arrows** | Always `=>` except: `build()` method, nested callbacks `setState` |
| **Widgets** | No widget functions • Private state class • `super.init` first, `super.dispose` last |
| **Comments** | Self-documenting code • `///` for public APIs only • No obvious comments |
| **Logging** | `debugPrint` / `log` only • Never `print` outside `utils/generators/` |
| **Cleanup** | No back-compat aliases • No empty stubs • Prefer `ignore_for_file:` with justification |

---

## Related Documentation

- [Architecture](../guides/architecture.md) - Layer structure
- [Structure](../guides/structure.md) - File organization
- [Naming](./naming.md) - Naming conventions
- [Git Workflow](./git_workflow.md) - Branch & commit rules
