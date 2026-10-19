import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:starter_toolkit/utils/date/date_time_functions.dart';

import '../../support/pump_localized.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ru');
    await initializeDateFormatting('en');
  });

  test('monday and sunday bound the current week at midnight', () {
    final now = DateTime.now();

    expect(monday.weekday, DateTime.monday);
    expect(sunday.weekday, DateTime.sunday);
    expect(monday.hour + monday.minute, 0);
    expect(sunday.difference(monday).inDays, 6);
    expect(now.isBefore(monday), isFalse);
    expect(now.isBefore(sunday.add(const Duration(days: 1))), isTrue);
  });

  test(
    'day-of-week names start the index at Monday',
    () => Intl.withLocale('en', () {
      expect(getShortenedDayByIndex(0), 'MON');
      expect(getShortenedDayByIndex(6), 'SUN');
      expect(getFullDayByIndex(0), 'Monday');
      expect(getFullDayOfWeek(DateTime(2026, 3, 14)), 'Saturday');
    }),
  );

  test('time and date ranges use fixed numeric formats', () {
    expect(
      getFormattedTimeRange(
        DateTime(2026, 1, 1, 9, 5),
        DateTime(2026, 1, 1, 18),
      ),
      '09:05-18:00',
    );
    expect(
      getFormattedDateRange('2026-01-05', '2026-02-10T12:00:00'),
      '05.01.2026 - 10.02.2026',
    );
  });

  group('locale-aware labels', () {
    late BuildContext context;

    Future<void> pumpWithLocale(
      WidgetTester tester,
      String languageCode,
    ) async => context = await tester.pumpLocalizedContext(
      locale: Locale(languageCode),
    );

    testWidgets('getLocalizedDateLabel says today and yesterday', (
      tester,
    ) async {
      await pumpWithLocale(tester, 'en');
      final now = DateTime.now();

      expect(getLocalizedDateLabel(context, now), 'Today');
      expect(
        getLocalizedDateLabel(context, now.subtract(const Duration(days: 1))),
        'Yesterday',
      );
    });

    testWidgets('getLocalizedDateLabel falls back to day and month', (
      tester,
    ) async {
      await pumpWithLocale(tester, 'ru');

      expect(
        getLocalizedDateLabel(context, DateTime(2020, 3, 8, 10)),
        '8 марта',
      );
    });

    testWidgets('month helpers follow the context locale', (tester) async {
      await pumpWithLocale(tester, 'ru');

      expect(getFormattedMonth(DateTime(2026, 1, 5), context), 'январь');
      expect(getFormattedMonth(DateTime(2026, 1, 5), context, 'en'), 'january');

      final currentMonth = getCurrentMonth(context, 'en');
      expect(currentMonth, DateFormat.MMMM('en').format(DateTime.now()));
    });
  });
}
