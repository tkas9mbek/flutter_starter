import 'package:flutter/material.dart';

class BulletedTextList extends StatelessWidget {
  const BulletedTextList({
    required this.texts,
    this.textStyle,
    super.key,
  });

  final List<String> texts;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '•',
              style: textStyle,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                texts.first,
                style: textStyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
