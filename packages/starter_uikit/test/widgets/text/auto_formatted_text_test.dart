import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/text/auto_formatted_text.dart';

import '../../support/pump_app.dart';

void main() {
  final textStyles = AppTextStyles(AppTheme.light());
  final bold = textStyles.boldBody14;

  TextSpan rootSpanOf(WidgetTester tester) =>
      tester.widget<Text>(find.byType(Text)).textSpan! as TextSpan;

  /// Children of the root span as `(text, style)` pairs.
  List<(String?, TextStyle?)> spansOf(WidgetTester tester) {
    final root = rootSpanOf(tester);

    return root.children!
        .cast<TextSpan>()
        .map((span) => (span.text, span.style))
        .toList();
  }

  group('AutoFormattedText', () {
    testWidgets('formats tagged segments and strips the markers', (
      tester,
    ) async {
      await tester.pumpApp(
        AutoFormattedText(
          'Pay **100** by **Friday**.',
          tag: '**',
          formatStyle: bold,
        ),
      );

      expect(
        find.text('Pay 100 by Friday.', findRichText: true),
        findsOneWidget,
      );
      expect(spansOf(tester), [
        ('Pay ', null),
        ('100', bold),
        (' by ', null),
        ('Friday', bold),
        ('.', null),
      ]);
    });

    testWidgets('treats regex characters in the tag literally', (tester) async {
      await tester.pumpApp(
        AutoFormattedText(r'a $b$ c', tag: r'$', formatStyle: bold),
      );

      expect(spansOf(tester), [('a ', null), ('b', bold), (' c', null)]);
    });

    testWidgets('leaves an unpaired marker as plain text', (tester) async {
      await tester.pumpApp(
        AutoFormattedText('Half **open', tag: '**', formatStyle: bold),
      );

      expect(spansOf(tester), [('Half **open', null)]);
    });

    testWidgets('uses body 14 unless a style is given', (tester) async {
      await tester.pumpApp(const AutoFormattedText('plain', tag: '**'));

      final root = rootSpanOf(tester);

      expect(root.style, textStyles.regularBody14);
      expect(root.children!.single.style, isNull);
    });
  });
}
