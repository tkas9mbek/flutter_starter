import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/theme_provider.dart';

class ThinVerticalDivider extends StatelessWidget {
  const ThinVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return VerticalDivider(
      width: 1,
      thickness: 1,
      color: theme.border,
    );
  }
}
