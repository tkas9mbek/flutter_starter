extension DateTimeHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();

    return now.year == year && now.month == month && now.day == day;
  }

  DateTime get onlyDate => DateTime(year, month, day);
}
