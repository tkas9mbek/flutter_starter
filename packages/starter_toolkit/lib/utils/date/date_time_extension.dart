extension DateTimeHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();

    return now.year == year && now.month == month && now.day == day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    return tomorrow.year == year &&
        tomorrow.month == month &&
        tomorrow.day == day;
  }

  bool isSameDay(DateTime? other) => onlyDay == other?.onlyDay;

  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get onlyTime =>
      DateTime(0, 0, 0, hour, minute, second, millisecond, microsecond);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 0, 0);

  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get startOfWeek => subtract(Duration(days: weekday - 1));

  DateTime get onlyDay => DateTime(year, month, day);
}
