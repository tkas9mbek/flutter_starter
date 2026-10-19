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
- **Flat design:** no `BoxShadow`, elevation, ripple or surface tint. `theme.background` is both the scaffold and the app bar; cards, sheets, dialogs and fields are `theme.surface` with a 1px `theme.border`. Radii come from `AppRadii`, never numeric literals.
- **Role tokens:** `primary`/`onPrimary` for filled brand surfaces; `accent` for brand-coloured text, icons, outlines and spinners drawn on the page (`primary` is too dark there in dark mode); `success`/`error`/`warning`/`info` are solid status fills carrying `onStatus`; `errorText`/`successText` are for status text or icons directly on `background`/`surface`; `borderStrong` outlines interactive controls.
- **Palette vs theme:** `AppColors` (navy / slate / ink / cyan scales plus status shades) is the raw palette that `AppTheme.light()` / `.dark()` are built from. Widgets pick a *semantic* theme field, not a palette color. `AppTheme.toThemeData()` (`themeDataFromTheme`) projects the same tokens onto Material's `ThemeData` for widgets the uikit does not own — a new token that Material widgets must honour is wired there too.
- Use `ThemeProvider.of`, never `Theme.of` (Material's theme is not ours). Read the theme in `build()` only and never pass it down as a parameter — see [Theme](./code_standards.md#theme) (`theme_in_build_only`, `no_hardcoded_colors`).
- **Tappable means accessible:** make an area tappable with `AppTapArea` (an `InkWell` plus button semantics, no splash), a Material button, or an `InkWell` — never a bare `GestureDetector`, which a screen reader and a keyboard cannot reach. An icon with no text passes a localized `semanticLabel`; a disabled control passes `onTap: null`, not an empty callback. `GestureDetector` stays for gestures that are not taps on a control (unfocus-on-tap, the dev menu's hidden multi-tap `TapActivator`).
- Icons are `UiSvgIcons.*` through `SvgIcon` ([Icons](./code_standards.md#icons-via-svgicon-never-material-icons)); text comes from `UikitLocalizer` or is injected by the caller.

## 2. Folder structure

```
lib/widgets/<category>/   # app_bar, bottom, button, dialogs, external, form, media, misc, screen, size, status, text
lib/theme/                # AppTheme, AppColors, AppRadii, AppTextStyles, ThemeProvider, themeDataFromTheme
lib/example/              # gallery app (screens/, widgets/, router/, cubit/)
test/widgets/<category>/  # behavior tests, mirrors lib/widgets
```

- A folder is a **widget category**, not a single widget (`button/`, never `elevated_button/`). Create a new category only for 2+ related widgets that fit none of the existing ones.
- Nesting stays flat. Allowed sub-folders are category helpers such as `form/decoration/` or `form/country/`. `external/` holds vendored third-party widget copies, not new first-party widgets.
- No feature-specific widgets (`payment/`, `profile/`) and no implementation folders (`material/`, `cupertino/`). A widget used by one feature lives in that feature's `ui/{subfeature}/widget/`.
- **Compose, don't re-skin:** list/settings/info rows are built from the shared `misc/` surfaces — `AppCard` (bordered surface, optional tap/`selected`), `GroupedRowsCard` (card with dividers between rows), `AppListTile` (icon + title/subtitle + value/chevron row), `StatusPill` (solid status label) — never a feature-local card or tile that repeats their border/radius/padding. Need a variation? Add a parameter to the shared widget.
- Before adding anything, check whether an existing widget can take a parameter instead (AGENTS.md: "New shared widget/util → check `starter_uikit` first").

## 3. Public API

- One public class per file, file name == class name ([File Organization](./code_standards.md#file-organization)). Private helpers (`_Foo`) stay in the same file.
- Public widgets and their non-obvious parameters get a `///` summary of 1–3 lines: what it is, plus any non-obvious behavior (platform-adaptive, needs a parent `FormBuilder`, …). No usage snippets in docs — those belong in the gallery. See [Comments and documentation](./code_standards.md#comments-and-documentation).
- Import the specific file: `package:starter_uikit/widgets/button/app_elevated_button.dart`. There are no barrel files; do not add one.
- Variants of one widget are named constructors/factories (`AppElevatedButton.big/medium/small`), not sibling widgets.
- Constructors follow `sort_constructor_params` (required first, `super.key` last) and use `prefer_bool_default` for flags.

## 4. Gallery entry and test are part of "done"

Every new shared widget ships with both:

1. **Gallery:** a section (`ExampleSection`) in the matching `lib/example/screens/*_example_screen.dart` — `buttons_`, `form_fields_`, `status_widgets_`, `app_bars_`, `dialogs_`, `text_widgets_`, `misc_widgets_` (cards, tiles, pills, dividers), `pagination_` (new category → new screen + route in `example_router.dart` + an `AppListTile` in `uikit_menu_screen.dart`, then run build_runner). Show the meaningful states (enabled, disabled, loading, error), not just the happy path. Example code is annotated `@visibleForTesting` and is never imported by `lib/widgets`.
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
- **Documented exception:** `TextFieldVisualState` (`widgets/form/decoration/text_field_visual_state.dart`: `idle`/`focused`/`error`/`disabled`) is public because every text field and decoration (`AppTextField`, `ControllerTextField`, `OtpCodeField`, `FilledTextFieldDecoration`) shares it. `resolve(enabled:, focused:, hasError:)` holds the precedence (disabled > error > focused) and the enum maps itself to `fillColor` / `borderColor` / `labelColor` tokens. A public state enum is acceptable only when 2+ widgets in the package share it and it resolves to theme tokens; otherwise stay private. Inline validation text under a control is the shared `FieldErrorText` (same folder), not a per-field `Text`.
- Current buttons (`AppElevatedButton`, `AppOutlinedButton`, `AppBaseButton`) expose `enabled` / `loading` flags and compute `enabled && !loading` inline — accepted as-is; adopt the enum when a widget gains a third state (pressed, selected, error) or new colors depend on the combination.

## 6. Checklist for a new or changed widget

- [ ] No `Color(0x…)`, `Colors.*`, hand-built `TextStyle`, or `Theme.of` — tokens from `ThemeProvider` only
- [ ] Role tokens used for their role (`accent` for brand text/icons, `errorText`/`successText` on the page, `onStatus` on status fills); no palette `AppColors.*` except `transparent`
- [ ] Flat: no `BoxShadow`/elevation/ripple/tint; bordered `theme.surface` with `theme.border`; radii from `AppRadii`
- [ ] Reuses `AppCard` / `GroupedRowsCard` / `AppListTile` / `StatusPill` instead of a one-off card or tile
- [ ] Lives in the right `widgets/<category>/` folder; not feature-specific; no barrel
- [ ] One public class per file; `///` summary (1–3 lines) on the public class
- [ ] Strings localized or injected; icons via `UiSvgIcons` + `SvgIcon`
- [ ] Interaction state resolved in one place; loading outranks disabled
- [ ] Taps go through `AppTapArea` / `InkWell` / a Material button; icon-only taps carry a localized `semanticLabel`
- [ ] Gallery section added in `lib/example/`
- [ ] Behavior test added in `test/widgets/<category>/`
- [ ] `cd packages/starter_uikit && fvm flutter test`, then `fvm flutter analyze` from the repo root (includes `starter_lints`)
