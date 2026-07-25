import 'package:flutter/material.dart';

/// Displays a left-aligned bulleted list: each entry of [texts] on its own
/// line behind a bullet marker, styled with [textStyle].
class BulletedTextList extends StatelessWidget {
  const BulletedTextList({required this.texts, this.textStyle, super.key});

  final List<String> texts;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final text in texts) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•', style: textStyle),
              const SizedBox(width: 8),
              Expanded(child: Text(text, style: textStyle)),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
