import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/dialogs/time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/form/app_time_picker_field.dart';

import '../../support/pump_app.dart';

void main() {
  const fieldName = 'remindAt';
  const nineThirty = TimeOfDay(hour: 9, minute: 30);

  Future<GlobalKey<FormBuilderState>> pumpField(
    WidgetTester tester, {
    List<TimeOfDay?>? changes,
    TimeOfDay? initialValue,
    bool required = false,
  }) async {
    final formKey = GlobalKey<FormBuilderState>();

    await tester.pumpApp(
      FormBuilder(
        key: formKey,
        initialValue: {fieldName: ?initialValue},
        child: AppTimePickerField(
          name: fieldName,
          label: 'Remind at',
          required: required,
          onChanged: changes?.add,
        ),
      ),
    );

    return formKey;
  }

  group('AppTimePickerField', () {
    testWidgets('shows the initial form value as a formatted time', (
      tester,
    ) async {
      await pumpField(tester, initialValue: nineThirty);

      expect(find.text('9:30 AM'), findsOneWidget);
    });

    testWidgets('confirming the sheet stores the time and reports onChanged', (
      tester,
    ) async {
      final changes = <TimeOfDay?>[];
      final formKey = await pumpField(
        tester,
        changes: changes,
        initialValue: nineThirty,
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(TimePickerBottomSheet), findsOneWidget);

      await tester.drag(find.text('30'), const Offset(0, -32));
      await tester.pumpAndSettle();
      await tester.tap(find.text(tester.uikitL10n.toSelect));
      await tester.pumpAndSettle();

      const nineThirtyOne = TimeOfDay(hour: 9, minute: 31);

      expect(formKey.currentState!.fields[fieldName]!.value, nineThirtyOne);
      expect(find.text('9:31 AM'), findsOneWidget);
      expect(changes, [nineThirtyOne]);
    });

    testWidgets('going back from the sheet keeps the value', (tester) async {
      final changes = <TimeOfDay?>[];
      final formKey = await pumpField(
        tester,
        changes: changes,
        initialValue: nineThirty,
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text(tester.uikitL10n.back));
      await tester.pumpAndSettle();

      expect(formKey.currentState!.fields[fieldName]!.value, nineThirty);
      expect(changes, isEmpty);
    });

    testWidgets('required fails validation and shows the error when empty', (
      tester,
    ) async {
      final formKey = await pumpField(tester, required: true);

      expect(formKey.currentState!.saveAndValidate(), isFalse);
      await tester.pumpAndSettle();

      final requiredError = formKey.currentState!.fields[fieldName]!.errorText!;

      expect(tester.fadeOpacityOf(find.text('* $requiredError')), 1);
    });
  });
}
