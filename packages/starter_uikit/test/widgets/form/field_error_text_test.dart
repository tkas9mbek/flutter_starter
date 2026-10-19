import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/decoration/field_error_text.dart';

import '../../support/pump_app.dart';

void main() {
  group('FieldErrorText', () {
    testWidgets('fades the prefixed message in only when visible', (
      tester,
    ) async {
      await tester.pumpApp(
        const FieldErrorText(visible: false, errorText: 'Bad'),
      );

      expect(tester.fadeOpacityOf(find.text('* Bad')), 0);

      await tester.pumpApp(
        const FieldErrorText(visible: true, errorText: 'Bad'),
      );

      expect(tester.fadeOpacityOf(find.text('* Bad')), 1);
    });
  });
}
