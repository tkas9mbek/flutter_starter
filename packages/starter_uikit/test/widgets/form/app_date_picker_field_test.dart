import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

import '../../support/pump_app.dart';

void main() {
  const fieldName = 'dueDate';
  // min == max pins the wheel, so confirming always yields this date.
  final pinned = DateTime(2024, 3, 15);

  Future<GlobalKey<FormBuilderState>> pumpField(
    WidgetTester tester, {
    List<DateTime?>? changes,
    bool enabled = true,
    bool required = false,
    bool hasClearButton = false,
  }) async {
    final formKey = GlobalKey<FormBuilderState>();

    await tester.pumpApp(
      FormBuilder(
        key: formKey,
        child: AppDatePickerField(
          name: fieldName,
          label: 'Due date',
          minDate: pinned,
          maxDate: pinned,
          enabled: enabled,
          required: required,
          hasClearButton: hasClearButton,
          onChanged: changes?.add,
        ),
      ),
    );

    return formKey;
  }

  Future<void> pickDate(WidgetTester tester) async {
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    await tester.tap(find.text(tester.uikitL10n.toSelect));
    await tester.pumpAndSettle();
  }

  group('AppDatePickerField', () {
    testWidgets('picking a date stores it, shows it and reports onChanged', (
      tester,
    ) async {
      final changes = <DateTime?>[];
      final formKey = await pumpField(tester, changes: changes);

      await pickDate(tester);

      expect(formKey.currentState!.fields[fieldName]!.value, pinned);
      expect(find.text('15.03.2024'), findsOneWidget);
      expect(changes, [pinned]);
    });

    testWidgets('going back from the sheet leaves the field empty', (
      tester,
    ) async {
      final changes = <DateTime?>[];
      final formKey = await pumpField(tester, changes: changes);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(DateTimePickerBottomSheet), findsOneWidget);
      expect(find.text('Due date'), findsWidgets);

      await tester.tap(find.text(tester.uikitL10n.back));
      await tester.pumpAndSettle();

      expect(formKey.currentState!.fields[fieldName]!.value, isNull);
      expect(changes, isEmpty);
    });

    testWidgets('the clear button empties the value and reports null', (
      tester,
    ) async {
      final changes = <DateTime?>[];
      final formKey = await pumpField(
        tester,
        changes: changes,
        hasClearButton: true,
      );

      await pickDate(tester);
      await tester.tap(
        find.byWidgetPredicate(
          (widget) => widget is SvgIcon && widget.icon == UiSvgIcons.closeMark,
        ),
      );
      await tester.pumpAndSettle();

      expect(formKey.currentState!.fields[fieldName]!.value, isNull);
      expect(changes, [pinned, null]);
    });

    testWidgets('a disabled field does not open the sheet', (tester) async {
      await pumpField(tester, enabled: false);

      await tester.tap(find.byType(TextField), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byType(DateTimePickerBottomSheet), findsNothing);
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
