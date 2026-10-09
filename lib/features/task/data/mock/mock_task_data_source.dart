import 'package:starter/features/task/data/mock/mock_task_scenarios.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';

class MockTaskDataSource implements TaskDataSource {
  MockTaskDataSource(this._network) : _tasks = MockTaskScenarios.seed();

  final MockNetworkBehavior _network;
  final List<Task> _tasks;

  @override
  Future<List<Task>> getTasks() async {
    await _network.simulate();

    return List.from(_tasks);
  }

  @override
  Future<List<Task>> getTasksByDate(DateTime date) async {
    await _network.simulate();

    return _tasks
        .where(
          (task) =>
              task.date.year == date.year &&
              task.date.month == date.month &&
              task.date.day == date.day,
        )
        .toList();
  }

  @override
  Future<PaginatedListItems<Task>> searchTasks(
    String query, {
    required int page,
  }) async {
    await _network.simulate();

    const pageSize = MockTaskScenarios.searchPageSize;
    final normalized = query.toLowerCase();
    final matches = _tasks
        .where(
          (task) =>
              task.title.toLowerCase().contains(normalized) ||
              task.description.toLowerCase().contains(normalized),
        )
        .toList();
    final start = (page - 1) * pageSize;
    final elements = start >= matches.length
        ? <Task>[]
        : matches.skip(start).take(pageSize).toList();

    return PaginatedListItems(
      pageLimit: pageSize,
      countItems: matches.length,
      countPages: (matches.length / pageSize).ceil(),
      elements: elements,
    );
  }

  @override
  Future<Task> createTask(TaskCreateRequest request) async {
    await _network.simulate();

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
    await _network.simulate();

    final index = _tasks.indexWhere((task) => task.id == id);

    if (index == -1) {
      throw MockTaskScenarios.taskNotFound();
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
    await _network.simulate();
    _tasks.removeWhere((task) => task.id == id);
  }
}
