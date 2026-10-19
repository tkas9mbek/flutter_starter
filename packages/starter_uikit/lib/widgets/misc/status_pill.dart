import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// A short [label] on a solid [color] fill, for a status shown next to a
/// title. Pass a status token (`theme.success`, `theme.error`, ...); the label
/// is drawn in `onStatus`.
class StatusPill extends StatelessWidget {
  const StatusPill({required this.label, required this.color, super.key});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: textStyles.mediumBody12.copyWith(color: theme.onStatus),
        ),
      ),
    );
  }
}
