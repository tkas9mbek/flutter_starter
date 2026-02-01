# Changelog

All notable changes to starter_uikit will be documented in this file.

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
