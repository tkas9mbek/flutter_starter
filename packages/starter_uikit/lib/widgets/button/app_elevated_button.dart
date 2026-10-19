import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_base_button.dart';

/// Flat filled button (`primary` fill, `onPrimary` label) with loading and icon
/// support; disabled it turns `surfaceMuted` with a `textTertiary` label.
class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.text,
    required this.textStyle,
    this.enabled = true,
    this.loading = false,
    this.iconDirection = TextDirection.ltr,
    this.borderRadius = AppRadii.control,
    this.onPressed,
    this.width,
    this.icon,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.padding,
    super.key,
  });

  factory AppElevatedButton.big({
    required BuildContext context,
    required String text,
    TextDirection iconDirection = TextDirection.ltr,
    bool loading = false,
    bool enabled = true,
    double? width = double.infinity,
    VoidCallback? onPressed,
    Widget? icon,
  }) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppElevatedButton(
      height: 52,
      textStyle: textStyles.mediumBody16,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
    );
  }

  factory AppElevatedButton.medium({
    required BuildContext context,
    required String text,
    TextDirection iconDirection = TextDirection.ltr,
    bool loading = false,
    bool enabled = true,
    double? width = double.infinity,
    VoidCallback? onPressed,
    Widget? icon,
  }) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppElevatedButton(
      height: 48,
      textStyle: textStyles.mediumBody16,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
    );
  }

  factory AppElevatedButton.small({
    required BuildContext context,
    required String text,
    TextDirection iconDirection = TextDirection.ltr,
    bool loading = false,
    bool enabled = true,
    double? width,
    VoidCallback? onPressed,
    Widget? icon,
  }) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppElevatedButton(
      height: 40,
      textStyle: textStyles.mediumBody14,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
    );
  }

  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final String text;
  final Widget? icon;
  final TextDirection iconDirection;
  final TextStyle textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AppBaseButton(
      disabledBackgroundColor: theme.surfaceMuted,
      disabledTextColor: theme.textTertiary,
      borderRadius: borderRadius,
      borderColor: AppColors.transparent,
      height: height,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
      backgroundColor: backgroundColor ?? theme.primary,
      textColor: textColor ?? theme.onPrimary,
      padding: padding,
      textStyle: textStyle,
    );
  }
}
