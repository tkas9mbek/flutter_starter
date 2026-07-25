# Changelog

All notable changes to starter_uikit will be documented in this file.

## [3.1.0] - 2026-07-25

### Added
- Size factory constructors on the button family:
  `AppElevatedButton.big/.medium/.small` and
  `AppOutlinedButton.big/.medium/.small` (theme-aware text styles, fixed
  heights)
- `CustomCircularProgressIndicator.adaptive` — platform-native spinner
  (Cupertino on iOS/macOS, Material elsewhere)
- Icons `eye_open`, `eye_slash`, `inbox_tray`

### Changed
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
