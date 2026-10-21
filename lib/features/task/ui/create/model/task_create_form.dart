import 'package:flutter/material.dart';

class TaskCreateForm {
  const TaskCreateForm({
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory TaskCreateForm.fromForm(Map<String, dynamic> form) => TaskCreateForm(
    title: form[titleField] as String,
    description: (form[descriptionField] as String?) ?? '',
    date: form[dateField] as DateTime,
    startTime: form[startTimeField] as TimeOfDay,
    endTime: form[endTimeField] as TimeOfDay,
  );

  static const String titleField = 'title';
  static const String descriptionField = 'description';
  static const String dateField = 'date';
  static const String startTimeField = 'startTime';
  static const String endTimeField = 'endTime';

  /// An unset time passes: the required check reports it, not this rule.
  static bool endsAfterStart(TimeOfDay? start, TimeOfDay? end) =>
      start == null ||
      end == null ||
      end.hour * 60 + end.minute > start.hour * 60 + start.minute;

  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  DateTime get startDateTime => _onDate(startTime);

  DateTime get endDateTime => _onDate(endTime);

  DateTime _onDate(TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
