# Code Formatting Guide

> **AI Context**: Code formatting standards for the Eldik project. Follow these rules precisely when writing or refactoring code.

## Table of Contents

1. [Whitespace Rules](#whitespace-rules)
2. [Bracket Rules](#bracket-rules)
3. [Class Member Ordering](#class-member-ordering)
4. [Constructor Parameter Ordering](#constructor-parameter-ordering)
5. [Widget-Specific Rules](#widget-specific-rules)
6. [Function and Method Rules](#function-and-method-rules)
7. [Line Length Limits](#line-length-limits)
8. [Validation Checklist](#validation-checklist)

---

## Whitespace Rules

### 1. New Line Before Control Structures

Always add a blank line before: `return`, `for`, `if`, function/class declarations

```dart
// ✓ Correct
void processData(String input) {
  final data = parseInput(input);
  final validated = validateData(data);

  if (validated) {
    saveToDatabase(data);
  }

  return;
}
```

### 2. Logical Code Separation

Separate logically distinct code blocks with blank lines.

---

## Bracket Rules

### 1. Always Use Brackets for Control Structures

**In regular code**, always use brackets for `if`, `for`, `while`:

```dart
// ✓ Correct
if (condition) {
  doSomething();
}
```

### 2. Collection If/For - Use Spread Operator

**In collections**, use spread operator `...[]` for multiple widgets:

```dart
Column(
  children: [
    Text('Always visible'),

    if (isLoggedIn) ...[
      Text('Welcome back!'),
      LogoutButton(),
    ],

    if (showSingle)
      SingleWidget(),
  ],
)
```

---

## Class Member Ordering

Follow this strict order:

1. Constructors (default first, then named)
2. Constants of the same type
3. Static factory methods
4. Final fields from constructor
5. Other static methods/properties
6. Mutable properties (getter, field, setter - no blank lines between them)
7. Read-only properties
8. Operators (except `==`)
9. Methods (except `toString`, `build`)
10. `build` method (for widgets)
11. `operator ==`, `hashCode`, `toString`

---

## Constructor Parameter Ordering

For **named parameters**:

1. Required parameters (`required`)
2. Parameters with default values
3. Optional parameters
4. Super parameters (`super.key`, etc.)

```dart
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,           // 1. Required
    required this.title,            // 1. Required
    this.color = Colors.blue,       // 2. With default
    this.icon,                      // 3. Optional
    super.key,                      // 4. Super
  });
}
```

---

## Widget-Specific Rules

### 1. Don't Use Functions That Return Widgets

**IMPORTANT**: Never create functions that return widgets. Extract to separate widget classes.

```dart
// ✗ Wrong
Widget _buildAvatar() { return CircleAvatar(...); }

// ✓ Correct
class UserAvatar extends StatelessWidget { ... }
```

**Why?** Better performance, cleaner code, easier testing.

### 2. StatefulWidget - Public Functions, Private State Class

```dart
class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;  // Public state variable

  void increment() { ... }  // Public method (no underscore)
  void _reset() { ... }     // Private helper
}
```

### 3. Declare Theme Variables in build()

Don't store theme as state or pass as parameters - each widget accesses from context:

```dart
// ✓ Correct
class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomMainThemeData>();
    return Scaffold(backgroundColor: theme?.background);
  }
}

// ✗ Wrong
CustomMainThemeData? _theme;  // Don't store as state
```

### 4. Arrow Expression for Single-Line Callbacks

```dart
// ✓ Correct
ElevatedButton(
  onPressed: () => _submit(),
  child: const Text('Submit'),
)

BlocBuilder<FeatureBloc, FeatureState>(
  builder: (context, state) => AnimatedSwitcher(...),
)

// ✗ Wrong
onPressed: () {
  _submit();  // Unnecessary braces
},
```

### 5. Super Method Calls

Call `super` at the **start**, except for `dispose()` and `deactivate()` at **end**:

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

## Function and Method Rules

### Single-Line vs Multi-Line

- **Single expression**: Use arrow syntax
- **Multiple statements**: Use block body

```dart
// Single expression
int add(int a, int b) => a + b;

// Multiple statements
void processUser(User user) {
  final validated = validateUser(user);

  if (validated) {
    saveToDatabase(user);
  }
}
```

### Private vs Public

- **Public API**: No underscore
- **Internal implementation**: Prefix with `_`

---

## Line Length Limits

### Soft Limits

- **Simple code**: 100 characters
- **Complex code**: 200 characters (widgets with many parameters)

### Method Chaining

```dart
final result = repository
    .getUsers()
    .where((user) => user.isActive)
    .map((user) => user.toDto())
    .toList();
```

---

## Validation Checklist

### Whitespace
- [ ] Blank line before `return`, `if`, `for`, function declarations
- [ ] Logically separated code blocks
- [ ] No blank lines within property member groups

### Brackets
- [ ] All `if`/`for`/`while` have brackets in regular code
- [ ] Spread operator `...[]` for multiple widgets in collections
- [ ] Single widgets don't use spread operator

### Class Members
- [ ] Constructors first (default, then named)
- [ ] Final fields before mutable properties
- [ ] Properties grouped: getter, field, setter (no blank lines)
- [ ] `build` method before special methods
- [ ] `operator ==`, `hashCode`, `toString` at end

### Constructor Parameters
- [ ] Required parameters first
- [ ] Parameters with defaults second
- [ ] Optional parameters third
- [ ] Super parameters last

### Widgets
- [ ] No functions returning widgets
- [ ] StatefulWidget state class is private
- [ ] StatefulWidget state methods are public
- [ ] Theme declared in `build()`, not as state
- [ ] Theme not passed as parameters
- [ ] Arrow expressions for single-line callbacks/builders
- [ ] `super.initState()` at start, `super.dispose()` at end

### Functions
- [ ] Single expressions use arrow syntax
- [ ] Private implementation prefixed with `_`
- [ ] Lines under 100 (simple) or 200 (complex) characters

---

## Related Documentation

- [Naming Conventions](./naming-conventions.md) - Naming standards
- [Architecture Guide](./architecture.md) - Layer structure
- [Single Responsibility Principle](./single-responsibility-principle.md) - Class design

---

**Last Updated**: November 12, 2025
