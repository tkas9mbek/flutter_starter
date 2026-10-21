import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/task/data/mock/mock_task_data_source.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/create/bloc/task_creation_bloc.dart';
import 'package:starter/features/task/ui/create/model/task_create_form.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';

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

final _form = TaskCreateForm(
  title: 'Release notes',
  description: 'Write the 3.1.0 notes',
  date: DateTime(2030, 5, 10),
  startTime: const TimeOfDay(hour: 11, minute: 0),
  endTime: const TimeOfDay(hour: 12, minute: 30),
);

TaskCreateRequest _request(String title) => TaskCreateRequest(
  title: title,
  description: 'Description',
  date: DateTime(2030, 5, 10),
  startTime: DateTime(2030, 5, 10, 9),
  endTime: DateTime(2030, 5, 10, 10),
);

void main() {
  TaskDataSource mockDataSource() =>
      MockTaskDataSource(const MockNetworkBehavior.instant());

  TaskRepository buildRepository(TaskDataSource dataSource) => TaskRepository(
    const RawRepositoryExecutor().withErrorHandling(),
    dataSource,
  );

  B track<B extends BlocBase<Object?>>(B bloc) {
    addTearDown(bloc.close);

    return bloc;
  }

  group('task-list flow', () {
    TasksListBloc buildBloc(TaskDataSource dataSource) =>
        track(TasksListBloc(buildRepository(dataSource)));

    Future<void> settle(TasksListBloc bloc) => bloc.stream.firstWhere(
      (state) =>
          state is SuccessTasksListState || state is FailureTasksListState,
    );

    test('reaches a grouped success state', () async {
      final bloc = buildBloc(mockDataSource());

      bloc.add(const TasksListEvent.requested());
      await settle(bloc);

      expect(bloc.state, isA<SuccessTasksListState>());
    });

    test('surfaces a failure end-to-end', () async {
      final bloc = buildBloc(const _ThrowingTaskDataSource());

      bloc.add(const TasksListEvent.requested());
      await settle(bloc);

      expect(bloc.state, isA<FailureTasksListState>());
    });
  });

  group('calendar flow', () {
    CalendarBloc buildBloc(TaskDataSource dataSource) =>
        track(CalendarBloc(buildRepository(dataSource)));

    Future<void> settle(CalendarBloc bloc) => bloc.stream.firstWhere(
      (state) =>
          state.status is SuccessCalendarStatus ||
          state.status is FailureCalendarStatus,
    );

    test('returns only the tasks on the selected day', () async {
      final bloc = buildBloc(mockDataSource());
      final tomorrow = DateTime.now().add(const Duration(days: 1));

      bloc.add(CalendarEvent.dateSelected(tomorrow));
      await settle(bloc);

      final status = bloc.state.status as SuccessCalendarStatus;
      expect(status.tasks, isNotEmpty);
      expect(
        status.tasks.map((task) => task.date.day),
        everyElement(tomorrow.day),
      );
    });

    test('surfaces a failure end-to-end', () async {
      final bloc = buildBloc(const _ThrowingTaskDataSource());

      bloc.add(CalendarEvent.dateSelected(DateTime.now()));
      await settle(bloc);

      expect(bloc.state.status, isA<FailureCalendarStatus>());
    });
  });

  group('create flow', () {
    Future<void> settle(TaskCreationBloc bloc) => bloc.stream.firstWhere(
      (state) =>
          state is SuccessTaskCreationState ||
          state is FailureTaskCreationState,
    );

    test('creates the task and it shows up on its calendar day', () async {
      final dataSource = mockDataSource();
      final bloc = track(TaskCreationBloc(buildRepository(dataSource)));

      bloc.add(TaskCreationEvent.submitted(_form));
      await settle(bloc);

      final created = (bloc.state as SuccessTaskCreationState).task;
      expect(created.title, _form.title);
      expect(created.startTime, DateTime(2030, 5, 10, 11, 0));
      expect(created.endTime, DateTime(2030, 5, 10, 12, 30));
      expect(created.isCompleted, isFalse);

      final calendar = track(CalendarBloc(buildRepository(dataSource)));
      calendar.add(CalendarEvent.dateSelected(_form.date));
      final calendarState = await calendar.stream.firstWhere(
        (state) => state.status is SuccessCalendarStatus,
      );
      expect((calendarState.status as SuccessCalendarStatus).tasks, [created]);
    });

    test('surfaces a failure end-to-end', () async {
      final bloc = track(
        TaskCreationBloc(buildRepository(const _ThrowingTaskDataSource())),
      );

      bloc.add(TaskCreationEvent.submitted(_form));
      await settle(bloc);

      expect(bloc.state, isA<FailureTaskCreationState>());
    });
  });

  // No BLoC dispatches updates yet, so the update path runs repository → twin.
  group('update flow', () {
    test('replaces the task and keeps its completion flag', () async {
      final repository = buildRepository(mockDataSource());
      final completed = (await repository.getTasks()).firstWhere(
        (task) => task.isCompleted,
      );

      final updated = await repository.updateTask(
        completed.id,
        _request('Renamed'),
      );

      expect(updated.id, completed.id);
      expect(updated.title, 'Renamed');
      expect(updated.isCompleted, isTrue);
      expect(await repository.getTasks(), contains(updated));
    });

    test('surfaces the backend not-found error for an unknown id', () {
      final repository = buildRepository(mockDataSource());

      expect(
        repository.updateTask('missing-id', _request('Renamed')),
        throwsA(
          isA<ServerException>().having(
            (exception) => exception.statusCode,
            'statusCode',
            404,
          ),
        ),
      );
    });

    test('surfaces a failure end-to-end', () {
      final repository = buildRepository(const _ThrowingTaskDataSource());

      expect(
        repository.updateTask('1', _request('Renamed')),
        throwsA(isA<NoInternetException>()),
      );
    });
  });

  group('delete flow', () {
    Future<void> settle(TaskDeleteBloc bloc) => bloc.stream.firstWhere(
      (state) =>
          state is SuccessTaskDeleteState || state is FailureTaskDeleteState,
    );

    test('removes the task from the list', () async {
      final dataSource = mockDataSource();
      final repository = buildRepository(dataSource);
      final target = (await repository.getTasks()).first;
      final bloc = track(TaskDeleteBloc(repository));

      bloc.add(TaskDeleteEvent.deleted(target.id));
      await settle(bloc);

      expect(bloc.state, isA<SuccessTaskDeleteState>());
      expect(
        (await repository.getTasks()).map((task) => task.id),
        isNot(contains(target.id)),
      );
    });

    test('surfaces a failure end-to-end', () async {
      final bloc = track(
        TaskDeleteBloc(buildRepository(const _ThrowingTaskDataSource())),
      );

      bloc.add(const TaskDeleteEvent.deleted('1'));
      await settle(bloc);

      expect(bloc.state, isA<FailureTaskDeleteState>());
    });
  });

  group('search flow', () {
    const query = 'Bulk';

    test('pages through every match', () async {
      final repository = buildRepository(mockDataSource());
      for (var index = 0; index < 11; index++) {
        await repository.createTask(_request('Bulk item $index'));
      }
      final bloc = track(TasksSearchBloc(repository));

      bloc.add(const TasksSearchEvent.querySubmitted(query));
      final firstPage = await bloc.stream.firstWhere(
        (state) => state.status is ResultsTasksSearchStatus,
      );

      final firstStatus = firstPage.status as ResultsTasksSearchStatus;
      expect(firstStatus.data.items, hasLength(10));
      expect(firstStatus.data.canLoadMore, isTrue);

      bloc.add(const TasksSearchEvent.loadMoreRequested());
      final secondPage = await bloc.stream.firstWhere(
        (state) => switch (state.status) {
          ResultsTasksSearchStatus(:final loadMoreState) =>
            loadMoreState == BlocLoadState.loaded,
          _ => false,
        },
      );

      final secondStatus = secondPage.status as ResultsTasksSearchStatus;
      expect(secondStatus.data.items, hasLength(11));
      expect(secondStatus.data.canLoadMore, isFalse);
      expect(
        secondStatus.data.items.map((task) => task.title),
        everyElement(startsWith('Bulk item')),
      );
    });

    test('surfaces a failure end-to-end', () async {
      final bloc = track(
        TasksSearchBloc(buildRepository(const _ThrowingTaskDataSource())),
      );

      bloc.add(const TasksSearchEvent.querySubmitted(query));
      await bloc.stream.firstWhere(
        (state) => state.status is FailureTasksSearchStatus,
      );

      expect(bloc.state.recentQueries, [query]);
    });
  });

  group('change propagation', () {
    // One shared repository, like the app's singleton: a change made anywhere
    // reloads every screen that shows tasks, with no manual refresh.
    test(
      'a deleted task leaves the list, the calendar and the search',
      () async {
        final repository = buildRepository(mockDataSource());
        final today = DateTime.now();

        final list = track(TasksListBloc(repository))
          ..add(const TasksListEvent.requested());
        final calendar = track(CalendarBloc(repository))
          ..add(CalendarEvent.dateSelected(today));
        final search = track(TasksSearchBloc(repository))
          ..add(const TasksSearchEvent.querySubmitted('Code'));

        await list.stream.firstWhere((state) => state is SuccessTasksListState);
        await calendar.stream.firstWhere(
          (state) => state.status is SuccessCalendarStatus,
        );
        await search.stream.firstWhere(
          (state) => state.status is ResultsTasksSearchStatus,
        );
        const deletedId = '2';

        final deleteBloc = track(TaskDeleteBloc(repository))
          ..add(const TaskDeleteEvent.deleted(deletedId));
        await deleteBloc.stream.firstWhere(
          (state) => state is SuccessTaskDeleteState,
        );

        final listState = await list.stream.firstWhere(
          (state) =>
              state is SuccessTasksListState &&
              state.tasks.every((task) => task.id != deletedId),
        );
        expect(listState, isA<SuccessTasksListState>());

        final calendarState = await calendar.stream.firstWhere(
          (state) => switch (state.status) {
            SuccessCalendarStatus(:final tasks) => tasks.every(
              (task) => task.id != deletedId,
            ),
            _ => false,
          },
        );
        expect(calendarState.status, isA<SuccessCalendarStatus>());

        final searchState = await search.stream.firstWhere(
          (state) => switch (state.status) {
            ResultsTasksSearchStatus(:final data) => data.items.every(
              (task) => task.id != deletedId,
            ),
            _ => false,
          },
        );
        expect(searchState.status, isA<ResultsTasksSearchStatus>());
      },
    );

    test('a created task shows up in the list', () async {
      final repository = buildRepository(mockDataSource());
      final list = track(TasksListBloc(repository))
        ..add(const TasksListEvent.requested());
      await list.stream.firstWhere((state) => state is SuccessTasksListState);

      final creation = track(TaskCreationBloc(repository))
        ..add(TaskCreationEvent.submitted(_form));
      await creation.stream.firstWhere(
        (state) => state is SuccessTaskCreationState,
      );

      final listState = await list.stream.firstWhere(
        (state) =>
            state is SuccessTasksListState &&
            state.tasks.any((task) => task.title == _form.title),
      );
      expect(listState, isA<SuccessTasksListState>());
    });

    test('an updated task is announced', () async {
      final repository = buildRepository(mockDataSource());
      final announced = expectLater(repository.changes, emits(anything));

      await repository.updateTask('1', _request('Renamed'));

      await announced;
    });

    test('a failed change is not announced', () async {
      final repository = buildRepository(const _ThrowingTaskDataSource());
      var announced = false;
      final subscription = repository.changes.listen((_) => announced = true);
      addTearDown(subscription.cancel);

      await expectLater(
        repository.deleteTask('1'),
        throwsA(isA<NoInternetException>()),
      );
      await Future<void>.delayed(Duration.zero);

      expect(announced, isFalse);
    });
  });
}
