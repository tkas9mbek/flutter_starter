import 'package:flutter/material.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/text/auto_formatted_text.dart';

class FullFormattedText extends StatelessWidget {
  /// Allows you to use tags in the text in the following format: <tag>text</tag>.
  /// Supported tags:
  /// - <b> - bold text
  /// - <i> - italic text
  /// - <u> - underlined text
  /// - <link> - text with a link
  const FullFormattedText({
    required this.text,
    super.key,
  });

  final Text text;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final tagTextStyle = {
      '<b>': const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      '<i>': const TextStyle(
        fontStyle: FontStyle.italic,
      ),
      '<u>': const TextStyle(
        decoration: TextDecoration.underline,
      ),
      '<link>': TextStyle(
        color: theme.primary,
      ),
    };

    AutoFormattedText? currentText;

    for (final tag in tagTextStyle.keys) {
      currentText = AutoFormattedText(
        currentText?.text ?? text.data ?? '',
        style: currentText?.style ?? text.style,
        tag: tag,
        formatStyle: tagTextStyle[tag],
        textAlign: currentText?.textAlign ?? text.textAlign ?? TextAlign.start,
      );
    }

    return currentText ?? text;
  }
}
