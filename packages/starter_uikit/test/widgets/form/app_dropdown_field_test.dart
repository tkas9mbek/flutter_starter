import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/form/app_dropdown_field.dart';

import '../../support/pump_app.dart';

void main() {
  const fieldName = 'fruit';
  const options = ['apple', 'pear'];

  String labelOf(String value) => value.toUpperCase();

  Future<GlobalKey<FormBuilderState>> pumpField(
    WidgetTester tester, {
    String? initialValue,
    bool enabled = true,
    bool required = false,
    bool hideErrorText = true,
  }) async {
    final formKey = GlobalKey<FormBuilderState>();

    await tester.pumpApp(
      FormBuilder(
        key: formKey,
        child: AppDropdownField<String>(
          name: fieldName,
          label: 'Fruit',
          options: options,
          optionLabelBuilder: labelOf,
          initialValue: initialValue,
          enabled: enabled,
          required: required,
          hideErrorText: hideErrorText,
        ),
      ),
    );

    return formKey;
  }

  group('AppDropdownField', () {
    testWidgets('opens the sheet and stores the picked option', (tester) async {
      final formKey = await pumpField(tester);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(DropdownBottomSheet<String>), findsOneWidget);

      await tester.tap(find.text('PEAR'));
      await tester.pumpAndSettle();

      expect(find.byType(DropdownBottomSheet<String>), findsNothing);
      expect(formKey.currentState!.fields[fieldName]!.value, 'pear');
      expect(find.text('PEAR'), findsOneWidget);
    });

    testWidgets('shows the label of the initial value', (tester) async {
      await pumpField(tester, initialValue: 'apple');

      expect(find.text('APPLE'), findsOneWidget);
      expect(find.text('Fruit'), findsWidgets);
    });

    testWidgets('dismissing the sheet keeps the previous value', (
      tester,
    ) async {
      final formKey = await pumpField(tester, initialValue: 'apple');

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text(tester.uikitL10n.back));
      await tester.pumpAndSettle();

      expect(formKey.currentState!.fields[fieldName]!.value, 'apple');
    });

    testWidgets('a disabled field does not open the sheet', (tester) async {
      await pumpField(tester, enabled: false);

      await tester.tap(find.byType(TextField), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byType(DropdownBottomSheet<String>), findsNothing);
    });

    testWidgets('required fails validation and shows the error when empty', (
      tester,
    ) async {
      final formKey = await pumpField(
        tester,
        required: true,
        hideErrorText: false,
      );

      expect(formKey.currentState!.saveAndValidate(), isFalse);
      await tester.pumpAndSettle();

      final requiredError = formKey.currentState!.fields[fieldName]!.errorText!;

      expect(tester.fadeOpacityOf(find.text('* $requiredError')), 1);
    });
  });
}
