import 'dart:convert';
import 'dart:io';

import 'package:starter/features/task/model/task.dart';

class TaskMockModels {
  static dynamic getJsonFromFile(String fileName) {
    const basePath = 'test/features/task/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();

    return json.decode(jsonString);
  }

  static Map<String, dynamic> get rawTask1 =>
      getJsonFromFile('task1.json') as Map<String, dynamic>;

  static Map<String, dynamic> get rawTask2 =>
      getJsonFromFile('task2.json') as Map<String, dynamic>;

  static Map<String, dynamic> get rawTask3 =>
      getJsonFromFile('task3.json') as Map<String, dynamic>;

  static Task get task1 => Task.fromJson(rawTask1);

  static Task get task2 => Task.fromJson(rawTask2);

  static Task get task3 => Task.fromJson(rawTask3);

  static List<Task> get allTasks => [task1, task2, task3];

  static List<Task> get tasksForDate1 => [task1, task2];

  static List<Task> get tasksForDate3 => [task3];
}
