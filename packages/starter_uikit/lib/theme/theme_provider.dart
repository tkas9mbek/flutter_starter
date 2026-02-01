import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';

/// Provides theme and text styles to the widget tree via InheritedWidget.
class ThemeProvider extends InheritedWidget {
  ThemeProvider({required super.child, AppTheme? theme, super.key})
    : theme = theme ?? AppTheme.light(),
      textStyles = AppTextStyles(theme ?? AppTheme.light());

  final AppTheme theme;
  final AppTextStyles textStyles;

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) => theme != oldWidget.theme;

  static ThemeProvider of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>();

    return provider!;
  }
}
