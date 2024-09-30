import 'package:flutter/material.dart';

class CustomDateTimeRanges {
  static DateTimeRange get todayRange {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return DateTimeRange(start: today, end: today);
  }

  static DateTimeRange get weekRange {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = today.subtract(const Duration(days: 7));

    return DateTimeRange(start: start, end: today);
  }

  static DateTimeRange get monthRange {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = today.subtract(const Duration(days: 31));

    return DateTimeRange(start: start, end: today);
  }
}
