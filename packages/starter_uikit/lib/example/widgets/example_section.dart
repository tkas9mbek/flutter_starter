import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// **INTERNAL USE ONLY**: A titled gallery section — a muted section header
/// above [children] spaced on the 12px grid, followed by a 24px gap.
@visibleForTesting
class ExampleSection extends StatelessWidget {
  const ExampleSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: textStyles.mediumBody13.copyWith(color: theme.textSecondary),
          ),
          for (final child in children) ...[const SizedBox(height: 12), child],
        ],
      ),
    );
  }
}
