import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

/// Foundation for the uikit buttons: a flat button (no elevation, overlay or
/// splash) with configurable colors, border, and optional [icon]. Swaps its
/// label for a progress indicator while [loading] and applies the disabled
/// colors when not [enabled].
class AppBaseButton extends StatelessWidget {
  const AppBaseButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.textStyle,
    this.borderRadius = AppRadii.control,
    this.enabled = true,
    this.loading = false,
    this.iconDirection = TextDirection.ltr,
    this.height,
    this.width,
    this.onPressed,
    this.onLongPressed,
    this.onDisabledPressed,
    this.icon,
    this.disabledTextColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.disabledBorderColor,
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

  /// Outline while not [enabled]; falls back to [borderColor].
  final Color? disabledBorderColor;
  final TextDirection iconDirection;
  final double borderRadius;
  final EdgeInsets? padding;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final active = enabled && !loading;
    final foreground = enabled ? textColor : disabledTextColor ?? textColor;
    final background = enabled
        ? backgroundColor
        : disabledBackgroundColor ?? backgroundColor;
    final border = enabled ? borderColor : disabledBorderColor ?? borderColor;
    final inactivePressed = loading ? () {} : onDisabledPressed ?? () {};

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: active ? onPressed : inactivePressed,
        onLongPress: active ? onLongPressed : inactivePressed,
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashFactory: NoSplash.splashFactory,
          overlayColor: const WidgetStatePropertyAll(AppColors.transparent),
          shadowColor: const WidgetStatePropertyAll(AppColors.transparent),
          surfaceTintColor: const WidgetStatePropertyAll(AppColors.transparent),
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(background),
          foregroundColor: WidgetStatePropertyAll(foreground),
          // [height] is a minimum so large text grows the button, not clips.
          minimumSize: WidgetStatePropertyAll(Size(0, height ?? 0)),
          maximumSize: WidgetStatePropertyAll(
            Size(width ?? double.infinity, double.infinity),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: border ?? AppColors.transparent),
          ),
          padding: WidgetStatePropertyAll(padding ?? EdgeInsets.zero),
        ),
        child: _ButtonLabel(
          text: text,
          textStyle: textStyle.copyWith(color: foreground),
          loading: loading,
          spinnerColor: textColor,
          iconDirection: iconDirection,
          icon: icon,
        ),
      ),
    );
  }
}

class _ButtonLabel extends StatelessWidget {
  const _ButtonLabel({
    required this.text,
    required this.textStyle,
    required this.loading,
    required this.spinnerColor,
    required this.iconDirection,
    this.icon,
  });

  final String text;
  final TextStyle textStyle;
  final bool loading;
  final Color spinnerColor;
  final TextDirection iconDirection;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      // Sized to the label's line height so the button keeps its height.
      return CustomCircularProgressIndicator.adaptive(
        color: spinnerColor,
        size: textStyle.fontSize! * (textStyle.height ?? 1),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null && iconDirection == TextDirection.ltr) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(text, style: textStyle),
        if (icon != null && iconDirection == TextDirection.rtl) ...[
          const SizedBox(width: 8),
          icon!,
        ],
      ],
    );
  }
}
