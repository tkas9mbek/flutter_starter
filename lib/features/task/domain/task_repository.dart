import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class TaskRepository {
  final RepositoryExecutor _executor;
  final TaskDataSource _dataSource;

  const TaskRepository(
    this._executor,
    this._dataSource,
  );

  Future<List<Task>> getTasks() => _executor.execute(_dataSource.getTasks);

  Future<List<Task>> getTasksByDate(DateTime date) =>
      _executor.execute(() => _dataSource.getTasksByDate(date));

  Future<Task> createTask(TaskCreateRequest request) =>
      _executor.execute(() => _dataSource.createTask(request));

  Future<Task> updateTask(String id, TaskCreateRequest request) =>
      _executor.execute(() => _dataSource.updateTask(id, request));

  Future<void> deleteTask(String id) =>
      _executor.execute(() => _dataSource.deleteTask(id));
}
