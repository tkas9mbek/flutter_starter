import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/task/data/mock_task_data_source.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class _ThrowingTaskDataSource implements TaskDataSource {
  const _ThrowingTaskDataSource();

  @override
  Future<List<Task>> getTasks() async => throw const NoInternetException();

  @override
  Future<List<Task>> getTasksByDate(DateTime date) async =>
      throw const NoInternetException();

  @override
  Future<PaginatedListItems<Task>> searchTasks(
    String query, {
    required int page,
  }) async => throw const NoInternetException();

  @override
  Future<Task> createTask(TaskCreateRequest request) async =>
      throw const NoInternetException();

  @override
  Future<Task> updateTask(String id, TaskCreateRequest request) async =>
      throw const NoInternetException();

  @override
  Future<void> deleteTask(String id) async => throw const NoInternetException();
}

void main() {
  TasksListBloc buildBloc(TaskDataSource dataSource) => TasksListBloc(
    TaskRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      dataSource,
    ),
  );

  Future<void> settle(TasksListBloc bloc) => bloc.stream.firstWhere(
    (state) => state is SuccessTasksListState || state is FailureTasksListState,
  );

  test('task-list flow reaches a grouped success state', () async {
    final bloc = buildBloc(MockTaskDataSource());

    bloc.add(const TasksListEvent.requested());
    await settle(bloc);

    expect(bloc.state, isA<SuccessTasksListState>());
  });

  test('task-list flow surfaces a failure end-to-end', () async {
    final bloc = buildBloc(const _ThrowingTaskDataSource());

    bloc.add(const TasksListEvent.requested());
    await settle(bloc);

    expect(bloc.state, isA<FailureTasksListState>());
  });
}
