import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/app_checkbox.dart';
import 'package:starter_uikit/widgets/form/app_checkbox_group.dart';

import '../../support/pump_app.dart';

void main() {
  const fieldName = 'tags';

  Widget buildGroup(
    GlobalKey<FormBuilderState> formKey, {
    ValueChanged<Set<String>>? onChanged,
    bool enabled = true,
  }) => FormBuilder(
    key: formKey,
    child: AppCheckboxGroup<String>(
      name: fieldName,
      options: const {'a', 'b'},
      enabled: enabled,
      onChanged: onChanged,
    ),
  );

  bool isChecked(WidgetTester tester, String label) => tester
      .widget<AppCheckBox>(
        find.ancestor(of: find.text(label), matching: find.byType(AppCheckBox)),
      )
      .selected;

  group('AppCheckboxGroup', () {
    testWidgets('tapping rows toggles them in the set value', (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      final changes = <Set<String>>[];

      await tester.pumpApp(buildGroup(formKey, onChanged: changes.add));

      await tester.tap(find.text('a'));
      await tester.pump();
      await tester.tap(find.text('b'));
      await tester.pump();
      await tester.tap(find.text('a'));
      await tester.pump();

      expect(changes.last, {'b'});
      expect(isChecked(tester, 'a'), isFalse);
      expect(isChecked(tester, 'b'), isTrue);
    });

    testWidgets('ignores taps when disabled', (tester) async {
      final formKey = GlobalKey<FormBuilderState>();
      final changes = <Set<String>>[];

      await tester.pumpApp(
        buildGroup(formKey, onChanged: changes.add, enabled: false),
      );
      await tester.tap(find.text('a'));
      await tester.pump();

      expect(changes, isEmpty);
      expect(isChecked(tester, 'a'), isFalse);
    });
  });
}
