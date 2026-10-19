import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/dialogs/app_cupertino_date_picker.dart';

import '../../support/pump_app.dart';

void main() {
  final theme = AppTheme.light();
  final minDate = DateTime(2024, 3, 10);
  final maxDate = DateTime(2024, 3, 20);

  Widget buildPicker(DateTime selected, List<DateTime> changes) => SizedBox(
    height: 190,
    child: AppCupertinoDatePicker(
      onSelectedItemChanged: changes.add,
      minDate: minDate,
      maxDate: maxDate,
      selectedDate: selected,
    ),
  );

  Color? colorOf(WidgetTester tester, String text) =>
      tester.widget<Text>(find.text(text)).style?.color;

  group('AppCupertinoDatePicker', () {
    testWidgets('styles selected, in-range and out-of-range rows apart', (
      tester,
    ) async {
      await tester.pumpApp(buildPicker(DateTime(2024, 3, 11), []));

      expect(colorOf(tester, '11'), theme.textPrimary);
      expect(colorOf(tester, '12'), theme.textSecondary);
      expect(colorOf(tester, '9'), theme.textPlaceholder);
      expect(
        colorOf(tester, tester.uikitL10n.monthApril),
        theme.textPlaceholder,
      );
    });

    testWidgets('reports the date scrolled to inside the range', (
      tester,
    ) async {
      final changes = <DateTime>[];

      await tester.pumpApp(buildPicker(DateTime(2024, 3, 15), changes));
      await tester.drag(find.text('15'), const Offset(0, -35));
      await tester.pumpAndSettle();

      expect(changes.last, DateTime(2024, 3, 16));
    });

    testWidgets('snaps back from a disabled row without reporting it', (
      tester,
    ) async {
      final changes = <DateTime>[];

      await tester.pumpApp(buildPicker(maxDate, changes));
      await tester.drag(find.text('20'), const Offset(0, -35));
      await tester.pumpAndSettle();

      expect(changes.where((date) => date.isAfter(maxDate)), isEmpty);
      expect(colorOf(tester, '20'), theme.textPrimary);
      expect(colorOf(tester, '21'), theme.textPlaceholder);
    });
  });
}
