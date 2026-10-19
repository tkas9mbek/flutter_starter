import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/form/validatable_text_editing_controller.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/form/controller_text_field.dart';

import '../../support/pump_app.dart';

void main() {
  Color borderOf(WidgetTester tester) {
    final box = tester.widget<AnimatedContainer>(
      find
          .ancestor(
            of: find.byType(TextField),
            matching: find.byType(AnimatedContainer),
          )
          .first,
    );

    return ((box.decoration! as BoxDecoration).border! as Border).top.color;
  }

  group('ControllerTextField', () {
    testWidgets('shows the controller error and paints the error state', (
      tester,
    ) async {
      final theme = AppTheme.light();
      final controller = ValidatableTextEditingController(
        validators: [(value) => (value?.isEmpty ?? true) ? 'Empty' : null],
      );
      addTearDown(controller.dispose);

      await tester.pumpApp(
        ControllerTextField<ValidatableTextEditingController>(
          controller: controller,
          validate: (controller) => controller.error,
        ),
      );

      expect(find.text('* Empty'), findsNothing);
      expect(borderOf(tester), theme.border);

      controller.validate();
      await tester.pumpAndSettle();

      expect(tester.fadeOpacityOf(find.text('* Empty')), 1);
      expect(borderOf(tester), theme.errorText);
    });

    testWidgets('focus switches the outline to accent', (tester) async {
      final theme = AppTheme.light();
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpApp(ControllerTextField(controller: controller));
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(borderOf(tester), theme.accent);
    });

    testWidgets('clear button empties the text and reports onChanged', (
      tester,
    ) async {
      final controller = TextEditingController(text: 'abc');
      addTearDown(controller.dispose);
      final changes = <String>[];

      await tester.pumpApp(
        ControllerTextField(
          controller: controller,
          hasClearButton: true,
          onChanged: changes.add,
        ),
      );
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pump();

      expect(controller.text, isEmpty);
      expect(changes, ['']);
    });
  });
}
