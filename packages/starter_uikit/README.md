# Starter UIKit

Reusable UI components and theme system for Flutter applications.

## Features

This package provides:

- **Status Widgets**: Loading indicators, empty states, failure widgets
- **App Bars**: Title app bar, base app bar, transparent app bar
- **Buttons**: Elevated buttons, outlined buttons with loading states
- **Form Components**: Text fields, dropdown fields, checkbox, date picker fields
- **Notifications**: Snackbar notifications (success, error, info, warning)
- **Theme System**: Light/dark theme support with `ThemeProvider` and `AppTextStyles`
- **Exception UI Models**: Localized error messages with `ExceptionUiModel` and `ExceptionUiMapper`
- **Example App**: Interactive demo showcasing all components

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  starter_uikit:
    path: ../packages/starter_uikit
```

## Usage

### Import Strategy

**Recommended**: Import specific files for better compilation performance:

```dart
// Specific imports
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
```

**Barrel export** (for status widgets used together):

```dart
// Status widgets only
import 'package:starter_uikit/starter_uikit.dart';
// Provides: CustomCircularProgressIndicator, EmptyInformationBody,
//           FailureWidgetLarge, FailureWidgetSmall
```

### Theme Setup

Wrap your app with `ThemeProvider`:

```dart
ThemeProvider(
  theme: AppTheme.light(),
  textStyles: AppTextStyles(AppTheme.light()),
  onThemeToggle: _toggleTheme,
  child: MaterialApp(...),
)
```

Access theme in widgets:

```dart
final theme = ThemeProvider.of(context).theme;
final textStyles = ThemeProvider.of(context).textStyles;

Text('Hello', style: textStyles.mediumBody14)
Container(color: theme.primary)
```

### Status Widgets

```dart
import 'package:starter_uikit/starter_uikit.dart';

// Loading
const CustomCircularProgressIndicator()

// Empty state
EmptyInformationBody(text: 'No data available')

// Failure - Large (for full screens)
FailureWidgetLarge(
  uiModel: exceptionUiModel,
  onRetry: _retry,
)

// Failure - Small (for inline errors)
FailureWidgetSmall(
  uiModel: exceptionUiModel,
  onRetry: _retry,
)
```

### Buttons

```dart
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';

// Elevated button
AppElevatedButton.big(
  context: context,
  text: 'Submit',
  onPressed: _handleSubmit,
  loading: isLoading,
  enabled: true,
)

// Outlined button
AppOutlinedButton.big(
  context: context,
  text: 'Cancel',
  onPressed: _handleCancel,
)
```

### App Bars

```dart
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/app_bar/base_app_bar.dart';
import 'package:starter_uikit/widgets/app_bar/transparent_app_bar.dart';

// Title app bar
Scaffold(
  appBar: TitleAppBar(title: 'Screen Title'),
  body: ...,
)

// Base app bar with custom content
Scaffold(
  appBar: BaseAppBar(
    height: 56,
    child: Row(children: [...]),
  ),
  body: ...,
)

// Transparent app bar (for scrollable content)
Scaffold(
  appBar: TransparentAppBar(
    title: 'Title',
    scrollController: _scrollController,
  ),
  body: SingleChildScrollView(
    controller: _scrollController,
    child: ...,
  ),
)
```

### Forms

```dart
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/app_dropdown_field.dart';
import 'package:starter_uikit/widgets/form/app_checkbox_field.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';

// Text field
AppTextField(
  name: 'email',
  label: 'Email',
  validator: FormBuilderValidators.email(),
)

// Dropdown field
AppDropdownField<String>(
  name: 'country',
  label: 'Country',
  items: ['USA', 'Canada', 'UK'],
  itemBuilder: (item) => Text(item),
)

// Checkbox
AppCheckboxField(
  name: 'agree',
  label: 'I agree to terms',
)

// Date picker
AppDatePickerField(
  name: 'birthday',
  label: 'Birthday',
  minDate: DateTime(1900),
  maxDate: DateTime.now(),
)
```

### Notifications

```dart
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

// Success notification
NotificationSnackBar.showMessage(
  context,
  isSuccess: true,
  message: 'Operation completed',
)

// Error notification
NotificationSnackBar.showMessage(
  context,
  isSuccess: false,
  message: 'Operation failed',
)
```

### Exception Handling

```dart
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

// In BLoC - store domain exception
try {
  final data = await _repository.getData();
  return emit(State.success(data));
} on AppException catch (e) {
  return emit(State.failure(e));
}

// In UI - map to localized model
failure: (failureState) {
  final uiModel = ExceptionUiMapper(context).map(failureState.exception);
  return FailureWidgetLarge(
    uiModel: uiModel,
    onRetry: _retry,
  );
}
```

### Dialogs

```dart
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/date_range_picker_bottom_sheet.dart';

// Date picker
final selectedDate = await showModalBottomSheet<DateTime>(
  context: context,
  isScrollControlled: true,
  builder: (context) => DateTimePickerBottomSheet(
    title: 'Select Date',
    initialDate: DateTime.now(),
  ),
);

// Date range picker
final dateRange = await showModalBottomSheet<DateTimeRange>(
  context: context,
  isScrollControlled: true,
  builder: (context) => DateRangePickerBottomSheet(
    title: 'Select Date Range',
    minDate: DateTime(2020),
    maxDate: DateTime.now(),
  ),
);
```

## Examples

Run the example app to see all components in action:

```bash
cd packages/starter_uikit
fvm flutter run
```

Example screens available in `lib/example/`:
- **Buttons** - Elevated, outlined, disabled, loading states
- **Form Fields** - Text fields, dropdowns, checkboxes, date pickers
- **Status Widgets** - Loading, empty, and failure states
- **App Bars** - Title, base, and transparent app bars
- **Dialogs** - Date pickers, date range pickers, bottom sheets
- **Text Widgets** - Auto-formatted text, bulleted lists
- **Misc Widgets** - Avatars, dividers, progress indicators

## Localization

The UIKit includes its own localization:

```dart
import 'package:starter_uikit/l10n/generated/l10n.dart';

// Access localized strings
final retry = UikitLocalizer.of(context).retry;
final cancel = UikitLocalizer.of(context).cancel;
```

**Supported locales:**
- English (`en`) - Main locale
- Russian (`ru`)

## Architecture

This package follows the project's architecture guidelines:
- Pure Flutter widgets (no business logic)
- Theme-aware components using `ThemeProvider`
- Localized error messages via `ExceptionUiMapper`
- Composable and reusable components
- No direct dependencies on data layer

## Dependencies

**Core:**
- `flutter` - Flutter SDK
- `cached_network_image` - Network image caching
- `flutter_svg` - SVG rendering
- `modal_bottom_sheet` - Bottom sheet dialogs

**Forms:**
- `flutter_form_builder` - Form widgets (inherited from toolkit)

**Localization:**
- `intl` - Internationalization

**Internal:**
- `starter_toolkit` - Shared utilities and data layer

## Development

### Generate Localization

```bash
fvm flutter --no-color pub global run intl_utils:generate
```

### Generate Routes (Example App)

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### Run Example App

```bash
fvm flutter run
```

## Related Packages

- **starter_toolkit**: Pure Dart utilities and data layer (required dependency)

## License

Private package for internal use.
