import 'package:starter/features/task/data/task_service.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';

class RemoteTaskDataSource implements TaskDataSource {
  final TaskService _service;

  const RemoteTaskDataSource(this._service);

  @override
  Future<List<Task>> getTasks() => _service.getTasks();

  @override
  Future<List<Task>> getTasksByDate(DateTime date) =>
      _service.getTasksByDate(date.toIso8601String());

  @override
  Future<Task> createTask(TaskCreateRequest request) =>
      _service.createTask(request);

  @override
  Future<Task> updateTask(String id, TaskCreateRequest request) =>
      _service.updateTask(id, request);

  @override
  Future<void> deleteTask(String id) => _service.deleteTask(id);
}
