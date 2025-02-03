import 'package:flutter/material.dart';
import 'package:uikit/theme/app_text_styles.dart';
import 'package:uikit/theme/app_theme.dart';

class ThemeProvider extends InheritedWidget {
  final AppTheme theme;
  final AppTextStyles textStyles;

  ThemeProvider({
    required super.child,
    super.key,
  })  : textStyles = AppTextStyles(),
        theme = AppTheme.light();

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) =>
      theme != oldWidget.theme || textStyles != oldWidget.textStyles;

  static ThemeProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ThemeProvider>();

    return provider!;
  }
}
