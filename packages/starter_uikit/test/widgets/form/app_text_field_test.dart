import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';

import '../../support/pump_app.dart';

void main() {
  const fieldName = 'email';

  Widget buildForm(GlobalKey<FormBuilderState> formKey, AppTextField field) =>
      FormBuilder(key: formKey, child: field);

  group('AppTextField', () {
    testWidgets('typing updates the form value and reports onChanged', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();
      final changes = <String?>[];

      await tester.pumpApp(
        buildForm(
          formKey,
          AppTextField(name: fieldName, onChanged: changes.add),
        ),
      );
      await tester.enterText(find.byType(TextField), 'abc');
      await tester.pump();

      expect(changes.last, 'abc');
      expect(formKey.currentState!.fields[fieldName]!.value, 'abc');
    });

    testWidgets('shows the first failing validator message', (tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpApp(
        buildForm(
          formKey,
          AppTextField(
            name: fieldName,
            validators: [
              (value) => (value?.contains('@') ?? false) ? null : 'Bad email',
              (value) => 'never reached',
            ],
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'nope');

      expect(formKey.currentState!.saveAndValidate(), isFalse);
      await tester.pumpAndSettle();

      expect(tester.fadeOpacityOf(find.text('* Bad email')), 1);
      expect(find.text('* never reached'), findsNothing);
    });

    testWidgets('required shows the localized required error when empty', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpApp(
        buildForm(formKey, const AppTextField(name: fieldName, required: true)),
      );

      expect(formKey.currentState!.saveAndValidate(), isFalse);
      await tester.pumpAndSettle();

      final l10n = tester.toolkitL10n;

      expect(
        tester.fadeOpacityOf(find.text('* ${l10n.errorRequiredField}')),
        1,
      );
    });

    testWidgets('hideErrorText suppresses the inline error but still fails', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpApp(
        buildForm(
          formKey,
          AppTextField(
            name: fieldName,
            hideErrorText: true,
            validators: [(_) => 'Bad'],
          ),
        ),
      );

      expect(formKey.currentState!.saveAndValidate(), isFalse);
      await tester.pumpAndSettle();

      expect(tester.fadeOpacityOf(find.text('* Bad')), 0);
    });

    testWidgets('canObscureText hides the input and the eye icon reveals it', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpApp(
        buildForm(
          formKey,
          const AppTextField(name: fieldName, canObscureText: true),
        ),
      );

      bool obscured() =>
          tester.widget<EditableText>(find.byType(EditableText)).obscureText;

      expect(obscured(), isTrue);

      await tester.tap(find.byType(GestureDetector).last);
      await tester.pump();

      expect(obscured(), isFalse);
    });
  });
}
