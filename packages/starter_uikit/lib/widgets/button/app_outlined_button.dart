import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_base_button.dart';

/// Customizable outlined button with loading and icon support.
class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    required this.text,
    required this.textStyle,
    this.enabled = true,
    this.loading = false,
    this.iconDirection = TextDirection.ltr,
    this.onPressed,
    this.width,
    this.icon,
    this.height,
    this.borderColor,
    this.textColor,
    this.borderRadius = 12,
    this.padding,
    super.key,
  });

  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final String text;
  final Widget? icon;
  final TextDirection iconDirection;
  final TextStyle textStyle;
  final Color? borderColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets? padding;

  factory AppOutlinedButton.big({
    required BuildContext context,
    required String text,
    VoidCallback? onPressed,
    Widget? icon,
    TextDirection iconDirection = TextDirection.ltr,
    bool loading = false,
    bool enabled = true,
    double? width = double.infinity,
  }) {
    return AppOutlinedButton(
      height: 52,
      textStyle: ThemeProvider.of(context).textStyles.regularBody16,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
      borderRadius: 12,
    );
  }

  factory AppOutlinedButton.medium({
    required BuildContext context,
    required String text,
    VoidCallback? onPressed,
    Widget? icon,
    TextDirection iconDirection = TextDirection.ltr,
    bool loading = false,
    bool enabled = true,
    double? width = double.infinity,
  }) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppOutlinedButton(
      height: 48,
      textStyle: textStyles.regularBody16,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
      borderRadius: 12,
    );
  }

  factory AppOutlinedButton.small({
    required BuildContext context,
    required String text,
    VoidCallback? onPressed,
    Widget? icon,
    TextDirection iconDirection = TextDirection.ltr,
    bool loading = false,
    bool enabled = true,
    double? width,
  }) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppOutlinedButton(
      height: 48,
      textStyle: textStyles.regularBody16,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
      borderRadius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AppBaseButton(
      disabledBackgroundColor: Colors.transparent,
      disabledTextColor: theme.textSecondary,
      borderRadius: borderRadius,
      backgroundColor: Colors.transparent,
      height: height,
      textStyle: textStyle,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      iconDirection: iconDirection,
      loading: loading,
      enabled: enabled,
      borderColor: borderColor ?? theme.primary,
      textColor: textColor ?? theme.primary,
      padding: padding,
    );
  }
}
