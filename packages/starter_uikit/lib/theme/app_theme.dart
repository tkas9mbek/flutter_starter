import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';

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
        border: AppColors.blackText.withValues(alpha: 0.1),
        error: AppColors.deepRed,
        success: AppColors.vibrantGreen,
        onPrimary: AppColors.whiteText,
        onStatus: AppColors.statusText,
        textPrimary: AppColors.blackText,
        textSecondary: AppColors.greyText,
      );
}
