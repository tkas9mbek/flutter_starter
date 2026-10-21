# Changelog

All notable changes to starter_uikit will be documented in this file.

## [Unreleased]

### Added
- `AppForm` — a `FormBuilder` that stays quiet until the first submit, then re-validates fields as the user edits them (`saveAndValidate()`, `validateField(name)`), with a gallery entry and behavior tests
- `TextScaleContext.hasLargeText`; `AppForm.maybeOf` and `AppFormState.fieldValue` let a field depend on another field
- Date, time and dropdown fields show the shared required-field message

### Changed
- `AppBaseButton.height` is a minimum height; `AppListTile` stacks its value and trailing widget under the title at large text sizes; `BottomNavItem` keeps its label on one line

### Fixed
- `AppTextField` no longer calls `setState` from its validator while the field builds, so it works with `AutovalidateMode.onUserInteraction`

## [3.1.0] - 2026-10-19

Version aligned with the app (`3.1.0`); this replaces the package-local 3.1.0 of 2026-07-25 (folded in below) and the draft 4.0.0 numbering. Flat navy redesign: every widget now paints from semantic theme tokens with 1px borders instead of shadows, so apps that referenced the old palette or relied on the old look must migrate.

### Added
- `AppRadii` shared corner-radius steps (`xs` 4, `sm` 8, `md` 12, `control` 14, `lg` 16, `xl` 20, `pill`)
- `AppTheme` role tokens: `accent`, `onSecondary`, `selectedSurface`, `shimmerBase`, `shimmerHighlight`, `borderStrong`, `successText`, `errorText`, `warning`, `info`
- `AppTextStyles` `regularTitle28` / `mediumTitle28` / `boldTitle28`
- Surfaces: `AppCard` (optional `selected` and `onTap`), `GroupedRowsCard`, `AppListTile` (icon, subtitle, value, `danger`, `loading`; replaces the tile removed in 3.0.0), `StatusPill`
- `AppStatusScreen` — full-screen success/error outcome with injected copy and primary/secondary actions
- Form decoration: public `TextFieldVisualState` enum (`idle`, `focused`, `error`, `disabled`), `FieldErrorText`, and `TextFieldDecoration.buildWithState` (default delegates to `build`)
- Behavior tests per widget under `test/widgets/` with a shared `test/support/pump_app.dart`
- Example gallery: `ExampleSection`, surface demos (`AppCard`, `GroupedRowsCard`/`AppListTile`, `StatusPill`) and an `AppStatusScreen` demo
- `AppTapArea` (`widgets/misc/`) — `InkWell` plus button semantics, no splash; gallery section and behavior test
- `clearField` / `togglePasswordVisibility` localized screen-reader labels

### Changed
- **Breaking**: `AppColors` is a new palette named by hue and shade (`navy50`–`navy900`, `slate*`, `ink*`, `cyan*`, status fills `greenDark`/`redDark`/`orangeDark`/`blueDark`, `greenLight`/`redLight`); the old purple/amber/grey names (`vividPurple`, `lightPurple`, `brightAmber`, `lightGrey`, `pureWhite`, `darkGrey`, `darkSurface`, `deepRed`, `lightRed`, `vibrantGreen`, `blackText`, `greyText`, `whiteText`, `lightGreyText`, `statusText`, `lightBorder`, `darkBorder`) are gone. `AppTheme.primary`/`secondary`/`background`/`surface`/text values change accordingly
- **Breaking**: `AppTheme` now has `accent` (brand color for text, icons, outlines and spinners drawn on the page); widgets that tinted such elements with `primary` use `accent`
- **Breaking**: `themeDataFromTheme` is fully flat — no elevation, shadow, ripple or surface tint; every outline is a 1px border; input borders stay stripped (fields draw their own container)
- **Breaking**: app bars use `theme.background` (same as the scaffold); `BottomSheetScreen` is a bordered `surface` panel with `AppRadii.xl` top corners and default padding `16/16/16/24`; `AppBottomNavBar` gets a top hairline and `BottomNavItem` tints with `accent` / `textTertiary`
- **Breaking**: buttons use `AppRadii.control` (default `borderRadius` 14) and medium-weight labels; the outlined button draws in `accent`, disabled `border`/`textTertiary`
- **Breaking**: `FilledTextFieldDecoration` is always bordered and follows `TextFieldVisualState` (focus outlines in `accent`, errors in `errorText`); `hasBorder` is deprecated and ignored
- `CustomCircularProgressIndicator` defaults to `accent`
- `DropdownBottomSheet` options are selectable cards with the current one highlighted; `AppRadioGroup` / `AppCheckboxGroup` rows are bordered `AppCard`s
- `NotificationSnackBar` is flat: solid `success`/`error` fills with `onStatus` content, and a bordered surface for `information`
- Shimmer skeletons use `shimmerBase` / `shimmerHighlight`; `TransparentAppBar` follows the theme brightness for the status bar
- Chevron and search icons redrawn as stroked glyphs
- Example gallery restyled: menu is a `GroupedRowsCard`, screens are built from `ExampleSection`
- `AppCard`, `AppListTile`, `AppCheckboxField` and the `AppTextField` / `ControllerTextField` clear and show-password icons use `AppTapArea` instead of a bare `GestureDetector`
- `ExceptionUiMapper` maps `UnknownException` with `canRetry: false`

