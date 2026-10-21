import 'dart:async';

import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class TaskRepository {
  TaskRepository(this._executor, this._dataSource);

  final RepositoryExecutor _executor;
  final TaskDataSource _dataSource;

  final _changes = StreamController<void>.broadcast();

  /// Fires after a task is created, updated or deleted, so every screen that
  /// shows tasks can reload. Needs a single shared repository instance.
  Stream<void> get changes => _changes.stream;

  Future<List<Task>> getTasks() => _executor.execute(_dataSource.getTasks);

  Future<List<Task>> getTasksByDate(DateTime date) =>
      _executor.execute(() => _dataSource.getTasksByDate(date));

  Future<PaginatedListItems<Task>> searchTasks(
    String query, {
    required int page,
  }) => _executor.execute(() => _dataSource.searchTasks(query, page: page));

  Future<Task> createTask(TaskCreateRequest request) async {
    final task = await _executor.execute(() => _dataSource.createTask(request));
    _notifyChanged();

    return task;
  }

  Future<Task> updateTask(String id, TaskCreateRequest request) async {
    final task = await _executor.execute(
      () => _dataSource.updateTask(id, request),
    );
    _notifyChanged();

    return task;
  }

  Future<void> deleteTask(String id) async {
    await _executor.execute(() => _dataSource.deleteTask(id));
    _notifyChanged();
  }

  Future<void> dispose() => _changes.close();

  void _notifyChanged() {
    if (!_changes.isClosed) {
      _changes.add(null);
    }
  }
}
