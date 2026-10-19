import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/theme_data_from_theme.dart';

/// Semantic color tokens for one brightness, read through `ThemeProvider`.
///
/// Widgets use these names, never [AppColors] directly, so light/dark stays a
/// single swap here. The design is flat: `background` is shared by the
/// scaffold and the app bar, and `surface` areas are separated by `border`,
/// never by shadow.
class AppTheme {
  AppTheme._({
    required this.themeMode,
    required this.primary,
    required this.onPrimary,
    required this.accent,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.selectedSurface,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.border,
    required this.borderStrong,
    required this.success,
    required this.successText,
    required this.warning,
    required this.info,
    required this.error,
    required this.errorText,
    required this.onStatus,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textPlaceholder,
  });

  factory AppTheme.light() => AppTheme._(
    themeMode: ThemeMode.light,
    primary: AppColors.navy700,
    onPrimary: AppColors.white,
    accent: AppColors.navy700,
    secondary: AppColors.cyan700,
    onSecondary: AppColors.white,
    background: AppColors.slate50,
    surface: AppColors.white,
    surfaceMuted: AppColors.slate100,
    selectedSurface: AppColors.navy50,
    shimmerBase: AppColors.slate100,
    shimmerHighlight: AppColors.white,
    border: AppColors.slate200,
    borderStrong: AppColors.slate300,
    success: AppColors.greenDark,
    successText: AppColors.greenDark,
    warning: AppColors.orangeDark,
    info: AppColors.blueDark,
    error: AppColors.redDark,
    errorText: AppColors.redDark,
    onStatus: AppColors.white,
    textPrimary: AppColors.navy900,
    textSecondary: AppColors.slate700,
    textTertiary: AppColors.slate500,
    textPlaceholder: AppColors.slate400,
  );

  factory AppTheme.dark() => AppTheme._(
    themeMode: ThemeMode.dark,
    // Same navy hue as light, one step lighter so a filled button still
    // separates from the ink background.
    primary: AppColors.navy500,
    onPrimary: AppColors.white,
    accent: AppColors.navy300,
    secondary: AppColors.cyan400,
    onSecondary: AppColors.navy900,
    background: AppColors.ink900,
    surface: AppColors.ink800,
    surfaceMuted: AppColors.ink700,
    selectedSurface: AppColors.navyFaint,
    shimmerBase: AppColors.ink700,
    shimmerHighlight: AppColors.ink600,
    border: AppColors.ink500,
    borderStrong: AppColors.ink400,
    // Status fills stay dark green / dark red in both brightnesses with white
    // on top; the *Text twins are the lighter shades for text on the background.
    success: AppColors.greenDark,
    successText: AppColors.greenLight,
    warning: AppColors.orangeDark,
    info: AppColors.blueDark,
    error: AppColors.redDark,
    errorText: AppColors.redLight,
    onStatus: AppColors.white,
    textPrimary: AppColors.ink50,
    textSecondary: AppColors.ink100,
    textTertiary: AppColors.ink200,
    textPlaceholder: AppColors.ink300,
  );

  final ThemeMode themeMode;

  /// Filled brand color (buttons, selected checkbox); [onPrimary] sits on it.
  final Color primary;
  final Color onPrimary;

  /// Brand color for text, icons and outlines drawn straight on [background]
  /// or [surface], where [primary] itself may be too dark in dark mode.
  final Color accent;

  /// Supporting color for non-primary highlights; [onSecondary] sits on it.
  final Color secondary;
  final Color onSecondary;

  /// Scaffold and app bar color.
  final Color background;

  /// Cards, sheets, dialogs, fields — always drawn with a [border].
  final Color surface;
  final Color surfaceMuted;
  final Color selectedSurface;
  final Color shimmerBase;
  final Color shimmerHighlight;

  /// Hairline separating surfaces; [borderStrong] for control outlines.
  final Color border;
  final Color borderStrong;

  /// Status fills carrying [onStatus]; the *Text twins are for text and icons
  /// drawn directly on [background].
  final Color success;
  final Color successText;
  final Color warning;
  final Color info;
  final Color error;
  final Color errorText;
  final Color onStatus;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textPlaceholder;

  /// Converts this AppTheme to Flutter's ThemeData.
  ThemeData toThemeData() {
    return themeDataFromTheme(theme: this, textStyles: AppTextStyles(this));
  }
}
