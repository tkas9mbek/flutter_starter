import 'dart:convert';
import 'dart:io';

import 'package:starter/features/task/model/task.dart';

class TaskMockModels {
  static dynamic _getJsonFromFile(String fileName) {
    const basePath = 'test/features/task/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();

    return json.decode(jsonString);
  }

  static final Map<String, dynamic> _rawTask1 =
      _getJsonFromFile('task1.json') as Map<String, dynamic>;
  static final Map<String, dynamic> _rawTask2 =
      _getJsonFromFile('task2.json') as Map<String, dynamic>;
  static final Map<String, dynamic> _rawTask3 =
      _getJsonFromFile('task3.json') as Map<String, dynamic>;

  static final Task _task1 = Task.fromJson(_rawTask1);
  static final Task _task2 = Task.fromJson(_rawTask2);
  static final Task _task3 = Task.fromJson(_rawTask3);

  static final List<Task> _allTasks = [_task1, _task2, _task3];
  static final List<Task> _tasksForDate1 = [_task1, _task2];
  static final List<Task> _tasksForDate3 = [_task3];

  static Map<String, dynamic> get rawTask1 =>
      Map<String, dynamic>.from(_rawTask1);

  static Map<String, dynamic> get rawTask2 =>
      Map<String, dynamic>.from(_rawTask2);

  static Map<String, dynamic> get rawTask3 =>
      Map<String, dynamic>.from(_rawTask3);

  static Task get task1 => _task1;

  static Task get task2 => _task2;

  static Task get task3 => _task3;

  static List<Task> get allTasks => List<Task>.unmodifiable(_allTasks);

  static List<Task> get tasksForDate1 =>
      List<Task>.unmodifiable(_tasksForDate1);

  static List<Task> get tasksForDate3 =>
      List<Task>.unmodifiable(_tasksForDate3);
}
