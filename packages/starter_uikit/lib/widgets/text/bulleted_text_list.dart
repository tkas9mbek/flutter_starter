import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Displays a left-aligned bulleted list: each entry of [texts] on its own
/// line behind a muted bullet, styled with [textStyle] (body 14 by default).
class BulletedTextList extends StatelessWidget {
  const BulletedTextList({required this.texts, this.textStyle, super.key});

  final List<String> texts;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final style = textStyle ?? textStyles.regularBody14;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final text in texts) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•', style: style.copyWith(color: theme.textTertiary)),
              const SizedBox(width: 8),
              Expanded(child: Text(text, style: style)),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
