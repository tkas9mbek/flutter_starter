# Starter UIKit

Reusable UI components and theme system for Flutter applications, built on a flat navy design system.

## Features

This package provides:

- **Theme System**: Light/dark `AppTheme` role tokens over the `AppColors` palette, `AppTextStyles`, `AppRadii`, `ThemeProvider` and `themeDataFromTheme`
- **Surfaces**: `AppCard`, `GroupedRowsCard` + `AppListTile`, `StatusPill`
- **Tap targets**: `AppTapArea` — an `InkWell` with button semantics for anything tappable (never a bare `GestureDetector`)
- **Status Widgets**: Loading indicators, empty states, failure widgets, full-screen `AppStatusScreen`, shimmer skeletons
- **App Bars & Navigation**: Title, base and transparent app bars, back button, bottom nav bar
- **Buttons**: Elevated and outlined buttons (`big`/`medium`/`small`) with loading states
- **Form Components**: Text, dropdown, checkbox, radio/checkbox groups, date/time pickers, OTP and country-code fields
- **Dialogs**: Bottom sheets (confirmation, dropdown, date, date range, time)
- **Screen helpers**: Paginated lists, multi-BLoC pull-to-refresh
- **Notifications**: Snackbar notifications (success, error, information)
- **Exception UI Models**: Localized error messages with `ExceptionUiModel` and `ExceptionUiMapper`
- **Example App**: Interactive gallery showcasing all components

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  starter_uikit:
    path: ../packages/starter_uikit
```

## Usage

### Import Strategy

There is no barrel export — every import is file-specific:

```dart
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
```

### Theme Setup

`ThemeProvider` takes an `AppTheme` (defaults to `AppTheme.light()`) and builds the matching `AppTextStyles` itself. Feed Material the same tokens through `toThemeData()` (or `themeDataFromTheme`), so widgets the uikit does not own pick up the flat look too:

```dart
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

final light = AppTheme.light();
final dark = AppTheme.dark();

