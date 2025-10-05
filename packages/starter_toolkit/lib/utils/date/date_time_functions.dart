import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

DateTime get appEpoch => DateTime(2023, 1, 1);

DateTime get today => DateTime.now();

DateTime get futureMaxDate => today.add(const Duration(days: 365));

DateTime get monday {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final start = today.subtract(Duration(days: today.weekday - 1));

  return start;
}

DateTime get sunday {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final end = today.add(Duration(days: DateTime.daysPerWeek - today.weekday));

  return end;
}

String getShortenedDayByIndex(int day) {
  final date = monday.add(Duration(days: day));

  return getShortenedDayOfWeek(date);
}

String getShortenedDayOfWeek(DateTime date) {
  final formatter = DateFormat.E();

  return formatter.format(date).toUpperCase();
}

String getFullDayOfWeek(DateTime date) {
  final formatter = DateFormat.EEEE();
  return formatter.format(date);
}

String getFullDayByIndex(int day) {
  final date = monday.add(Duration(days: day));
  return getFullDayOfWeek(date);
}

String getCurrentMonth(BuildContext context, [String? explicitLocale]) {
  final locale = explicitLocale ?? Localizations.localeOf(context).languageCode;
  final formatter = DateFormat.MMMM(locale);
  final month = formatter.format(DateTime.now());

  if (month.isEmpty) {
    return month;
  }
  return month[0].toUpperCase() + month.substring(1);
}

String getFormattedTimeRange(DateTime start, DateTime end) {
  final formatter = DateFormat.Hm();
  return '${formatter.format(start)}-${formatter.format(end)}';
}

String getFormattedDateRange(String startDate, String endDate) {
  final formatter = DateFormat('dd.MM.yyyy');
  return '${formatter.format(DateTime.parse(startDate))} - '
      '${formatter.format(DateTime.parse(endDate))}';
}

String getFormattedMonth(
  DateTime date,
  BuildContext context, [
  String? explicitLocale,
]) {
  final locale = explicitLocale ?? Localizations.localeOf(context).languageCode;
  final formatter = DateFormat.MMMM(locale);
  final month = formatter.format(date);

  if (month.isEmpty) {
    return month;
  }
  return month[0].toLowerCase() + month.substring(1);
}

String getTextualDayMonthYear(DateTime date, BuildContext context) {
  return '${date.day} ${getFormattedMonth(date, context)} ${date.year}';
}

String getLocalizedDateLabel(BuildContext context, DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final dateWithoutTime = date.onlyDay;

  return switch (dateWithoutTime) {
    final d when d == today => ToolkitLocalizer.of(context).today,
    final d when d == yesterday => ToolkitLocalizer.of(context).yesterday,
    _ => DateFormat('d MMMM', Localizations.localeOf(context).languageCode)
        .format(dateWithoutTime),
  };
}
