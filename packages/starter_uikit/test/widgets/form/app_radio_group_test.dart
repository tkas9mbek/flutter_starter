import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/app_radio_group.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';

import '../../support/pump_app.dart';

void main() {
  bool isSelected(WidgetTester tester, String label) => tester
      .widget<AppCard>(
        find.ancestor(of: find.text(label), matching: find.byType(AppCard)),
      )
      .selected;

  group('AppRadioGroup', () {
    testWidgets('tapping a row selects it and reports onChanged', (
      tester,
    ) async {
      final formKey = GlobalKey<FormBuilderState>();
      final changes = <String?>[];

      await tester.pumpApp(
        FormBuilder(
          key: formKey,
          child: AppRadioGroup<String>(
            name: 'choice',
            options: const ['a', 'b'],
            selected: 'a',
            onChanged: changes.add,
          ),
        ),
      );

      expect(isSelected(tester, 'a'), isTrue);

      await tester.tap(find.text('b'));
      await tester.pump();

      expect(changes, ['b']);
      expect(formKey.currentState!.fields['choice']!.value, 'b');
      expect(isSelected(tester, 'a'), isFalse);
      expect(isSelected(tester, 'b'), isTrue);
    });
  });
}