ThemeProvider(
  theme: isDark ? dark : light,
  child: MaterialApp(
    theme: light.toThemeData(),
    darkTheme: dark.toThemeData(),
    themeMode: themeMode,
    localizationsDelegates: const [
      UikitLocalizer.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: UikitLocalizer.delegate.supportedLocales,
    ...
  ),
)
```

Switching light/dark is the host app's job: rebuild `ThemeProvider` with the other `AppTheme` (the example app does it with a `ThemeCubit`).

Access theme in widgets (inside `build()` only):

```dart
final theme = ThemeProvider.of(context).theme;
final textStyles = ThemeProvider.of(context).textStyles;

Text('Hello', style: textStyles.mediumBody14)
DecoratedBox(
  decoration: BoxDecoration(
    color: theme.surface,
    borderRadius: BorderRadius.circular(AppRadii.md),
    border: Border.all(color: theme.border),
  ),
)
```

### Design Language

The look is flat: no shadows, elevation, ripple or surface tint. `theme.background` is both the scaffold and the app bar; cards, sheets, dialogs and fields are `theme.surface` separated by a 1px `theme.border`. Widgets read only `AppTheme`/`AppTextStyles`/`AppRadii` tokens, never `AppColors` or literals.

| Token group | Use |
|---|---|
| `primary` / `onPrimary` | Filled brand surfaces (buttons, selected checkbox) |
| `accent` | Brand-colored text, icons, outlines and spinners drawn on `background`/`surface` (lighter than `primary` in dark mode) |
| `secondary` / `onSecondary` | Supporting highlights |
| `success`, `error`, `warning`, `info` + `onStatus` | Solid status fills (snackbars, `StatusPill`) |
| `successText`, `errorText` | Status text or icons drawn directly on `background`/`surface` |
| `surface`, `surfaceMuted`, `selectedSurface`, `border`, `borderStrong` | Containers, disabled fills, picked rows, hairlines, control outlines |
| `shimmerBase` / `shimmerHighlight` | Skeleton loaders |
| `textPrimary`, `textSecondary`, `textTertiary`, `textPlaceholder` | Text hierarchy |

`AppRadii` steps: `xs` 4, `sm` 8, `md` 12 (cards, tiles), `control` 14 (buttons, text fields), `lg` 16, `xl` 20 (snackbars, sheet corners), `pill` 100. Rules for adding or changing widgets: [`docs/rules/uikit.md`](../../docs/rules/uikit.md).

### Surfaces

```dart
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/misc/status_pill.dart';

// Bordered flat card; `selected` tints it and outlines it in accent
AppCard(
  padding: const EdgeInsets.all(16),
  onTap: _open,
  child: Text('Card content'),
)

// Settings-style rows separated by thin dividers
GroupedRowsCard(
  children: [
    AppListTile(
      icon: UiSvgIcons.personProfile,
      title: 'Profile',
      subtitle: 'Name and photo',
      onTap: _openProfile,
    ),
    AppListTile(title: 'Version', value: '3.1.0'),
    AppListTile(title: 'Delete account', danger: true, onTap: _delete),
  ],
)

// Status label on a solid fill (label is drawn in `onStatus`)
StatusPill(label: 'Paid', color: theme.success)
```

`AppListTile` shows a chevron when tappable, `loading` swaps it for a spinner and ignores taps. `UiSvgIcons` lives in `package:starter_uikit/resources/resources.dart`.

`AppTapArea` makes any child tappable the accessible way (keyboard focus, button semantics, no splash). Pass `semanticLabel` for an icon with no text, `selected` for a chosen item of a group, and `onTap: null` to disable:

```dart
AppTapArea(
  onTap: _clear,
  semanticLabel: UikitLocalizer.of(context).clearField,
  child: SvgIcon(UiSvgIcons.closeMark, size: 20, color: theme.textTertiary),
)
```

### Status Widgets

```dart
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';
import 'package:starter_uikit/widgets/status/app_status_screen.dart';

// Loading (accent-colored; `.adaptive()` is Cupertino on iOS/macOS)
const CustomCircularProgressIndicator()

// Empty state
EmptyInformationBody(text: 'No data available', onRetry: _retry)

// Failure - Large (for full screens)
FailureWidget.large(
  exception: exception,
  onRetry: _retry,
)

// Failure - Small (for inline errors)
FailureWidget.small(
  exception: exception,
  onRetry: _retry,
)

// Full-screen outcome: bordered icon circle, title/subtitle, actions.
// All copy is injected; the widget never reads a Localizer.
AppStatusScreen(
  icon: SvgIcon(UiSvgIcons.checkMark, size: 56, color: theme.successText),
  title: 'All done',
  subtitle: 'Your changes were saved.',
  primaryButtonLabel: 'Continue',
  onPrimaryPressed: _continue,
  secondaryButtonLabel: 'Back',
  onSecondaryPressed: _back,
)
```

### Buttons

```dart
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';

// Filled button (primary fill); sizes: .big (52), .medium (48), .small (40)
AppElevatedButton.big(
  context: context,
  text: 'Submit',
  onPressed: _handleSubmit,
  loading: isLoading,
  enabled: true,
)

// Outlined button (1px accent outline)
AppOutlinedButton.big(
  context: context,
  text: 'Cancel',
  onPressed: _handleCancel,
)
```

Both use `AppRadii.control` and medium-weight labels; `.big`/`.medium` stretch to full width by default, `.small` hugs its content.

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

// Transparent app bar (fades from the page background; becomes a solid
// TitleAppBar once the scroll offset passes `transparentHeight`)
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
import 'package:starter_uikit/widgets/form/app_form.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';
import 'package:starter_uikit/widgets/form/app_dropdown_field.dart';
import 'package:starter_uikit/widgets/form/app_checkbox_field.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';

// Form: quiet until the first submit, then re-validates fields as the user edits
final formKey = GlobalKey<AppFormState>();
AppForm(key: formKey, child: ...);
if (formKey.currentState!.saveAndValidate()) { final values = formKey.currentState!.value; }

// Text field (must live under an AppForm)
AppTextField(
  name: 'email',
  label: 'Email',
  validators: [FormBuilderValidators.email()],
)

// Dropdown field (opens a DropdownBottomSheet of selectable cards)
AppDropdownField<String>(
  name: 'country',
  label: 'Country',
  options: ['USA', 'Canada', 'UK'],
  optionLabelBuilder: (option) => option,
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

Every field paints one shared `TextFieldVisualState` (`idle`, `focused`, `error`, `disabled`) through its `TextFieldDecoration`; custom decorations implement `buildWithState`. Inline validation text is `FieldErrorText`. Other form widgets: `AppCheckboxGroup`, `AppRadioGroup`, `AppTimePickerField`, `ControllerTextField`, `OtpCodeField`, `CountryCodeField`.

### Notifications

```dart
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

// Success notification
NotificationSnackBar.show(
  context,
  NotificationSnackBar.success(text: 'Operation completed'),
)

// Error notification
NotificationSnackBar.show(
  context,
  NotificationSnackBar.error(text: 'Operation failed'),
)

// Neutral/informational
NotificationSnackBar.show(
  context,
  NotificationSnackBar.information(text: 'Heads up'),
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

// In UI - FailureWidget maps to a localized model internally
if (state case FailureState(:final exception))
  FailureWidget.large(exception: exception, onRetry: _retry),

// Snackbar for a transient error
NotificationSnackBar.showExceptionMessage(context, exception: exception);
```

### Dialogs

```dart
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/date_range_picker_bottom_sheet.dart';

// Date picker
final selectedDate = await BottomSheetScreen.show<DateTime>(
  context: context,
  builder: (context) => DateTimePickerBottomSheet(
    title: 'Select Date',
    backText: 'Cancel',
    confirmText: 'Confirm',
    initialDate: DateTime.now(),
  ),
);

// Date range picker: start date first, then end date
final range = await BottomSheetScreen.show<(DateTime, DateTime)>(
  context: context,
  builder: (context) => DateRangePickerBottomSheet(
    title: 'Select Date Range',
    backText: 'Cancel',
    confirmText: 'Confirm',
    minDate: DateTime(2020),
    maxDate: DateTime.now(),
  ),
);
```

`BottomSheetScreen` is the bordered, rounded-top sheet scaffold (default padding `16/16/16/24`); the other sheets (`ConfirmationBottomSheet`, `DropdownBottomSheet`, `TimePickerBottomSheet`) are presented the same way.

## Examples

Run the example app to see all components in action:

```bash
cd packages/starter_uikit
fvm flutter run
```

The menu is a `GroupedRowsCard` of `AppListTile`s (light/dark toggle in the app bar); each screen is built from `ExampleSection`s. Example screens in `lib/example/screens/`:
- **Buttons** - Elevated, outlined, disabled, loading, destructive states
- **Form Fields** - Text fields, dropdowns, checkboxes, radio/checkbox groups, date pickers
- **Status Widgets** - Loading, empty, failure states, snackbars, `AppStatusScreen`
- **App Bars** - Title, base, and transparent app bars
- **Dialogs** - Date, date range and time pickers, confirmation and dropdown sheets
- **Text Widgets** - Title/subtitle, auto-formatted text, bulleted lists
- **Misc Widgets** - `AppCard`, `AppTapArea`, `GroupedRowsCard`/`AppListTile`, `StatusPill`, avatars, dividers, progress indicators
- **Pagination** - Paginated list with pull-to-refresh

Widget behavior tests live in `test/widgets/` (shared `test/support/pump_app.dart`):

```bash
cd packages/starter_uikit
fvm flutter test
```

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
- Theme-aware components using `ThemeProvider` (tokens only, flat design)
- Localized error messages via `ExceptionUiMapper`
- Composable and reusable components
- No direct dependencies on data layer

## Dependencies

**Core:**
- `flutter` - Flutter SDK
- `cached_network_image` - Network image caching
- `flutter_svg` - SVG rendering
- `modal_bottom_sheet` - Bottom sheet dialogs
- `shimmer` - Skeleton loaders
- `image` / `image_picker` - Image picking helper

**Forms:**
- `flutter_form_builder` - Form widgets
- `form_builder_validators` - Field validation

**Screens & example app:**
- `flutter_bloc` - `MultiBlocRefreshIndicator`, example theme cubit
- `auto_route` - Example app routing

**Localization:**
- `intl` - Internationalization

**Internal:**
- `starter_toolkit` - Shared utilities and `AppException` hierarchy

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

- **starter_toolkit**: Pure Dart utilities and `AppException` hierarchy (required dependency)
- **request_logger**: In-app HTTP request logger, styled with this package's widgets
- **starter_lints**: Custom lint rules (`theme_in_build_only`, `no_hardcoded_colors`, ...)

## License

Private package for internal use.
