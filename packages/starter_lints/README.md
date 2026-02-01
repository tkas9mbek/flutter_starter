# Starter Lints

Custom lint rules for flutter_starter project.

## Status

**Active** - Enabled in `analysis_options.yaml` with `custom_lint` plugin.

## Available Lints

| Lint | Severity | Description |
|------|----------|-------------|
| `avoid_widget_functions` | WARNING | Prohibit `_build*` functions returning Widget |
| `prefer_arrow_except_build` | WARNING/INFO | Arrow for callbacks, block for `build()` only |
| `always_spread_in_collections` | INFO | Require `if (cond) ...[Widget()]` |
| `bloc_no_bloc_dependency` | WARNING | BLoCs cannot inject other BLoCs |
| `blank_line_before_return` | INFO | Require blank line before return |
| `prefer_named_parameters` | INFO | Use named params for 3+ parameters |
| `sort_constructor_params` | INFO | Order: required → defaults → optional → super |

## Usage

The lints are already configured in the project:

1. **Dependency** in root `pubspec.yaml`:
```yaml
dev_dependencies:
  starter_lints:
    path: ./packages/starter_lints
```

2. **Enabled** in `analysis_options.yaml`:
```yaml
analyzer:
  plugins:
    - custom_lint
```

3. **Run manually** (optional):
```bash
fvm dart run custom_lint
```

## Lint Details

### avoid_widget_functions

Detects functions that return Widget and start with `_build`.

```dart
// Bad
Widget _buildHeader() => Container();

// Good
class HeaderWidget extends StatelessWidget { ... }
```

### prefer_arrow_except_build

Enforces arrow syntax for callbacks, except `build()` method.

```dart
// Good - arrow for callbacks
onPressed: () => _submit(),
builder: (context, state) => Text(state.value),

// Bad - unnecessary block body
onPressed: () {
  return _submit();
},

// Bad - arrow in build
Widget build(BuildContext context) => Container();

// Good - block in build
Widget build(BuildContext context) {
  return Container();
}
```

### always_spread_in_collections

Enforces spread operator after if/for in collections.

```dart
// Bad
children: [
  if (show) Widget(),
]

// Good
children: [
  if (show) ...[
    Widget(),
  ],
]
```

### bloc_no_bloc_dependency

Prevents BLoCs from depending on other BLoCs.

```dart
// Bad
class MyBloc extends Bloc<E, S> {
  final OtherBloc _otherBloc;  // Violation
}

// Good - Use UI layer for coordination
MultiBlocListener(...)
```

### blank_line_before_return

Requires a blank line before return statements for readability.

```dart
// Bad
final result = calculate();
return result;

// Good
final result = calculate();

return result;
```

### prefer_named_parameters

Suggests named parameters for functions with 3 or more parameters.

```dart
// Bad - hard to read at call site
void configure(String host, int port, bool secure) { }
configure('localhost', 8080, true);  // What is true?

// Good
void configure({
  required String host,
  required int port,
  required bool secure,
}) { }
configure(host: 'localhost', port: 8080, secure: true);
```

### sort_constructor_params

Enforces constructor parameter ordering for consistency.

**Order:** required → defaults → optional → super

```dart
// Bad
const MyWidget({
  super.key,              // super should be last
  this.title,             // optional before required
  required this.onTap,
});

// Good
const MyWidget({
  required this.onTap,    // 1. required
  this.color = Colors.blue, // 2. with default
  this.title,             // 3. optional (nullable)
  super.key,              // 4. super last
});
```
