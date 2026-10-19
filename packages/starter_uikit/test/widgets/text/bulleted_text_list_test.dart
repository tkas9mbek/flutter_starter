import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/text/bulleted_text_list.dart';

import '../../support/pump_app.dart';

void main() => group('BulletedTextList', () {
  testWidgets('puts every entry, in order, behind a muted bullet', (
    tester,
  ) async {
    const entries = ['First', 'Second', 'Third'];

    await tester.pumpApp(const BulletedTextList(texts: entries));

    final bullets = find.text('•');
    final rendered = tester
        .widgetList<Text>(find.byType(Text))
        .map((text) => text.data)
        .where(entries.contains);

    expect(bullets, findsNWidgets(entries.length));
    expect(rendered, entries);
    expect(
      tester.widget<Text>(bullets.first).style!.color,
      AppTheme.light().textTertiary,
    );
  });

  testWidgets('applies textStyle to the entries', (tester) async {
    final style = AppTextStyles(AppTheme.light()).boldBody16;

    await tester.pumpApp(
      BulletedTextList(texts: const ['Only'], textStyle: style),
    );

    expect(tester.widget<Text>(find.text('Only')).style, style);
  });

  testWidgets('renders nothing for an empty list', (tester) async {
    await tester.pumpApp(const BulletedTextList(texts: []));

    expect(find.text('•'), findsNothing);
  });
});
