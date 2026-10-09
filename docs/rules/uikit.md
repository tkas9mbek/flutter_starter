# UIKit Rules

Rules for adding or changing shared widgets in [`packages/starter_uikit`](../../packages/starter_uikit). General code rules live in [`code_standards.md`](./code_standards.md); this file covers only what is specific to a design-system package.

## 1. Tokens only

A widget never decides its own look; it reads it from the theme.

```dart
@override
Widget build(BuildContext context) {
  final theme = ThemeProvider.of(context).theme;
  final textStyles = ThemeProvider.of(context).textStyles;
  // theme.primary, theme.surface, theme.error ... / textStyles.regularBody14 ...
}
```

- **Colors:** `AppTheme` fields (`theme.primary`, `theme.textSecondary`, …). No `Color(0x…)`, no `Colors.*`. The one allowed constant is `AppColors.transparent`.
- **Typography:** `AppTextStyles` members (`regularBody14`, `boldTitle20`, …). Tweak with `.copyWith(color: …)`; never build a `TextStyle(fontSize: …)` by hand.
- **Spacing/radii:** repeated values (paddings, radii, sizes) are named constants (file-private, or `configs/ui_consts.dart` if shared); a one-off literal inside a widget is fine.
- **Palette vs theme:** `AppColors` is the raw palette that `AppTheme` is built from. Widgets pick a *semantic* theme field, not a palette color.
- Use `ThemeProvider.of`, never `Theme.of` (Material's theme is not ours). Read the theme in `build()` only and never pass it down as a parameter — see [Theme](./code_standards.md#theme) (`theme_in_build_only`, `no_hardcoded_colors`).
- Icons are `UiSvgIcons.*` through `SvgIcon` ([Icons](./code_standards.md#icons-via-svgicon-never-material-icons)); text comes from `UikitLocalizer` or is injected by the caller.

## 2. Folder structure

```
lib/widgets/<category>/   # app_bar, bottom, button, dialogs, external, form, media, misc, screen, size, status, text
lib/theme/                # AppTheme, AppColors, AppTextStyles, ThemeProvider
lib/example/              # gallery app (screens/, widgets/, router/)
test/widgets/<category>/  # behavior tests, mirrors lib/widgets
```

- A folder is a **widget category**, not a single widget (`button/`, never `elevated_button/`). Create a new category only for 2+ related widgets that fit none of the existing ones.
- Nesting stays flat. Allowed sub-folders are category helpers such as `form/decoration/` or `form/country/`. `external/` holds vendored third-party widget copies, not new first-party widgets.
- No feature-specific widgets (`payment/`, `profile/`) and no implementation folders (`material/`, `cupertino/`). A widget used by one feature lives in that feature's `ui/{subfeature}/widget/`.
- Before adding anything, check whether an existing widget can take a parameter instead (AGENTS.md: "New shared widget/util → check `starter_uikit` first").

## 3. Public API

- One public class per file, file name == class name ([File Organization](./code_standards.md#file-organization)). Private helpers (`_Foo`) stay in the same file.
- Public widgets and their non-obvious parameters get a `///` summary of 1–3 lines: what it is, plus any non-obvious behavior (platform-adaptive, needs a parent `FormBuilder`, …). No usage snippets in docs — those belong in the gallery. See [Comments and documentation](./code_standards.md#comments-and-documentation).
- Import the specific file: `package:starter_uikit/widgets/button/app_elevated_button.dart`. There are no barrel files; do not add one.
- Variants of one widget are named constructors/factories (`AppElevatedButton.big/medium/small`), not sibling widgets.
- Constructors follow `sort_constructor_params` (required first, `super.key` last) and use `prefer_bool_default` for flags.

## 4. Gallery entry and test are part of "done"

Every new shared widget ships with both:

1. **Gallery:** a section in the matching `lib/example/screens/<category>_example_screen.dart` (new category → new screen + route in `example_router.dart` + tile in `uikit_menu_screen.dart`, then run build_runner). Show the meaningful states (enabled, disabled, loading, error), not just the happy path. Example code is annotated `@visibleForTesting` and is never imported by `lib/widgets`.
2. **Behavior test:** `test/widgets/<category>/<widget>_test.dart`, using `test/support/pump_app.dart` (`tester.pumpApp(...)`). Cover callbacks fired / not fired, state changes and visible text — no pixel or layout assertions. The app-wide `test/uikit/uikit_widgets_smoke_test.dart` only proves a widget builds; it does not replace the behavior test ([testing](../ai-context/testing.md), T7).

## 5. State handling (recommended)

For a widget whose look depends on interaction state, derive **one** small private visual-state enum from the inputs and switch over it, instead of scattering `enabled && !loading` through the tree:

```dart
enum _ButtonVisualState { enabled, loading, disabled }

_ButtonVisualState get _state => switch ((loading, enabled)) {
  (true, _) => _ButtonVisualState.loading, // loading outranks disabled
  (_, false) => _ButtonVisualState.disabled,
  _ => _ButtonVisualState.enabled,
};
```

- **Loading outranks disabled:** a loading button must look and behave as loading even if `enabled` is false, and taps are ignored in both.
- Keep the enum private to the file; expose booleans or named constructors, not the enum.
- Current buttons (`AppElevatedButton`, `AppOutlinedButton`, `AppBaseButton`) expose `enabled` / `loading` flags and compute `enabled && !loading` inline — accepted as-is; adopt the enum when a widget gains a third state (pressed, selected, error) or new colors depend on the combination.

## 6. Checklist for a new or changed widget

- [ ] No `Color(0x…)`, `Colors.*`, hand-built `TextStyle`, or `Theme.of` — tokens from `ThemeProvider` only
- [ ] Lives in the right `widgets/<category>/` folder; not feature-specific; no barrel
- [ ] One public class per file; `///` summary (1–3 lines) on the public class
- [ ] Strings localized or injected; icons via `UiSvgIcons` + `SvgIcon`
- [ ] Interaction state resolved in one place; loading outranks disabled
- [ ] Gallery section added in `lib/example/`
- [ ] Behavior test added in `test/widgets/<category>/`
- [ ] `cd packages/starter_uikit && fvm flutter test`, then `fvm flutter analyze` from the repo root (includes `starter_lints`)