### Removed
- **Breaking**: example `ExampleTile` (replaced by `ExampleSection`)
- `TapActivator` — moved into the app (`DevModeActivator` is its only user); copy it if your app needs a hidden multi-tap trigger

### Carried over from the earlier package-local 3.1.0 (2026-07-25, shipped with app 3.0.0)
#### Added
- Size factory constructors on the button family:
  `AppElevatedButton.big/.medium/.small` and
  `AppOutlinedButton.big/.medium/.small` (theme-aware text styles, fixed
  heights)
- `CustomCircularProgressIndicator.adaptive` — platform-native spinner
  (Cupertino on iOS/macOS, Material elsewhere)
- Icons `eye_open`, `eye_slash`, `inbox_tray`

#### Changed
- `EmptyInformationBody`'s fallback icon and the text-field obscure toggles
  now use `SvgIcon` instead of Material `Icons`, closing the package's own
  Material-icon ban (`svg_icon.dart`)
- Expanded doc comments across widget APIs; assorted bug fixes from the
  uikit audit

## [3.0.0] - 2026-07-08

### Added
- Screen widgets: `PaginatedListView`/`SliverPaginatedListView`, `MultiBlocRefreshIndicator`, `FillRemainingScrollView`, `StackAnimatedSwitcher`
- Form widgets: `ControllerTextField`, `OtpCodeField`, `CountryCodeField`, `AppTimePickerField`; `TimePickerBottomSheet` dialog
- `AppShimmer` skeleton set + `TilesShimmer`, `AnimatedExpand` (animated field errors), `UnfocusArea`, `SvgIcon`, `TitleSubtitle`, `AppBarBackButton`
- Pagination example screen in the example app

### Changed
- **Breaking**: barrel `starter_uikit.dart` removed — import specific files
- **Breaking**: folders restructured — `icon/` → `media/` (+`NetworkImageAvatar`), `dev_tools/` merged into `misc/`, new `size/` for `SafeVerticalBox`/`FillRemainingScrollView`
- **Breaking**: app bars are flat (no rounded corners, elevation, or shadow)
- `FilledTextFieldDecoration` fills with `theme.surface` and is the single decoration; field labels bold 14pt; errors animate in/out
- `NotificationSnackBar` rewritten without `top_snackbar_flutter`; shimmer skeletons draw in `theme.surface`
- SDK `^3.12.0`; auto_route 11, get_it 9

### Removed
- **Breaking**: `AppListTile`, `LabeledField`, `CustomFormBuilderField`, `EmptyListText`, outlined/bordered/rounded text field decorations

## [2.1.0] - 2026-05-14

### Changed
- Updated package version to align with the main app `2.1.0` release
- Kept the shared status, theme, and form widget APIs stable while the template release hardened surrounding app flows
- Continued to use the shared exception-to-UI mapping flow for settings and failure states

## [2.0.0] - 2025-02-01

### Changed
- Updated to match main app version 2.0.0
- Improved code formatting and style consistency

### Maintained
- **Status Widgets**
  - `EmptyInformationBody` - Empty state display
  - `FailureWidgetLarge` / `FailureWidgetSmall` - Error displays with retry
  - `CustomCircularProgressIndicator` - Loading indicator
- **Theme System**
  - `AppTheme` - Light and dark theme definitions
  - `AppTextStyles` - Typography system
  - `ThemeProvider` - Theme access via InheritedWidget
- **Form Widgets**
  - `AppTextField` - Text input with validation
  - `AppDropdownField` - Dropdown selection
  - `AppCheckbox` / `AppCheckboxGroup` - Checkbox controls
  - `AppDatePickerField` - Date selection
  - `AppRadioGroup` - Radio button selection
- **Buttons**
  - `AppElevatedButton` - Primary action button
  - `AppOutlinedButton` - Secondary action button
- **App Bars**
  - `TitleAppBar` - Standard app bar with title
  - `BaseAppBar` - Customizable base app bar
  - `TransparentAppBar` - Overlay-style app bar
- **Notifications**
  - `NotificationSnackBar` - Success/error messages
- **Exception Mapping**
  - `ExceptionUiMapper` - Maps domain exceptions to UI models
  - `ExceptionUiMapperDecorator` - Extensible mapping pattern

## [1.0.0] - 2025-01-24

### Added
- Initial release with UI components
- Theme system (light/dark)
- Form widgets with validation
- Status widgets (loading, empty, error)
- Notification system
- Exception UI mapping
