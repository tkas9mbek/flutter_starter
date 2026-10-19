import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Renders [text] as rich text, applying [formatStyle] to segments wrapped
/// in [tag] markers (e.g. `**bold**`) while the rest keeps [style] (body 14
/// by default).
class AutoFormattedText extends StatelessWidget {
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
    final textStyles = ThemeProvider.of(context).textStyles;
    final textSpans = <InlineSpan>[];
    final escapedTag = RegExp.escape(tag);
    final exp = RegExp('$escapedTag(.*?)$escapedTag');
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

    return Text.rich(
      TextSpan(style: style ?? textStyles.regularBody14, children: textSpans),
      textAlign: textAlign,
    );
  }
}
