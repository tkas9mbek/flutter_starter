import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:starter_toolkit/utils/functions/format_time_range.dart';

import '../../support/pump_localized.dart';

void main() {
  setUpAll(() => initializeDateFormatting('ru'));

  test('formatDateRange collapses a single day', () {
    expect(
      formatDateRange(DateTime(2026, 3, 8, 9), DateTime(2026, 3, 8, 18)),
      '8 March',
    );
    expect(
      formatDateRange(DateTime(2026, 3, 8), DateTime(2026, 3, 10)),
      '8 March–10 March',
    );
  });

  test(
    'formatTimeRange joins zero-padded 24h times',
    () => expect(
      formatTimeRange(DateTime(2026, 1, 1, 9, 5), DateTime(2026, 1, 1, 21, 30)),
      '09:05–21:30',
    ),
  );

  group('formatTimeRangeAndDay', () {
    late BuildContext context;
    final past = DateTime(2020, 3, 8, 9);
    final pastEnd = DateTime(2020, 3, 8, 10, 30);

    testWidgets('prefixes the date for a day other than today', (tester) async {
      context = await tester.pumpLocalizedContext();

      expect(
        formatTimeRangeAndDay(context, startTime: past, endTime: pastEnd),
        '8 March, 09:00–10:30',
      );
      expect(
        formatTimeRangeAndDay(
          context,
          startTime: past,
          endTime: pastEnd,
          dateFirst: false,
        ),
        '09:00–10:30, 8 March',
      );
    });

    testWidgets('uses the localized today label', (tester) async {
      context = await tester.pumpLocalizedContext(locale: const Locale('ru'));
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day, 9);

      expect(
        formatTimeRangeAndDay(
          context,
          startTime: start,
          endTime: start.add(const Duration(hours: 1)),
        ),
        'Сегодня, 09:00–10:00',
      );
    });
  });
}
