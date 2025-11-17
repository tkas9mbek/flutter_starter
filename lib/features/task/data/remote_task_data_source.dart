import 'package:starter/features/task/data/task_api.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';

class RemoteTaskDataSource implements TaskDataSource {
  final TaskApi _api;

  const RemoteTaskDataSource(this._api);

  @override
  Future<List<Task>> getTasks() => _api.getTasks();

  @override
  Future<List<Task>> getTasksByDate(DateTime date) =>
      _api.getTasksByDate(date.toIso8601String());

  @override
  Future<Task> createTask(TaskCreateRequest request) =>
      _api.createTask(request);

  @override
  Future<Task> updateTask(String id, TaskCreateRequest request) =>
      _api.updateTask(id, request);

  @override
  Future<void> deleteTask(String id) => _api.deleteTask(id);

  @override
  Future<Task> toggleTaskCompletion(String id) => _api.toggleTaskCompletion(id);
}
