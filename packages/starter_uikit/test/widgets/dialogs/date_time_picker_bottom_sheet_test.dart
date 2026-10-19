import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';

import 'show_sheet.dart';

void main() {
  final march15 = DateTime(2024, 3, 15);

  DateTimePickerBottomSheet buildSheet({
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    void Function(BuildContext, DateTime)? onDateSelected,
  }) => DateTimePickerBottomSheet(
    title: 'Due date',
    backText: 'Back',
    confirmText: 'Select',
    initialDate: initialDate,
    minDate: minDate,
    maxDate: maxDate,
    onDateSelected: onDateSelected,
  );

  group('DateTimePickerBottomSheet', () {
    testWidgets('confirm pops with the initial date when nothing is moved', (
      tester,
    ) async {
      final result = await tester.showSheet<DateTime>(
        buildSheet(initialDate: march15),
      );

      expect(find.text('Due date'), findsOneWidget);

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(result(), march15);
    });

    testWidgets('confirm pops with the date scrolled to on the wheel', (
      tester,
    ) async {
      final result = await tester.showSheet<DateTime>(
        buildSheet(initialDate: march15),
      );

      await tester.drag(find.text('15'), const Offset(0, -35));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(result(), DateTime(2024, 3, 16));
    });

    testWidgets('back pops with null', (tester) async {
      final result = await tester.showSheet<DateTime>(
        buildSheet(initialDate: march15),
      );

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      expect(find.byType(DateTimePickerBottomSheet), findsNothing);
      expect(result(), isNull);
    });

    testWidgets('clamps an initial date outside the range to the bound', (
      tester,
    ) async {
      final result = await tester.showSheet<DateTime>(
        buildSheet(
          initialDate: DateTime(2020),
          minDate: march15,
          maxDate: DateTime(2024, 12, 31),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(result(), march15);
    });

    testWidgets('onDateSelected receives the date instead of popping', (
      tester,
    ) async {
      final selected = <DateTime>[];

      await tester.showSheet<DateTime>(
        buildSheet(
          initialDate: march15,
          onDateSelected: (_, date) => selected.add(date),
        ),
      );
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(selected, [march15]);
      expect(find.byType(DateTimePickerBottomSheet), findsOneWidget);
    });
  });
}
