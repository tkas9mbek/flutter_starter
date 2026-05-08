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
| `sort_constructor_params` | INFO | Order: required → defaults → optional → super |
| `no_flutter_in_data_domain` | ERROR | No `package:flutter/*` or `dart:ui` imports under `data/` or `domain/` |
| `braces_in_flow_control` | WARNING | `for`/`while`/`do` always braced; multi-line `if` braced |
| `no_hardcoded_colors` | WARNING | No `Color(...)` / `Colors.X` outside theme/constants/tokens |
| `avoid_build_context_field` | WARNING | Don't store `BuildContext` as a field |
| `avoid_mutable_bloc_fields` | WARNING | BLoC/Cubit instance fields must be final (subscriptions/timers exempt) |
| `prefer_map_or_null` | INFO | `mapOrNull`/`whenOrNull` over `maybeMap`/`maybeWhen` with empty `orElse` |
| `prefer_bool_default` | INFO | Avoid `bool?` parameters — use a default value |

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

### no_flutter_in_data_domain

Forbids `package:flutter/*` and `dart:ui` imports inside files whose path contains `/data/` or `/domain/`. Only the presentation layer may depend on Flutter — keeping the lower layers Flutter-free makes them reusable and easy to unit-test.

```dart
// File: lib/features/user/data/remote_user_data_source.dart
// Bad
import 'package:flutter/foundation.dart';

// Good — pure-Dart alternative
import 'package:meta/meta.dart';
```

### braces_in_flow_control

`for`, `while`, and `do` always require braces. `if` / `else` requires braces when the body lives on a different line than the keyword; a single-line `if (cond) doIt();` is fine.

```dart
// Bad
for (final item in items)
  process(item);

if (ready)
  emit(MyState.ready());

// Good
for (final item in items) {
  process(item);
}

if (ready) emit(MyState.ready());          // single-line is allowed
if (ready) {
  emit(MyState.ready());                   // multi-line needs braces
}
```

### no_hardcoded_colors

No raw `Color(0xFF...)` or `Colors.X` references outside `**/theme/**`, `**/constants/**`, or `**/tokens/**`. UI must consume colors via `ThemeProvider` so the design system stays the source of truth.

```dart
// Bad — anywhere outside theme/constants/tokens
Container(color: Color(0xFF0066CC))
Container(color: Colors.blue)

// Good
final theme = ThemeProvider.of(context).theme;
Container(color: theme.colors.primary)
```

### avoid_build_context_field

Storing `BuildContext` as a field invites use-after-dispose bugs because `BuildContext` becomes invalid after rebuilds and unmounts.

```dart
// Bad
class MyService {
  MyService(this._context);
  final BuildContext _context;
}

// Good — pass context to the methods that need it
class MyService {
  void show(BuildContext context) { ... }
}
```

### avoid_mutable_bloc_fields

BLoC/Cubit subclasses must keep instance fields `final`. Mutable data must live in the Freezed state. Subscriptions, timers, cancel-tokens, and completers are exempt because they are infrastructure, not state.

```dart
// Bad
class UserBloc extends Bloc<UserEvent, UserState> {
  int _retries = 0;          // mutable instance field
  String _query = '';
}

// Good — keep state in the Freezed class
@freezed
class UserState with _$UserState {
  const factory UserState({
    required int retries,
    required String query,
  }) = _UserState;
}

class UserBloc extends Bloc<UserEvent, UserState> {
  late final StreamSubscription<User> _subscription;  // exempt
  Timer? _debounce;                                    // exempt
}
```

### prefer_map_or_null

When `maybeMap` / `maybeWhen` carries an empty `orElse: () {}`, the call is doing nothing for the unhandled cases — `mapOrNull` / `whenOrNull` says that more directly.

```dart
// Bad
state.maybeMap(
  failure: (s) => showError(s.exception),
  orElse: () {},
);

// Good
state.mapOrNull(
  failure: (s) => showError(s.exception),
);
```

### prefer_bool_default

`bool?` parameters force callers and consumers to handle three states. Pick a sensible default and use a non-nullable `bool`. If the third state has meaning, model it as an enum.

```dart
// Bad
void configure({bool? loud}) { ... }

// Good
void configure({bool loud = false}) { ... }

// Or — when null is meaningful
enum LoudPolicy { off, on, system }
void configure({LoudPolicy loud = LoudPolicy.system}) { ... }
```
