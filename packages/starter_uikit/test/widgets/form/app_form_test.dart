import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/app_form.dart';
import 'package:starter_uikit/widgets/form/app_text_field.dart';

import '../../support/pump_app.dart';

void main() {
  const emailField = 'email';
  const nameField = 'name';
  const badEmail = 'Bad email';

  String? emailValidator(String? value) =>
      (value?.contains('@') ?? false) ? null : badEmail;

  Future<GlobalKey<AppFormState>> pumpForm(WidgetTester tester) async {
    final formKey = GlobalKey<AppFormState>();

    await tester.pumpApp(
      AppForm(
        key: formKey,
        child: Column(
          children: [
            AppTextField(name: emailField, validators: [emailValidator]),
            const AppTextField(name: nameField, required: true),
          ],
        ),
      ),
    );

    return formKey;
  }

  Future<void> type(WidgetTester tester, String field, String text) async {
    await tester.enterText(
      find.byType(TextField).at(field == emailField ? 0 : 1),
      text,
    );
    await tester.pumpAndSettle();
  }

  group('AppForm', () {
    testWidgets('stays quiet while the user types before the first submit', (
      tester,
    ) async {
      await pumpForm(tester);

      await type(tester, emailField, 'nope');

      expect(find.text(badEmail), findsNothing);
    });

    testWidgets('shows errors on the first submit and returns false', (
      tester,
    ) async {
      final formKey = await pumpForm(tester);
      await type(tester, emailField, 'nope');

      final valid = formKey.currentState!.saveAndValidate();
      await tester.pumpAndSettle();

      expect(valid, isFalse);
      expect(find.text(badEmail), findsOneWidget);
    });

    testWidgets('clears the error once the user fixes the field', (
      tester,
    ) async {
      final formKey = await pumpForm(tester);
      await type(tester, emailField, 'nope');
      formKey.currentState!.saveAndValidate();
      await tester.pumpAndSettle();

      await type(tester, emailField, 'me@example.com');

      expect(find.text(badEmail), findsNothing);
    });

    testWidgets('shows the error again when the user breaks the field', (
      tester,
    ) async {
      final formKey = await pumpForm(tester);
      await type(tester, emailField, 'me@example.com');
      formKey.currentState!.saveAndValidate();
      await tester.pumpAndSettle();

      await type(tester, emailField, 'nope');

      expect(find.text(badEmail), findsOneWidget);
    });

    testWidgets('returns true and exposes the values for a valid form', (
      tester,
    ) async {
      final formKey = await pumpForm(tester);
      await type(tester, emailField, 'me@example.com');
      await type(tester, nameField, 'Ada');

      final valid = formKey.currentState!.saveAndValidate();

      expect(valid, isTrue);
      expect(formKey.currentState!.value, {
        emailField: 'me@example.com',
        nameField: 'Ada',
      });
    });

    testWidgets('validates one field and leaves the others quiet', (
      tester,
    ) async {
      final formKey = await pumpForm(tester);
      await type(tester, emailField, 'nope');

      final valid = formKey.currentState!.validateField(emailField);
      await tester.pumpAndSettle();

      expect(valid, isFalse);
      expect(find.text(badEmail), findsOneWidget);
      expect(find.text('Required field'), findsNothing);
    });

    testWidgets('keeps re-validating a field checked on its own', (
      tester,
    ) async {
      final formKey = await pumpForm(tester);
      await type(tester, emailField, 'nope');
      formKey.currentState!.validateField(emailField);
      await tester.pumpAndSettle();

      await type(tester, emailField, 'me@example.com');
      expect(find.text(badEmail), findsNothing);

      await type(tester, emailField, 'nope');
      expect(find.text(badEmail), findsOneWidget);
      expect(find.text('Required field'), findsNothing);
    });

    testWidgets('lets a field read another field and find its form', (
      tester,
    ) async {
      final formKey = await pumpForm(tester);
      await type(tester, nameField, 'Ada');

      expect(formKey.currentState!.fieldValue<String>(nameField), 'Ada');
      expect(formKey.currentState!.fieldValue<String>('missing'), isNull);
      expect(
        AppForm.maybeOf(tester.element(find.byType(AppTextField).first)),
        formKey.currentState,
      );
    });
  });
}
