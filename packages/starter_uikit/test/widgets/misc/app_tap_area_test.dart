import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';

import '../../support/pump_app.dart';

void main() {
  group('AppTapArea', () {
    testWidgets('fires onTap', (tester) async {
      var taps = 0;

      await tester.pumpApp(
        AppTapArea(onTap: () => taps++, child: const Text('Area')),
      );
      await tester.tap(find.text('Area'));

      expect(taps, 1);
    });

    testWidgets('is inert without onTap', (tester) async {
      await tester.pumpApp(const AppTapArea(child: Text('Area')));
      await tester.tap(find.text('Area'));

      expect(tester.takeException(), isNull);
    });

    testWidgets('is announced as a button with its label when tappable', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpApp(
        AppTapArea(
          onTap: () {},
          semanticLabel: 'Close',
          selected: true,
          child: const SizedBox(width: 48, height: 48),
        ),
      );

      expect(
        tester.getSemantics(find.byType(AppTapArea)),
        matchesSemantics(
          label: 'Close',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
          hasTapAction: true,
          hasFocusAction: true,
          isFocusable: true,
        ),
      );

      handle.dispose();
    });

    testWidgets('is not announced as a button without onTap', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpApp(const AppTapArea(child: Text('Area')));

      expect(
        tester.getSemantics(find.byType(AppTapArea)),
        isNot(matchesSemantics(isButton: true)),
      );

      handle.dispose();
    });
  });
}
