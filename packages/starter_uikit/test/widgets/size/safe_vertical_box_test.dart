import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/size/safe_vertical_box.dart';

import '../../support/pump_app.dart';

void main() {
  const insets = EdgeInsets.only(top: 40, bottom: 30);

  Future<double?> heightOf(WidgetTester tester, SafeVerticalBox box) async {
    await tester.pumpApp(
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(padding: insets),
          child: box,
        ),
      ),
    );

    return tester
        .widget<SizedBox>(
          find.descendant(
            of: find.byType(SafeVerticalBox),
            matching: find.byType(SizedBox),
          ),
        )
        .height;
  }

  group('SafeVerticalBox', () {
    testWidgets('top grows to at least the status-bar inset', (tester) async {
      expect(await heightOf(tester, const SafeVerticalBox(top: true)), 40);
      expect(
        await heightOf(tester, const SafeVerticalBox(top: true, height: 20)),
        40,
      );
      expect(
        await heightOf(tester, const SafeVerticalBox(top: true, height: 60)),
        60,
      );
    });

    testWidgets('bottom grows to at least the bottom inset', (tester) async {
      expect(await heightOf(tester, const SafeVerticalBox(bottom: true)), 30);
      expect(
        await heightOf(tester, const SafeVerticalBox(bottom: true, height: 50)),
        50,
      );
    });

    testWidgets(
      'without top/bottom it is a plain spacer of height',
      (tester) async =>
          expect(await heightOf(tester, const SafeVerticalBox(height: 12)), 12),
    );
  });
}
