import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;
    final theme = ThemeProvider.of(context).theme;

    return Text(
      title,
      style: textStyles.mediumBody13.copyWith(color: theme.textSecondary),
    );
  }
}
