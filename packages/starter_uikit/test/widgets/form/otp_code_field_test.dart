import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/otp_code_field.dart';

import '../../support/pump_app.dart';

void main() {
  Future<void> enterDigits(WidgetTester tester, String digits) async {
    for (var i = 0; i < digits.length; i++) {
      await tester.enterText(find.byType(TextField).at(i), digits[i]);
      await tester.pump();
    }
  }

  group('OtpCodeField', () {
    testWidgets('renders one box per digit', (tester) async {
      await tester.pumpApp(OtpCodeField(length: 6, onCompleted: (_) {}));

      expect(find.byType(TextField), findsNWidgets(6));
    });

    testWidgets('onCompleted fires once with the full code', (tester) async {
      final codes = <String>[];

      await tester.pumpApp(OtpCodeField(onCompleted: codes.add));
      await enterDigits(tester, '1234');

      expect(codes, ['1234']);
    });

    testWidgets('onCompleted does not fire for a partial code', (tester) async {
      final codes = <String>[];

      await tester.pumpApp(OtpCodeField(onCompleted: codes.add));
      await enterDigits(tester, '123');

      expect(codes, isEmpty);
    });

    testWidgets('rejects non-digit input', (tester) async {
      await tester.pumpApp(OtpCodeField(onCompleted: (_) {}));
      await tester.enterText(find.byType(TextField).first, 'a');
      await tester.pump();

      final field = tester.widget<TextField>(find.byType(TextField).first);

      expect(field.controller!.text, isEmpty);
    });

    testWidgets('controller.clear empties every box', (tester) async {
      final controller = OtpCodeFieldController();

      await tester.pumpApp(
        OtpCodeField(controller: controller, onCompleted: (_) {}),
      );
      await enterDigits(tester, '1234');

      controller.clear();
      await tester.pump();

      for (final field in tester.widgetList<TextField>(
        find.byType(TextField),
      )) {
        expect(field.controller!.text, isEmpty);
      }
    });
  });
}
