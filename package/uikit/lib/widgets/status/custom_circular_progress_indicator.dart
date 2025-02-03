import 'package:flutter/material.dart';
import 'package:uikit/theme/theme_provider.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    this.size = 24,
    this.color,
    super.key,
  });

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color ?? theme.primary,
          strokeWidth: size / 12,
        ),
      ),
    );
  }
}
