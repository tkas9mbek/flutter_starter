import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/app_theme.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/status/custom_circular_progress_indicator.dart';

class AppBaseButton extends StatelessWidget {
  /// Elevated button with custom background color, text color, and optional
  /// icon. The button can be disabled, loading, or have a border.
  const AppBaseButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderRadius = 16,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.enabled = true,
    this.loading = false,
    this.iconDirection = TextDirection.ltr,
    this.height,
    this.onPressed,
    this.onLongPressed,
    this.onDisabledPressed,
    this.width,
    this.icon,
    this.borderColor,
    super.key,
  });

  AppBaseButton.elevated({
    required AppTheme theme,
    required this.text,
    this.enabled = true,
    this.loading = false,
    this.height = 40,
    this.borderRadius = 16,
    this.iconDirection = TextDirection.ltr,
    this.onPressed,
    this.onLongPressed,
    this.onDisabledPressed,
    this.width,
    this.icon,
    super.key,
  })  : backgroundColor = theme.primary,
        textColor = theme.onPrimary,
        disabledBackgroundColor = theme.primary,
        disabledTextColor = theme.onPrimary,
        borderColor = null;

  AppBaseButton.flat({
    required AppTheme theme,
    required this.text,
    this.enabled = true,
    this.loading = false,
    this.height = 40,
    this.borderRadius = 16,
    this.iconDirection = TextDirection.ltr,
    this.onPressed,
    this.onLongPressed,
    this.onDisabledPressed,
    this.width,
    this.icon,
    super.key,
  })  : backgroundColor = theme.surface,
        textColor = theme.onSurface,
        disabledBackgroundColor = null,
        disabledTextColor = null,
        borderColor = null;

  AppBaseButton.outLined({
    required AppTheme theme,
    required this.text,
    this.enabled = true,
    this.loading = false,
    this.height = 40,
    this.borderRadius = 16,
    this.iconDirection = TextDirection.ltr,
    this.onPressed,
    this.onLongPressed,
    this.onDisabledPressed,
    this.width,
    this.icon,
    super.key,
  })  : backgroundColor = Colors.transparent,
        textColor = theme.onBackground,
        disabledTextColor = null,
        disabledBackgroundColor = null,
        borderColor = theme.primary;

  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final VoidCallback? onDisabledPressed;
  final VoidCallback? onLongPressed;
  final bool loading;
  final bool enabled;
  final String text;
  final Widget? icon;
  final Color textColor;
  final Color backgroundColor;
  final Color? disabledTextColor;
  final Color? disabledBackgroundColor;
  final Color? borderColor;
  final TextDirection iconDirection;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;
    final active = enabled && !loading;
    final textStyle = textStyles.bodyMedium.copyWith(
      color:
          enabled || disabledTextColor == null ? textColor : disabledTextColor,
    );
    final childSize = textStyle.fontSize! * textStyle.height!;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: active ? onPressed : onDisabledPressed ?? () {},
        onLongPress: active ? onLongPressed : onDisabledPressed ?? () {},
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
          elevation: WidgetStateProperty.all<double>(0),
          backgroundColor: WidgetStateProperty.all<Color>(
            enabled || disabledBackgroundColor == null
                ? backgroundColor
                : disabledBackgroundColor!,
          ),
          maximumSize: WidgetStateProperty.all<Size>(
            Size(width ?? double.infinity, height ?? double.infinity),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          side: WidgetStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: loading
            ? CustomCircularProgressIndicator(
                color: textColor,
                size: childSize,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null && iconDirection == TextDirection.ltr) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: textStyle,
                  ),
                  if (icon != null && iconDirection == TextDirection.rtl) ...[
                    const SizedBox(width: 8),
                    icon!,
                  ],
                ],
              ),
      ),
    );
  }
}
