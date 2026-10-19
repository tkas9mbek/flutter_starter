import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/dialogs/date_range_picker_bottom_sheet.dart';

import '../../support/pump_app.dart';
import 'show_sheet.dart';

void main() {
  final march15 = DateTime(2024, 3, 15);

  DateRangePickerBottomSheet buildSheet() => DateRangePickerBottomSheet(
    title: 'Period',
    backText: 'Back',
    confirmText: 'Apply',
    initialDate: march15,
  );

  group('DateRangePickerBottomSheet', () {
    testWidgets('picks the start, then an end, and pops with the range', (
      tester,
    ) async {
      final result = await tester.showSheet<(DateTime, DateTime)>(buildSheet());
      final next = tester.uikitL10n.next;

      expect(find.text(next), findsOneWidget);
      expect(find.text('Apply'), findsNothing);

      await tester.tap(find.text(next));
      await tester.pumpAndSettle();

      expect(find.text('Apply'), findsOneWidget);
      expect(result(), isNull);

      await tester.drag(find.text('15'), const Offset(0, -35 * 3));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(result(), (march15, DateTime(2024, 3, 18)));
    });

    testWidgets('the end step cannot go before the chosen start', (
      tester,
    ) async {
      final result = await tester.showSheet<(DateTime, DateTime)>(buildSheet());

      await tester.tap(find.text(tester.uikitL10n.next));
      await tester.pumpAndSettle();

      expect(
        tester.widget<Text>(find.text('14')).style?.color,
        AppTheme.light().textPlaceholder,
      );

      await tester.drag(find.text('15'), const Offset(0, 35 * 2));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(result(), (march15, march15));
    });

    testWidgets('back pops with null', (tester) async {
      final result = await tester.showSheet<(DateTime, DateTime)>(buildSheet());

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      expect(find.byType(DateRangePickerBottomSheet), findsNothing);
      expect(result(), isNull);
    });
  });
}
