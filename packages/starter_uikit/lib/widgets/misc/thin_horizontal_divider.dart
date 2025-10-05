import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class ThinHorizontalDivider extends StatelessWidget {
  const ThinHorizontalDivider({
    this.color,
    super.key,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Divider(
      height: 1,
      thickness: 1,
      color: color ?? theme.border,
    );
  }
}
