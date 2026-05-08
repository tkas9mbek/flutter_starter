import 'package:flutter/material.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

/// Formats [duration] as a localized "Xh Ym" string.
///
/// Drops the hours component when [duration] is shorter than one hour.
String formatDuration(BuildContext context, Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);

  if (hours == 0) {
    return ToolkitLocalizer.of(context).durationInMinutes(minutes);
  }

  return ToolkitLocalizer.of(context).durationInHoursMinutes(hours, minutes);
}
