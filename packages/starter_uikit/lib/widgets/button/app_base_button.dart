import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

class AppBaseButton extends StatelessWidget {
  /// Elevated button with custom background color, text color, and optional
  /// icon. The button can be disabled, loading, or have a border.
  const AppBaseButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.textStyle,
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
    this.padding,
    super.key,
  });

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
  final EdgeInsets? padding;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final active = enabled && !loading;
    final effectiveTextStyle = textStyle.copyWith(
      color:
          enabled || disabledTextColor == null ? textColor : disabledTextColor,
    );
    final childSize = effectiveTextStyle.fontSize! * effectiveTextStyle.height!;

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
              width: 1,
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            padding ?? EdgeInsets.zero,
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
                    style: effectiveTextStyle,
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
