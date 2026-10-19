import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/form/save_and_validate_form.dart';

void main() {
  late GlobalKey<FormBuilderState> formKey;

  Future<void> pumpForm(WidgetTester tester, String initialValue) async {
    formKey = GlobalKey<FormBuilderState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              FormBuilder(
                key: formKey,
                child: FormBuilderTextField(
                  name: 'title',
                  initialValue: initialValue,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  testWidgets('returns true and saves a valid form', (tester) async {
    await pumpForm(tester, 'Groceries');

    expect(saveAndValidateForm(formKey), isTrue);
    expect(formKey.currentState!.value, {'title': 'Groceries'});
  });

  testWidgets('returns false and shows the error of an invalid form', (
    tester,
  ) async {
    await pumpForm(tester, '');

    expect(saveAndValidateForm(formKey), isFalse);
    await tester.pumpAndSettle();

    expect(find.text('Required'), findsOneWidget);
  });
}
