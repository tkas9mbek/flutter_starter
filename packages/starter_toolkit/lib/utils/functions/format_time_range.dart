import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';
import 'package:starter_toolkit/utils/functions/capitalize_first_letter.dart';

String formatDateRange(DateTime startDateTime, DateTime endDateTime) {
  final dateFormat = DateFormat('d MMMM');
  final startDate = dateFormat.format(startDateTime);
  final endDate = dateFormat.format(endDateTime);

  if (startDate == endDate) {
    return startDate;
  }

  return '$startDate–$endDate';
}

String formatTimeRange(DateTime startDateTime, DateTime endDateTime) {
  final timeFormat = DateFormat.Hm();
  final startTime = timeFormat.format(startDateTime);
  final endTime = timeFormat.format(endDateTime);

  return '$startTime–$endTime';
}

String formatTimeRangeAndDay(
  BuildContext context, {
  required DateTime startTime,
  required DateTime endTime,
  bool dateFirst = true,
}) {
  final dayFormat = startTime.isToday
      ? DateFormat(ToolkitLocalizer.of(context).today)
      : DateFormat('d MMMM');
  final day = dayFormat.format(startTime);

  if (dateFirst) {
    return '${capitalizeFirstLetter(day)}, ${formatTimeRange(startTime, endTime)}';
  }

  return '${formatTimeRange(startTime, endTime)}, $day';
}
