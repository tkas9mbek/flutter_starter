import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';

/// Application theme configuration with light and dark mode support.
class AppTheme {
  final ThemeMode themeMode;

  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color border;
  final Color error;
  final Color success;
  final Color onPrimary;
  final Color onStatus;
  final Color textPrimary;
  final Color textSecondary;

  AppTheme._({
    required this.themeMode,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.border,
    required this.error,
    required this.onPrimary,
    required this.onStatus,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
  });

  factory AppTheme.light() => AppTheme._(
        themeMode: ThemeMode.light,
        primary: AppColors.vividPurple,
        secondary: AppColors.brightAmber,
        surface: AppColors.pureWhite,
        background: AppColors.lightGrey,
        border: AppColors.lightBorder,
        error: AppColors.deepRed,
        success: AppColors.vibrantGreen,
        onPrimary: AppColors.whiteText,
        onStatus: AppColors.statusText,
        textPrimary: AppColors.blackText,
        textSecondary: AppColors.greyText,
      );

  factory AppTheme.dark() => AppTheme._(
        themeMode: ThemeMode.dark,
        primary: AppColors.lightPurple,
        secondary: AppColors.brightAmber,
        surface: AppColors.darkSurface,
        background: AppColors.darkGrey,
        border: AppColors.darkBorder,
        error: AppColors.lightRed,
        success: AppColors.vibrantGreen,
        onPrimary: AppColors.blackText,
        onStatus: AppColors.statusText,
        textPrimary: AppColors.whiteText,
        textSecondary: AppColors.lightGreyText,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode;

  @override
  int get hashCode => themeMode.hashCode;
}
