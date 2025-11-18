import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;
    final theme = ThemeProvider.of(context).theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: textStyles.boldBody14.copyWith(
          color: theme.textSecondary,
        ),
      ),
    );
  }
}
