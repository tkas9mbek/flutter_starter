import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';

import '../model/task_mock_models.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

PaginatedListItems<Task> _page(List<Task> tasks, {int countPages = 1}) =>
    PaginatedListItems(
      pageLimit: 2,
      countItems: 3,
      countPages: countPages,
      elements: tasks,
    );

void main() {
  late MockTaskRepository repository;

  setUp(() => repository = MockTaskRepository());

  const query = 'Task';
  const exception = ServerException(statusCode: 500);
  final firstPage = _page([
    TaskMockModels.task1,
    TaskMockModels.task2,
  ], countPages: 2);
  final secondPage = _page([TaskMockModels.task3], countPages: 2);
  final firstPageData = PaginatedData.fromApi(firstPage);

  test(
    'initial state is idle with no query and no recent queries',
    () => expect(TasksSearchBloc(repository).state, const TasksSearchState()),
  );

  group('on queryChanged() event', () {
    blocTest<TasksSearchBloc, TasksSearchState>(
      'emits suggestions for the trimmed query',
      build: () {
        when(
          () => repository.searchTasks(query, page: 1),
        ).thenAnswer((_) async => firstPage);

        return TasksSearchBloc(repository);
      },
      act: (bloc) => bloc.add(const TasksSearchEvent.queryChanged('  Task  ')),
      expect: () => [
        TasksSearchState(
          status: TasksSearchStatus.suggestions(
            tasks: firstPage.elements,
            query: query,
          ),
        ),
      ],
      verify: (_) =>
          verify(() => repository.searchTasks(query, page: 1)).called(1),
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'returns to idle without searching when the query is blank',
      build: () => TasksSearchBloc(repository),
      seed: () => TasksSearchState(
        status: TasksSearchStatus.suggestions(
          tasks: firstPage.elements,
          query: query,
        ),
      ),
      act: (bloc) => bloc.add(const TasksSearchEvent.queryChanged('   ')),
      expect: () => [const TasksSearchState()],
      verify: (_) => verifyNever(
        () => repository.searchTasks(any(), page: any(named: 'page')),
      ),
    );

    final staleResponse = Completer<PaginatedListItems<Task>>();

    blocTest<TasksSearchBloc, TasksSearchState>(
      'drops the result of a query superseded by a newer one',
      build: () {
        when(
          () => repository.searchTasks('Ta', page: 1),
        ).thenAnswer((_) => staleResponse.future);
        when(
          () => repository.searchTasks(query, page: 1),
        ).thenAnswer((_) async => firstPage);

        return TasksSearchBloc(repository);
      },
      act: (bloc) async {
        bloc.add(const TasksSearchEvent.queryChanged('Ta'));
        await pumpEventQueue();
        bloc.add(const TasksSearchEvent.queryChanged(query));
        await pumpEventQueue();
        staleResponse.complete(secondPage);
        await pumpEventQueue();
      },
      expect: () => [
        TasksSearchState(
          status: TasksSearchStatus.suggestions(
            tasks: firstPage.elements,
            query: query,
          ),
        ),
      ],
      verify: (_) =>
          verify(() => repository.searchTasks('Ta', page: 1)).called(1),
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'emits failure when the search throws',
      build: () {
        when(() => repository.searchTasks(query, page: 1)).thenThrow(exception);

        return TasksSearchBloc(repository);
      },
      act: (bloc) => bloc.add(const TasksSearchEvent.queryChanged(query)),
      expect: () => [
        const TasksSearchState(status: TasksSearchStatus.failure(exception)),
      ],
    );
  });

  group('on querySubmitted() event', () {
    blocTest<TasksSearchBloc, TasksSearchState>(
      'emits [loading, results] and records the query as recent',
      build: () {
        when(
          () => repository.searchTasks(query, page: 1),
        ).thenAnswer((_) async => firstPage);

        return TasksSearchBloc(repository);
      },
      act: (bloc) => bloc.add(const TasksSearchEvent.querySubmitted(' Task ')),
      expect: () => [
        const TasksSearchState(
          query: query,
          status: TasksSearchStatus.loading(),
          recentQueries: [query],
        ),
        TasksSearchState(
          query: query,
          status: TasksSearchStatus.results(data: firstPageData, query: query),
          recentQueries: const [query],
        ),
      ],
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'ignores a blank query',
      build: () => TasksSearchBloc(repository),
      act: (bloc) => bloc.add(const TasksSearchEvent.querySubmitted('  ')),
      expect: () => <TasksSearchState>[],
      verify: (_) => verifyNever(
        () => repository.searchTasks(any(), page: any(named: 'page')),
      ),
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'emits [loading, failure] when the search throws',
      build: () {
        when(() => repository.searchTasks(query, page: 1)).thenThrow(exception);

        return TasksSearchBloc(repository);
      },
      act: (bloc) => bloc.add(const TasksSearchEvent.querySubmitted(query)),
      expect: () => [
        const TasksSearchState(
          query: query,
          status: TasksSearchStatus.loading(),
          recentQueries: [query],
        ),
        const TasksSearchState(
          query: query,
          status: TasksSearchStatus.failure(exception),
          recentQueries: [query],
        ),
      ],
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'moves a case-insensitive repeat to the front instead of duplicating it',
      build: () {
        when(
          () => repository.searchTasks('TASK', page: 1),
        ).thenAnswer((_) async => firstPage);

        return TasksSearchBloc(repository);
      },
      seed: () => const TasksSearchState(recentQueries: ['a', 'task', 'b']),
      act: (bloc) => bloc.add(const TasksSearchEvent.querySubmitted('TASK')),
      verify: (bloc) => expect(bloc.state.recentQueries, ['TASK', 'a', 'b']),
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'keeps at most five recent queries, newest first',
      build: () {
        when(
          () => repository.searchTasks('f', page: 1),
        ).thenAnswer((_) async => firstPage);

        return TasksSearchBloc(repository);
      },
      seed: () =>
          const TasksSearchState(recentQueries: ['a', 'b', 'c', 'd', 'e']),
      act: (bloc) => bloc.add(const TasksSearchEvent.querySubmitted('f')),
      verify: (bloc) =>
          expect(bloc.state.recentQueries, ['f', 'a', 'b', 'c', 'd']),
    );
  });

  group('on refreshed() event', () {
    blocTest<TasksSearchBloc, TasksSearchState>(
      're-runs the current query',
      build: () {
        when(
          () => repository.searchTasks(query, page: 1),
        ).thenAnswer((_) async => firstPage);

        return TasksSearchBloc(repository);
      },
      seed: () => const TasksSearchState(
        query: query,
        status: TasksSearchStatus.failure(exception),
        recentQueries: [query],
      ),
      act: (bloc) => bloc.add(const TasksSearchEvent.refreshed()),
      expect: () => [
        const TasksSearchState(
          query: query,
          status: TasksSearchStatus.loading(),
          recentQueries: [query],
        ),
        TasksSearchState(
          query: query,
          status: TasksSearchStatus.results(data: firstPageData, query: query),
          recentQueries: const [query],
        ),
      ],
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'does nothing when no query was submitted yet',
      build: () => TasksSearchBloc(repository),
      act: (bloc) => bloc.add(const TasksSearchEvent.refreshed()),
      expect: () => <TasksSearchState>[],
      verify: (_) => verifyNever(
        () => repository.searchTasks(any(), page: any(named: 'page')),
      ),
    );
  });

  group('on loadMoreRequested() event', () {
    final resultsState = TasksSearchState(
      query: query,
      status: TasksSearchStatus.results(data: firstPageData, query: query),
      recentQueries: const [query],
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'appends the next page and marks load-more as loaded',
      build: () {
        when(
          () => repository.searchTasks(query, page: 2),
        ).thenAnswer((_) async => secondPage);

        return TasksSearchBloc(repository);
      },
      seed: () => resultsState,
      act: (bloc) => bloc.add(const TasksSearchEvent.loadMoreRequested()),
      expect: () => [
        resultsState.copyWith(
          status: TasksSearchStatus.results(
            data: firstPageData,
            query: query,
            loadMoreState: BlocLoadState.loading,
          ),
        ),
        isA<TasksSearchState>().having(
          (state) => state.status,
          'status',
          isA<ResultsTasksSearchStatus>()
              .having(
                (status) => status.data.items,
                'items',
                TaskMockModels.allTasks,
              )
              .having((status) => status.data.page, 'page', 2)
              .having((status) => status.data.canLoadMore, 'canLoadMore', false)
              .having(
                (status) => status.loadMoreState,
                'loadMoreState',
                BlocLoadState.loaded,
              ),
        ),
      ],
      verify: (_) =>
          verify(() => repository.searchTasks(query, page: 2)).called(1),
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'keeps loaded items and marks load-more as failed when the page throws',
      build: () {
        when(() => repository.searchTasks(query, page: 2)).thenThrow(exception);

        return TasksSearchBloc(repository);
      },
      seed: () => resultsState,
      act: (bloc) => bloc.add(const TasksSearchEvent.loadMoreRequested()),
      expect: () => [
        resultsState.copyWith(
          status: TasksSearchStatus.results(
            data: firstPageData,
            query: query,
            loadMoreState: BlocLoadState.loading,
          ),
        ),
        resultsState.copyWith(
          status: TasksSearchStatus.results(
            data: firstPageData,
            query: query,
            loadMoreState: BlocLoadState.failure,
          ),
        ),
      ],
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'does nothing on the last page',
      build: () => TasksSearchBloc(repository),
      seed: () => TasksSearchState(
        query: query,
        status: TasksSearchStatus.results(
          data: PaginatedData.fromApi(_page(TaskMockModels.allTasks)),
          query: query,
        ),
      ),
      act: (bloc) => bloc.add(const TasksSearchEvent.loadMoreRequested()),
      expect: () => <TasksSearchState>[],
      verify: (_) => verifyNever(
        () => repository.searchTasks(any(), page: any(named: 'page')),
      ),
    );

    blocTest<TasksSearchBloc, TasksSearchState>(
      'does nothing while showing suggestions',
      build: () => TasksSearchBloc(repository),
      seed: () => TasksSearchState(
        status: TasksSearchStatus.suggestions(
          tasks: firstPage.elements,
          query: query,
        ),
      ),
      act: (bloc) => bloc.add(const TasksSearchEvent.loadMoreRequested()),
      expect: () => <TasksSearchState>[],
    );
  });

  blocTest<TasksSearchBloc, TasksSearchState>(
    'recentCleared() empties the recent queries',
    build: () => TasksSearchBloc(repository),
    seed: () => const TasksSearchState(recentQueries: ['a', 'b']),
    act: (bloc) => bloc.add(const TasksSearchEvent.recentCleared()),
    expect: () => [const TasksSearchState()],
  );
}
