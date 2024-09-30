import 'package:flutter/cupertino.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/utils/date/date_time_extension.dart';
import 'package:flutter_starter/utils/functions/capitalize_first_letter.dart';
import 'package:intl/intl.dart';

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
      ? DateFormat(S.of(context).today)
      : DateFormat('d MMMM');
  final day = dayFormat.format(startTime);

  if (dateFirst) {
    return '${capitalizeFirstLetter(day)}, ${formatTimeRange(startTime, endTime)}';
  }

  return '${formatTimeRange(startTime, endTime)}, $day';
}
