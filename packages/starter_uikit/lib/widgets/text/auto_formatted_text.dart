import 'package:flutter/material.dart';

class AutoFormattedText extends StatelessWidget {
  /// Allows you to format text using tags in the text.
  /// Tags are used in the following format: <tag>text</tag>.
  ///
  /// * [text] - the text to be formatted.
  /// * [tag] - the tag used to format the text.
  /// * [style] - the style of the text.
  /// * [formatStyle] - the style of the text between the tags.
  const AutoFormattedText(
    this.text, {
    required this.tag,
    this.textAlign = TextAlign.start,
    this.style,
    this.formatStyle,
    super.key,
  });

  final String text;
  final String tag;
  final TextStyle? style;
  final TextStyle? formatStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final textSpans = <InlineSpan>[];
    final exp = RegExp('$tag(.*?)$tag');
    final matches = exp.allMatches(text);
    var currentStart = 0;

    for (final match in matches) {
      final beforeMatch = text.substring(currentStart, match.start);
      final matchContent = match.group(1) ?? '';

      textSpans
        ..add(TextSpan(text: beforeMatch))
        ..add(TextSpan(text: matchContent, style: formatStyle));
      currentStart = match.end;
    }

    if (currentStart < text.length) {
      final remainingText = text.substring(currentStart);
      textSpans.add(TextSpan(text: remainingText));
    }

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: style,
        children: textSpans,
      ),
    );
  }
}
