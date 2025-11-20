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

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  starter_uikit:
    path: ../packages/starter_uikit
```

## Usage

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

// Failure
FailureWidgetLarge(
  uiModel: exceptionUiModel,
  onRetry: _retry,
)
```

### Buttons

```dart
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';

AppElevatedButton(
  text: 'Submit',
  onPressed: _handleSubmit,
  isLoading: isLoading,
)
```

### Forms

```dart
import 'package:starter_uikit/widgets/form/app_text_field.dart';

AppTextField(
  name: 'email',
  label: 'Email',
  validator: FormBuilderValidators.email(),
)
```

### Notifications

```dart
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

NotificationSnackBar.show(
  context,
  message: 'Operation completed',
  type: NotificationSnackBarType.success,
)
```

### Exception Handling

```dart
import 'package:starter_uikit/mappers/exception_ui_mapper.dart';

// Map domain exception to UI model
final uiModel = ExceptionUiMapper(context).map(exception);

// Display in widget
FailureWidgetLarge(
  uiModel: uiModel,
  onRetry: () => _retry(),
)
```

## Examples

Example screens are available in `lib/example/`:
- `application.dart` - Main app with theme toggle
- `screens/` - Demo screens for each component category
- `widgets/` - Reusable example widgets

## Architecture

This package follows the project's architecture guidelines:
- Pure Flutter widgets (no business logic)
- Theme-aware components using `ThemeProvider`
- Localized error messages via `ExceptionUiMapper`
- Composable and reusable components
