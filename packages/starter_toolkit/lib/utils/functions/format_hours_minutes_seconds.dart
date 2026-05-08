/// Formats [secondsRemaining] as a zero-padded `HH:MM:SS` (or shorter) string.
///
/// Toggle which components appear via [showHours], [showMinutes], and
/// [showSeconds]. Hours are always shown once [secondsRemaining] reaches
/// one hour, regardless of [showHours].
String formatHoursMinutesSeconds(
  int secondsRemaining, {
  bool showSeconds = true,
  bool showMinutes = true,
  bool showHours = false,
}) {
  final minutesTotal = secondsRemaining ~/ 60;
  final hours = minutesTotal ~/ 60;
  final minutes = minutesTotal % 60;
  final seconds = secondsRemaining % 60;

  var result = '';

  if (hours > 0 || showHours) {
    result += '${hours.toString().padLeft(2, '0')}:';
  }

  if (showMinutes) {
    result += minutes.toString().padLeft(2, '0');

    if (showSeconds) {
      result += ':';
    }
  }

  if (showSeconds) {
    result += seconds.toString().padLeft(2, '0');
  }

  return result;
}
