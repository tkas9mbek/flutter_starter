import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';

ThemeData themeDataFromTheme({
  required AppTheme theme,
  required AppTextStyles textStyles,
}) {
  const border = InputBorder.none;

  final brightness = theme.themeMode == ThemeMode.dark
      ? Brightness.dark
      : Brightness.light;

  return ThemeData(
    fontFamily: textStyles.fontFamily,
    scaffoldBackgroundColor: theme.background,
    useMaterial3: false,
    colorScheme: ColorScheme(
      primary: theme.primary,
      secondary: theme.secondary,
      surface: theme.surface,
      error: theme.error,
      onPrimary: theme.onPrimary,
      onSecondary: theme.onPrimary,
      onSurface: theme.textPrimary,
      onError: theme.onStatus,
      brightness: brightness,
    ),
    textTheme: TextTheme(
      titleLarge: textStyles.boldTitle20,
      titleMedium: textStyles.regularTitle20,
      titleSmall: textStyles.regularTitle18,
      bodyLarge: textStyles.regularBody16,
      bodyMedium: textStyles.regularBody14,
      bodySmall: textStyles.regularBody13,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
      contentPadding: EdgeInsets.zero,
    ),
  );
}
