import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/application/environment/ui/switcher/widget/tap_activator.dart';

import '../../../support/pump.dart';

void main() {
  const quickGap = Duration(milliseconds: 100);
  const resetWindow = Duration(milliseconds: 600);

  Future<void> tapTimes(WidgetTester tester, int times) async {
    for (var i = 0; i < times; i++) {
      await tester.tap(find.text('Logo'));
      await tester.pump(quickGap);
    }
  }

  group('TapActivator', () {
    testWidgets('activates after tapCount quick taps, then starts over', (
      tester,
    ) async {
      var activations = 0;

      await tester.pumpWidget(
        wrapWidget(
          TapActivator(
            tapCount: 3,
            onActivated: () => activations++,
            child: const Text('Logo'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tapTimes(tester, 2);

      expect(activations, 0);

      await tapTimes(tester, 1);

      expect(activations, 1);

      await tapTimes(tester, 3);

      expect(activations, 2);

      await tester.pump(resetWindow);
    });

    testWidgets('a pause longer than 500ms resets the count', (tester) async {
      var activations = 0;

      await tester.pumpWidget(
        wrapWidget(
          TapActivator(
            tapCount: 3,
            onActivated: () => activations++,
            child: const Text('Logo'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tapTimes(tester, 2);
      await tester.pump(resetWindow);
      await tapTimes(tester, 2);

      expect(activations, 0);

      await tapTimes(tester, 1);

      expect(activations, 1);

      await tester.pump(resetWindow);
    });
  });
}
