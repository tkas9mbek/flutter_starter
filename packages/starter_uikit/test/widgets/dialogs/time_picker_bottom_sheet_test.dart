import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/dialogs/time_picker_bottom_sheet.dart';

import 'show_sheet.dart';

void main() {
  const nineThirty = TimeOfDay(hour: 9, minute: 30);

  TimePickerBottomSheet buildSheet() => const TimePickerBottomSheet(
    title: 'Reminder',
    backText: 'Back',
    confirmText: 'Select',
    initialTime: nineThirty,
  );

  group('TimePickerBottomSheet', () {
    testWidgets('confirm pops with the initial time when nothing is moved', (
      tester,
    ) async {
      final result = await tester.showSheet<TimeOfDay>(buildSheet());

      expect(find.text('Reminder'), findsOneWidget);

      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(result(), nineThirty);
    });

    testWidgets('confirm pops with the minute scrolled to on the wheel', (
      tester,
    ) async {
      final result = await tester.showSheet<TimeOfDay>(buildSheet());

      await tester.drag(find.text('30'), const Offset(0, -32));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();

      expect(result(), const TimeOfDay(hour: 9, minute: 31));
    });

    testWidgets('back pops with null', (tester) async {
      final result = await tester.showSheet<TimeOfDay>(buildSheet());

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      expect(find.byType(TimePickerBottomSheet), findsNothing);
      expect(result(), isNull);
    });
  });
}
