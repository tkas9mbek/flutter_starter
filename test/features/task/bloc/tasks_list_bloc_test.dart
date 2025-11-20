import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/task_mock_models.dart';

class MockTaskDataSource extends Mock implements TaskDataSource {}

void main() {
  late TasksListBloc tasksListBloc;
  late MockTaskDataSource mockDataSource;
  late TaskRepository taskRepository;

  setUp(() {
    mockDataSource = MockTaskDataSource();
    taskRepository = TaskRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      mockDataSource,
    );
    tasksListBloc = TasksListBloc(taskRepository);
  });

  test('initial state is initial()', () {
    expect(tasksListBloc.state, const TasksListState.initial());
  });

  group('on requested() event', () {
    blocTest<TasksListBloc, TasksListState>(
      'emits [loading, success] when getTasks is successful',
      build: () {
        when(() => mockDataSource.getTasks())
            .thenAnswer((_) async => TaskMockModels.allTasks);

        return tasksListBloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () {
        final date1 = DateTime(2025, 1, 15);
        final date2 = DateTime(2025, 1, 16);
        final date1OnlyDay = DateTime(date1.year, date1.month, date1.day);
        final date2OnlyDay = DateTime(date2.year, date2.month, date2.day);

        return [
          const TasksListState.loading(),
          TasksListState.success(
            tasks: TaskMockModels.allTasks,
            groupedTasks: {
              date1OnlyDay: TaskMockModels.tasksForDate1,
              date2OnlyDay: TaskMockModels.tasksForDate3,
            },
          ),
        ];
      },
      verify: (_) {
        verify(() => mockDataSource.getTasks()).called(1);
      },
    );

    blocTest<TasksListBloc, TasksListState>(
      'emits [loading, success] with empty task list',
      build: () {
        when(() => mockDataSource.getTasks()).thenAnswer((_) async => []);

        return tasksListBloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () => [
        const TasksListState.loading(),
        const TasksListState.success(
          tasks: [],
          groupedTasks: {},
        ),
      ],
      verify: (_) {
        verify(() => mockDataSource.getTasks()).called(1);
      },
    );

    blocTest<TasksListBloc, TasksListState>(
      'groups tasks by date and sorts by start time',
      build: () {
        final unsortedTasks = [TaskMockModels.task2, TaskMockModels.task1];

        when(() => mockDataSource.getTasks())
            .thenAnswer((_) async => unsortedTasks);

        return tasksListBloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      verify: (bloc) {
        bloc.state.whenOrNull(
          success: (tasks, groupedTasks) {
            final date1 = DateTime(2025, 1, 15);
            final date1OnlyDay = DateTime(date1.year, date1.month, date1.day);
            final groupedList = groupedTasks[date1OnlyDay]!;

            expect(groupedList[0].startTime.hour, equals(9));
            expect(groupedList[1].startTime.hour, equals(14));
          },
        );
      },
    );

    blocTest<TasksListBloc, TasksListState>(
      'emits [loading, failure] when getTasks fails with no internet',
      build: () {
        when(() => mockDataSource.getTasks())
            .thenThrow(const NoInternetException());

        return tasksListBloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () => [
        const TasksListState.loading(),
        const TasksListState.failure(NoInternetException()),
      ],
      verify: (_) {
        verify(() => mockDataSource.getTasks()).called(1);
      },
    );

    blocTest<TasksListBloc, TasksListState>(
      'emits [loading, failure] when getTasks fails with server error',
      build: () {
        when(() => mockDataSource.getTasks())
            .thenThrow(const ServerException(statusCode: 500));

        return tasksListBloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () => [
        const TasksListState.loading(),
        predicate<TasksListState>(
          (state) => state.whenOrNull(
                failure: (exception) => exception is ServerException,
              ) ==
              true,
        ),
      ],
      verify: (_) {
        verify(() => mockDataSource.getTasks()).called(1);
      },
    );
  });

  group('state helper methods', () {
    const initialState = TasksListState.initial();
    const loadingState = TasksListState.loading();
    const successState = TasksListState.success(
      tasks: [],
      groupedTasks: {},
    );
    const failureState = TasksListState.failure(NoInternetException());

    test('isLoading returns true for loading state', () {
      tasksListBloc.emit(loadingState);
      expect(tasksListBloc.state.isLoading, isTrue);
    });

    test('isLoading returns false for non-loading states', () {
      tasksListBloc.emit(initialState);
      expect(tasksListBloc.state.isLoading, isFalse);

      tasksListBloc.emit(successState);
      expect(tasksListBloc.state.isLoading, isFalse);

      tasksListBloc.emit(failureState);
      expect(tasksListBloc.state.isLoading, isFalse);
    });
  });
}
