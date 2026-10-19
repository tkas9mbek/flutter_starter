import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

void main() {
  final moment = DateTime(2026, 3, 12, 15, 45, 30, 250);

  test('isToday and isTomorrow are relative to the current day', () {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    expect(now.isToday, isTrue);
    expect(now.isTomorrow, isFalse);
    expect(tomorrow.isTomorrow, isTrue);
    expect(tomorrow.isToday, isFalse);
  });

  test('isSameDay ignores the time of day and handles null', () {
    expect(moment.isSameDay(DateTime(2026, 3, 12, 0, 1)), isTrue);
    expect(moment.isSameDay(DateTime(2026, 3, 13)), isFalse);
    expect(moment.isSameDay(null), isFalse);
  });

  test('day boundaries strip or saturate the time of day', () {
    expect(moment.startOfDay, DateTime(2026, 3, 12));
    expect(moment.onlyDay, DateTime(2026, 3, 12));
    expect(moment.endOfDay, DateTime(2026, 3, 12, 23, 59, 59));
    expect(moment.startOfMonth, DateTime(2026, 3));
  });

  test('startOfWeek goes back to Monday and keeps the time of day', () {
    final start = moment.startOfWeek;

    expect(start.weekday, DateTime.monday);
    expect(start.isSameDay(DateTime(2026, 3, 9)), isTrue);
    expect(start.hour, 15);
    expect(DateTime(2026, 3, 9, 8).startOfWeek, DateTime(2026, 3, 9, 8));
  });

  test('onlyTime keeps the clock and drops the date', () {
    final time = moment.onlyTime;

    expect(
      (time.hour, time.minute, time.second, time.millisecond),
      (15, 45, 30, 250),
    );
    expect(time.onlyTime, time);
    expect(DateTime(2020, 1, 1, 15, 45, 30, 250).onlyTime, time);
  });
}
