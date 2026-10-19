import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/task/ui/create/model/task_create_form.dart';

void main() {
  group('fromForm', () {
    test('reads every field by its form key', () {
      final date = DateTime(2025, 1, 20);

      final form = TaskCreateForm.fromForm({
        TaskCreateForm.titleField: 'Title',
        TaskCreateForm.descriptionField: 'Description',
        TaskCreateForm.dateField: date,
        TaskCreateForm.startTimeField: const TimeOfDay(hour: 9, minute: 0),
        TaskCreateForm.endTimeField: const TimeOfDay(hour: 10, minute: 30),
      });

      expect(form.title, 'Title');
      expect(form.description, 'Description');
      expect(form.date, date);
      expect(form.startTime, const TimeOfDay(hour: 9, minute: 0));
      expect(form.endTime, const TimeOfDay(hour: 10, minute: 30));
    });

    test('defaults a missing description to an empty string', () {
      final form = TaskCreateForm.fromForm({
        TaskCreateForm.titleField: 'Title',
        TaskCreateForm.dateField: DateTime(2025, 1, 20),
        TaskCreateForm.startTimeField: const TimeOfDay(hour: 9, minute: 0),
        TaskCreateForm.endTimeField: const TimeOfDay(hour: 10, minute: 0),
      });

      expect(form.description, isEmpty);
    });
  });

  group('startDateTime / endDateTime', () {
    test('place the picked times on the picked day', () {
      final form = TaskCreateForm(
        title: 'Title',
        description: '',
        date: DateTime(2025, 1, 20),
        startTime: const TimeOfDay(hour: 9, minute: 15),
        endTime: const TimeOfDay(hour: 17, minute: 45),
      );

      expect(form.startDateTime, DateTime(2025, 1, 20, 9, 15));
      expect(form.endDateTime, DateTime(2025, 1, 20, 17, 45));
    });

    test('ignore any time-of-day carried by the picked date', () {
      final form = TaskCreateForm(
        title: 'Title',
        description: '',
        date: DateTime(2025, 1, 20, 23, 59, 30),
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 9, minute: 0),
      );

      expect(form.startDateTime, DateTime(2025, 1, 20, 8, 0));
      expect(form.endDateTime, DateTime(2025, 1, 20, 9, 0));
    });
  });
}
