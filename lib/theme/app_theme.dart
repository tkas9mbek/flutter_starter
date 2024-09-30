import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/app_colors.dart';

class AppTheme {
  final ThemeMode themeMode;

  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color error;
  final Color onPrimary;
  final Color onSecondary;
  final Color onSurface;
  final Color onBackground;
  final Color onStatus;
  final Color shadow;
  final Color border;
  final Color link;
  final Color success;

  AppTheme._({
    required this.themeMode,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onSurface,
    required this.onBackground,
    required this.onStatus,
    required this.shadow,
    required this.border,
    required this.link,
    required this.success,
  });

  factory AppTheme.light() => AppTheme._(
        themeMode: ThemeMode.light,
        primary: AppColors.goldenParchment,
        secondary: AppColors.vividYellow,
        surface: AppColors.deepParchment,
        background: AppColors.lightParchment,
        error: AppColors.redError,
        onPrimary: AppColors.white,
        onSecondary: AppColors.darkBrown,
        onSurface: AppColors.darkBrown,
        onBackground: AppColors.darkBrown,
        onStatus: AppColors.white,
        shadow: AppColors.warmBrownShadow,
        border: AppColors.fadedBeigeBorder,
        link: AppColors.blueInfo,
        success: AppColors.greenSuccess,
      );
}
