import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';

import '../../support/pump_app.dart';

void main() {
  BoxDecoration decorationOf(WidgetTester tester) =>
      tester
              .widget<DecoratedBox>(
                find
                    .descendant(
                      of: find.byType(AppCard),
                      matching: find.byType(DecoratedBox),
                    )
                    .first,
              )
              .decoration
          as BoxDecoration;

  group('AppCard', () {
    testWidgets('shows its child and fires onTap', (tester) async {
      var taps = 0;

      await tester.pumpApp(
        AppCard(onTap: () => taps++, child: const Text('Card')),
      );
      await tester.tap(find.text('Card'));

      expect(find.text('Card'), findsOneWidget);
      expect(taps, 1);
    });

    testWidgets('is inert without onTap', (tester) async {
      await tester.pumpApp(const AppCard(child: Text('Card')));
      await tester.tap(find.text('Card'));

      expect(tester.takeException(), isNull);
    });

    testWidgets('selected switches to the selected surface and accent '
        'outline', (tester) async {
      await tester.pumpApp(const AppCard(child: Text('Card')));

      final theme = ThemeProvider.of(tester.element(find.text('Card'))).theme;

      expect(decorationOf(tester).color, theme.surface);

      await tester.pumpApp(const AppCard(selected: true, child: Text('Card')));

      final decoration = decorationOf(tester);

      expect(decoration.color, theme.selectedSurface);
      expect((decoration.border! as Border).top.color, theme.accent);
    });
  });
}
