import 'package:flutter/material.dart';
import 'package:flutter_starter/uikit/button/app_base_button.dart';

class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    required this.text,
    required this.gradient,
    required this.textColor,
    this.loading = false,
    this.iconDirection = TextDirection.ltr,
    this.height = 40,
    this.borderRadius = 16,
    this.onPressed,
    this.onLongPressed,
    this.width,
    this.icon,
    super.key,
  });

  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final bool loading;
  final String text;
  final Widget? icon;
  final Color textColor;
  final TextDirection iconDirection;
  final double borderRadius;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: AppBaseButton(
        backgroundColor: Colors.transparent,
        borderRadius: borderRadius,
        text: text,
        textColor: textColor,
        enabled: true,
        loading: loading,
        iconDirection: iconDirection,
        onPressed: onPressed,
        onLongPressed: onLongPressed,
        height: height,
        width: width,
        icon: icon,
      ),
    );
  }
}
