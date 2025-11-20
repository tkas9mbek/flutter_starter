import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class RemoteTaskDataSource implements TaskDataSource {
  final ApiClient _client;

  const RemoteTaskDataSource(this._client);

  @override
  Future<List<Task>> getTasks() => _client.requestJsonList<Task>(
        method: HttpMethod.get,
        path: '/tasks',
        fromJson: Task.fromJson,
      );

  @override
  Future<List<Task>> getTasksByDate(DateTime date) =>
      _client.requestJsonList<Task>(
        method: HttpMethod.get,
        path: '/tasks/date/${date.toIso8601String()}',
        fromJson: Task.fromJson,
      );

  @override
  Future<Task> createTask(TaskCreateRequest request) =>
      _client.requestJson<Task>(
        method: HttpMethod.post,
        path: '/tasks',
        body: request.toJson(),
        fromJson: Task.fromJson,
      );

  @override
  Future<Task> updateTask(String id, TaskCreateRequest request) =>
      _client.requestJson<Task>(
        method: HttpMethod.put,
        path: '/tasks/$id',
        body: request.toJson(),
        fromJson: Task.fromJson,
      );

  @override
  Future<void> deleteTask(String id) => _client.requestVoid(
        method: HttpMethod.delete,
        path: '/tasks/$id',
      );
}
