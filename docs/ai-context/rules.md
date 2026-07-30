# Rules — AI Context

Hard rules for code generation. Full sources: [../rules/code_formatting.md](../rules/code_formatting.md), [../rules/naming.md](../rules/naming.md).

## Style

| # | Rule |
|---|------|
| S1 | Trailing commas everywhere they'd improve formatting. |
| S2 | Single quotes for strings. |
| S3 | Package imports only inside `lib/` and `packages/*/lib/`. No relative imports. |
| S4 | Always use arrow `=>` syntax, except `build()`, nested callbacks, and `if-case` listener bodies — write `onPressed: () { setState(() {...}); }`, never arrow-in-arrow. |
| S5 | Spread syntax in collections — `if (cond) ...[Widget()]` even for a single widget. |
| S6 | Use `final` for locals by default; `var` only when the local is genuinely reassigned. |
| S7 | After every `await` followed by `BuildContext` use, `if (!mounted) return;`. |

## Class size

- Target < 100 lines. Mandatory split at > 200 lines.
- Never use `Widget _foo() { ... }` builders. Extract to a `StatelessWidget` / `StatefulWidget` class.

## Comments

- No comments unless the *why* is non-obvious (constraint, invariant, workaround).
- Comments and documentation must be concise but sufficient; describe only non-trivial behavior.
- Comment/doc lines may exceed 80 chars (unlike code) but must stay under 120 chars.
- `///` doc comments only for public APIs in `starter_toolkit` / `starter_uikit`.
- Never comment what the code already says — exclude the self-explanatory.

## Naming

| Kind | Convention | Example |
|------|-----------|---------|
| Class | `PascalCase` | `UserRepository` |
| File | `snake_case` | `user_repository.dart` |
| Const | `lowerCamelCase` | `defaultTimeout` |
| State case class (public) | `${Status}${Feature}State` | `LoadingLoginState` |
| Event case class (private) | `_${Verb}${Feature}Event` | `_SubmittedLoginEvent` |
| BLoC event factory | `.{verb}()` | `.submitted(form)`, `.refreshed()` |
| Async data fetch | `fetch*` / `get*` | `fetchUsers`, `getUserById` |
| Mutating | `create*` / `update*` / `delete*` | `createTask` |

## Forbidden

- ❌ `print` outside generators.
- ❌ Hardcoded strings in widgets — use `Localizer.of(context)`.
- ❌ Hardcoded colors / text sizes — use `ThemeProvider.of(context)`.
- ❌ Material `Icon`/`Icons.*` — render `UiSvgIcons` (Spider-generated) via `SvgIcon(UiSvgIcons.chevronRight, size: 20, color: ...)`.
- ❌ `FormBuilder*` field widgets directly — use `starter_uikit` form widgets.
- ❌ `ControllerTextField` on multi-field screens — `FormBuilder` + `App*Field` there; `ControllerTextField` + `ValidatableTextEditingController` only for single-field screens (search, chat, OTP).
- ❌ Raw string keys in forms — use a form UI model in `ui/{subfeature}/model/` with static field constants and `fromForm(...)` (`name: LoginForm.phoneField`, `LoginForm.fromForm(formKey.currentState!.value)`).
- ❌ Re-implementing widgets that exist in `starter_uikit` (status widgets, snackbars, app bars, buttons, fields).
- ❌ Re-implementing helpers that exist in `starter_toolkit` (`DateTimeHelpers`, validators, `AppException`).

## Pubspec dependencies

1. Flutter SDK first.
2. Then alphabetical.
3. dev_dependencies follow the same rule independently.
4. No version constraints in workspace package pubspecs (`shimmer:`, not `shimmer: ^3.0.0`) — the pub workspace resolves versions.
