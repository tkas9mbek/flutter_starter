import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';

class MockTaskDataSource implements TaskDataSource {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Morning Meeting',
      description: 'Team standup meeting',
      date: DateTime.now(),
      startTime: DateTime.now().copyWith(hour: 9, minute: 0),
      endTime: DateTime.now().copyWith(hour: 10, minute: 0),
      isCompleted: false,
    ),
    Task(
      id: '2',
      title: 'Code Review',
      description: 'Review pull requests',
      date: DateTime.now(),
      startTime: DateTime.now().copyWith(hour: 14, minute: 0),
      endTime: DateTime.now().copyWith(hour: 15, minute: 30),
      isCompleted: true,
    ),
    Task(
      id: '3',
      title: 'Project Planning',
      description: 'Plan next sprint features',
      date: DateTime.now().add(const Duration(days: 1)),
      startTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 10, minute: 0),
      endTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 12, minute: 0),
      isCompleted: false,
    ),
    Task(
      id: '4',
      title: 'Documentation',
      description: 'Update project documentation',
      date: DateTime.now().add(const Duration(days: 1)),
      startTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 15, minute: 0),
      endTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 17, minute: 0),
      isCompleted: false,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return List.from(_tasks);
  }

  @override
  Future<List<Task>> getTasksByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _tasks.where((task) {
      return task.date.year == date.year &&
          task.date.month == date.month &&
          task.date.day == date.day;
    }).toList();
  }

  @override
  Future<Task> createTask(TaskCreateRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: request.title,
      description: request.description,
      date: request.date,
      startTime: request.startTime,
      endTime: request.endTime,
      isCompleted: false,
    );

    _tasks.add(task);

    return task;
  }

  @override
  Future<Task> updateTask(String id, TaskCreateRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _tasks.indexWhere((task) => task.id == id);

    if (index == -1) {
      throw Exception('Task not found');
    }

    final task = Task(
      id: id,
      title: request.title,
      description: request.description,
      date: request.date,
      startTime: request.startTime,
      endTime: request.endTime,
      isCompleted: _tasks[index].isCompleted,
    );

    _tasks[index] = task;

    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _tasks.removeWhere((task) => task.id == id);
  }

  @override
  Future<Task> toggleTaskCompletion(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _tasks.indexWhere((task) => task.id == id);

    if (index == -1) {
      throw Exception('Task not found');
    }

    final task = _tasks[index];
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      startTime: task.startTime,
      endTime: task.endTime,
      isCompleted: !task.isCompleted,
    );

    _tasks[index] = updatedTask;

    return updatedTask;
  }
}
