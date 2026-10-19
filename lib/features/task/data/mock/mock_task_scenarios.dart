import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

abstract final class MockTaskScenarios {
  static const searchPageSize = 10;

  static List<Task> seed() {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    return [
      Task(
        id: '1',
        title: 'Morning Meeting',
        description: 'Team standup meeting',
        date: today,
        startTime: today.copyWith(hour: 9, minute: 0),
        endTime: today.copyWith(hour: 10, minute: 0),
        isCompleted: false,
      ),
      Task(
        id: '2',
        title: 'Code Review',
        description: 'Review pull requests',
        date: today,
        startTime: today.copyWith(hour: 14, minute: 0),
        endTime: today.copyWith(hour: 15, minute: 30),
        isCompleted: true,
      ),
      Task(
        id: '3',
        title: 'Project Planning',
        description: 'Plan next sprint features',
        date: tomorrow,
        startTime: tomorrow.copyWith(hour: 10, minute: 0),
        endTime: tomorrow.copyWith(hour: 12, minute: 0),
        isCompleted: false,
      ),
      Task(
        id: '4',
        title: 'Documentation',
        description: 'Update project documentation',
        date: tomorrow,
        startTime: tomorrow.copyWith(hour: 15, minute: 0),
        endTime: tomorrow.copyWith(hour: 17, minute: 0),
        isCompleted: false,
      ),
    ];
  }

  /// Updating an id that is not in the list is refused.
  static AppException taskNotFound() =>
      const ServerException(statusCode: 404, message: 'Task not found');
}
