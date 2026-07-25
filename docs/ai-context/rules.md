# Rules — AI Context

Hard rules for code generation. Full sources: [../rules/code_formatting.md](../rules/code_formatting.md), [../rules/naming.md](../rules/naming.md).

## Style

| # | Rule |
|---|------|
| S1 | Trailing commas everywhere they'd improve formatting. |
| S2 | Single quotes for strings. |
| S3 | Package imports only inside `lib/` and `packages/*/lib/`. No relative imports. |
| S4 | Always use arrow `=>` syntax, except `build()` and nested callbacks like `() => setState(() {})`. |
| S5 | Spread syntax in collections — `if (cond) ...[Widget()]` even for a single widget. |
| S6 | Use `var` for locals where the type is inferable. |
| S7 | After every `await` followed by `BuildContext` use, `if (!mounted) return;`. |

## Class size

- Target < 100 lines. Mandatory split at > 200 lines.
- Never use `Widget _foo() { ... }` builders. Extract to a `StatelessWidget` / `StatefulWidget` class.

## Comments

- No comments unless the *why* is non-obvious (constraint, invariant, workaround).
- `///` doc comments only for public APIs in `starter_toolkit` / `starter_uikit`.
- Never comment what the code already says.

## Naming

| Kind | Convention | Example |
|------|-----------|---------|
| Class | `PascalCase` | `UserRepository` |
| File | `snake_case` | `user_repository.dart` |
| Const | `lowerCamelCase` | `defaultTimeout` |
| Private state class | `_${Status}${Feature}State` | `_LoadingLoginState` |
| BLoC event factory | `.{verb}()` | `.submitted(form)`, `.refreshed()` |
| Async data fetch | `fetch*` / `get*` | `fetchUsers`, `getUserById` |
| Mutating | `create*` / `update*` / `delete*` | `createTask` |

## Forbidden

- ❌ `print` outside generators.
- ❌ Hardcoded strings in widgets — use `Localizer.of(context)`.
- ❌ Hardcoded colors / text sizes — use `ThemeProvider.of(context)`.
- ❌ `FormBuilder*` field widgets directly — use `starter_uikit` form widgets.
- ❌ `ControllerTextField` on multi-field screens — `FormBuilder` + `App*Field` there; `ControllerTextField` + `ValidatableTextEditingController` only for single-field screens (search, chat, OTP).
- ❌ Re-implementing widgets that exist in `starter_uikit` (status widgets, snackbars, app bars, buttons, fields).
- ❌ Re-implementing helpers that exist in `starter_toolkit` (`DateTimeHelpers`, validators, `AppException`).

## Pubspec dependency order

1. Flutter SDK first.
2. Then alphabetical.
3. dev_dependencies follow the same rule independently.
