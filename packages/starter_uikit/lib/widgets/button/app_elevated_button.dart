import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_base_button.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.text,
    required this.textStyle,
    this.enabled = true,
    this.loading = false,
    this.iconDirection = TextDirection.ltr,
    this.onPressed,
    this.width,
    this.icon,
    this.height,
    this.backgroundColor,
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
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets? padding;

  factory AppElevatedButton.big({
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

    return AppElevatedButton(
      height: 52,
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

  factory AppElevatedButton.medium({
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

    return AppElevatedButton(
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

  factory AppElevatedButton.small({
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

    return AppElevatedButton(
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
      disabledBackgroundColor: theme.surface,
      disabledTextColor: theme.textSecondary,
      borderRadius: borderRadius,
      borderColor: Colors.transparent,
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
