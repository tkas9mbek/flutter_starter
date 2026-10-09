import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/app_checkbox_field.dart';

import '../../support/pump_app.dart';

void main() {
  const fieldName = 'terms';

  Widget buildForm(
    GlobalKey<FormBuilderState> formKey, {
    ValueChanged<bool>? onChanged,
    VoidCallback? onPressed,
    FormFieldValidator<dynamic>? validator,
    bool enabled = true,
    bool hideErrorText = true,
  }) => FormBuilder(
    key: formKey,
    child: AppCheckboxField(
      name: fieldName,
      label: 'Accept terms',
      onChanged: onChanged,
      onPressed: onPressed,
      validator: validator,
      enabled: enabled,
      hideErrorText: hideErrorText,
    ),
  );

  group('AppCheckboxField', () {
    testWidgets('tapping toggles the value and reports onChanged', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();
      final changes = <bool>[];

      await tester.pumpApp(buildForm(formKey, onChanged: changes.add));

      expect(find.text('Accept terms'), findsOneWidget);

      await tester.tap(find.text('Accept terms'));
      await tester.pump();

      expect(formKey.currentState!.fields[fieldName]!.value, isTrue);

      await tester.tap(find.text('Accept terms'));
      await tester.pump();

      expect(changes, [true, false]);
    });

    testWidgets('does not change when disabled', (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      final changes = <bool>[];

      await tester.pumpApp(
        buildForm(formKey, onChanged: changes.add, enabled: false),
      );
      await tester.tap(find.text('Accept terms'));
      await tester.pump();

      expect(changes, isEmpty);
      expect(formKey.currentState!.fields[fieldName]!.value, isNull);
    });

    testWidgets('onPressed takes over from the built-in toggle', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();
      var presses = 0;

      await tester.pumpApp(buildForm(formKey, onPressed: () => presses++));
      await tester.tap(find.text('Accept terms'));
      await tester.pump();

      expect(presses, 1);
      expect(formKey.currentState!.fields[fieldName]!.value, isNull);
    });

    testWidgets('shows the validation error when hideErrorText is false', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpApp(
        buildForm(
          formKey,
          hideErrorText: false,
          validator: (value) => value == true ? null : 'Must accept',
        ),
      );

      expect(formKey.currentState!.saveAndValidate(), isFalse);
      await tester.pumpAndSettle();

      expect(tester.fadeOpacityOf(find.text('* Must accept')), 1);
    });
  });
}
