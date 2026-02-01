# Code Formatting Guide

> **AI Context**: Code formatting standards for the project. Follow these rules when writing or refactoring code.

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

**AI Instruction**: One public class per file. File name matches class name.

**Exceptions:**
- Private helper classes (prefix `_`)
- BLoC states/events in same file
- Simple related models (< 5 fields)
- Extension groups (`FeatureExtensions.dart`)

```dart
// ✓ Correct
// File: user_bloc.dart
@freezed
class UserEvent with _$UserEvent { ... }
@freezed
class UserState with _$UserState { ... }
class UserBloc extends Bloc<UserEvent, UserState> { ... }

// ✗ Wrong
// File: models.dart
class User { ... }
class Task { ... }
class Settings { ... }
```

---

## Class Size & SRP

**AI Instruction**: Use class size as SRP heuristic:
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

**AI Instruction**: Split large screens into smaller widgets:

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

**AI Instruction**: BLoCs must NOT depend on other BLoCs. Use UI layer for coordination.

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
          listener: (context, state) => state.whenOrNull(
            success: () => context.read<ItemsListBloc>().add(
              const ItemsListEvent.refreshed(),
            ),
          ),
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

**AI Instruction**: Add blank line before control structures:

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

**AI Instruction**: Always use brackets for control structures in regular code:

```dart
// ✓ Correct
if (condition) {
  doSomething();
}

// ✗ Wrong
if (condition) doSomething();
```

### Spread in Collections

**AI Instruction**: Always use spread operator `...[` after `if`/`for` in collections, even for single widget:

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

---

## Class Member Ordering

**AI Instruction**: Follow this order strictly:

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

**AI Instruction**: Order named parameters:

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

**AI Instruction**: Never create functions that return widgets. Extract to widget classes.

```dart
// ✗ Wrong
Widget _buildAvatar() => CircleAvatar(...);

// ✓ Correct
class UserAvatar extends StatelessWidget { ... }
```

**Why?** Better performance, cleaner code, easier testing.

### 2. StatefulWidget State

**AI Instruction**: StatefulWidget should be public, State class should be private:

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

**AI Instruction**: Always use arrow `=>` for callbacks, with two exceptions:
1. `build()` method - always uses block body `{}`
2. Nested callbacks - avoid `() => setState(() {})` pattern

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

// ✓ Correct - Arrow for listeners
BlocListener<Bloc, State>(
  listener: (context, state) => state.whenOrNull(
    failure: (e) => showError(e),
  ),
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

// ✗ Wrong - Unnecessary braces in simple callback
BlocListener<Bloc, State>(
  listener: (context, state) {
    state.whenOrNull(
      failure: (e) => showError(e),
    );
  },
)
```

**Summary**: Always use `=>` except for `build()` method and nested callbacks like `setState`.

### 4. Use whenOrNull Instead of maybeWhen

**AI Instruction**: For listeners with single case, use `whenOrNull` not `maybeWhen`:

```dart
// ✓ Correct
listener: (context, state) => state.whenOrNull(
  failure: (exception) => showError(exception),
),

// ✗ Wrong - Empty orElse
listener: (context, state) {
  state.maybeWhen(
    failure: (exception) => showError(exception),
    orElse: () {},
  );
},
```

### 5. Localization Required

**AI Instruction**: All user-facing strings MUST use localization:

```dart
// ✗ Wrong - Hard-coded strings
Text('Tasks')
Text('No tasks yet')

// ✓ Correct - Localized
Text(Localizer.of(context).tasks)
Text(Localizer.of(context).noTasksYet)
```

### 6. Use Toolkit/UIKit Helpers

**AI Instruction**: Reuse existing helpers from toolkit/uikit:

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

**AI Instruction**: Remove obvious comments that add no value:

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

**AI Instruction**: Call `super` at start, except `dispose()`/`deactivate()` at end:

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

**AI Instruction**: Write self-documenting code. Minimize inline comments.

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

**AI Instruction**: Document public APIs in shared modules (toolkit, uikit):

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

## Validation Checklist

| Category | Rules |
|----------|-------|
| **Files** | One public class per file • File name = class name |
| **Size** | Classes < 100 lines • Screens split into widgets • BLoCs independent |
| **Brackets** | Always brackets for control structures • Always `if (cond) ...[Widget()]` in collections |
| **Ordering** | Constructors → final fields → methods → `build()` → `==`/`hashCode`/`toString` |
| **Params** | required → defaults → optional → `super.key` |
| **Arrows** | Always `=>` except: `build()` method, nested callbacks `setState` |
| **Widgets** | No widget functions • Private state class • `super.init` first, `super.dispose` last |
| **Comments** | Self-documenting code • `///` for public APIs only • No obvious comments |

---

## Related Documentation

- [Architecture](./architecture.md) - Layer structure
- [Structure](./structure.md) - File organization
- [Naming](./naming.md) - Naming conventions

---

**Last Updated**: February 1, 2026
