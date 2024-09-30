import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/app_text_styles.dart';
import 'package:flutter_starter/theme/app_theme.dart';

ThemeData themeDataFromTheme({
  required AppTheme theme,
  required AppTextStyles textStyles,
}) {
  const border = InputBorder.none;

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
      onSecondary: theme.onSecondary,
      onSurface: theme.onSurface,
      onError: theme.onStatus,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      titleLarge: textStyles.titleLarge,
      titleMedium: textStyles.titleMedium,
      titleSmall: textStyles.titleSmall,
      labelLarge: textStyles.labelLarge,
      labelMedium: textStyles.labelMedium,
      labelSmall: textStyles.labelSmall,
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
