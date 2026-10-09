# Rules — AI Context

Hard rules for code generation. Sources: [../rules/code_standards.md](../rules/code_standards.md), [../rules/code_preferences.md](../rules/code_preferences.md), [../rules/naming.md](../rules/naming.md). Style rules `S1`–`S9` (commas, quotes, package imports, arrows, spread, `final`, `context.mounted`, tell-don't-ask, `unknown` enum value) are in the [AGENTS.md](../../AGENTS.md) Code Style table.

## Class size

- Target < 100 lines; mandatory split at > 200.
- Never `Widget _foo() { ... }` builders — extract a `StatelessWidget` / `StatefulWidget` class.

## Comments

- None unless the *why* is non-obvious (constraint, invariant, workaround); never restate what the code says.
- Concise but sufficient; lines may exceed 80 chars (unlike code) but stay under 120.
- `///` only for public APIs in `starter_toolkit` / `starter_uikit`.

## Naming

| Kind | Convention | Example |
|------|-----------|---------|
| Class / File / Const | `PascalCase` / `snake_case` / `lowerCamelCase` | `UserRepository` / `user_repository.dart` / `defaultTimeout` |
| State case class (public) | `${Status}${Feature}State` | `LoadingLoginState` |
| Event case class (private) | `_${Verb}${Feature}Event` | `_SubmittedLoginEvent` |
| BLoC event factory | `.{verb}()` | `.submitted(form)`, `.refreshed()` |
| Async data fetch | `fetch*` / `get*` | `fetchUsers`, `getUserById` |
| Mutating | `create*` / `update*` / `delete*` | `createTask` |
| Source prefix | source first | `ApiUserDataSource`, `MockUserDataSource` |

No `Impl`/`Model`/`Helper`/`Manager`/`Data`/`Info`/`Util` suffixes (lint exempts `*UiModel`); BLoCs are nouns; file name == class name.

## Forbidden

- ❌ `print` outside generators.
- ❌ Hardcoded strings in widgets — `Localizer.of(context)`.
- ❌ Hardcoded colors / text sizes — `ThemeProvider.of(context)`.
- ❌ Material `Icon`/`Icons.*` — render `UiSvgIcons` (Spider-generated) via `SvgIcon(UiSvgIcons.chevronRight, size: 20, color: ...)`.
- ❌ `FormBuilder*` field widgets directly — use `starter_uikit` form widgets.
- ❌ `ControllerTextField` on multi-field screens — `FormBuilder` + `App*Field` there; `ControllerTextField` + `ValidatableTextEditingController` only for single-field screens (search, chat, OTP).
- ❌ Raw string keys in forms — form UI model in `ui/{subfeature}/model/` with static field constants and `fromForm(...)` (`name: LoginForm.phoneField`, `LoginForm.fromForm(formKey.currentState!.value)`).
- ❌ Re-implementing widgets in `starter_uikit` (status, snackbars, app bars, buttons, fields) or helpers in `starter_toolkit` (`DateTimeHelpers`, validators, `AppException`).

## Pubspec dependencies

1. Flutter SDK first, then alphabetical; `dev_dependencies` follow the same rule independently.
2. No version constraints in workspace package pubspecs (`shimmer:`, not `shimmer: ^3.0.0`) — the pub workspace resolves versions.
