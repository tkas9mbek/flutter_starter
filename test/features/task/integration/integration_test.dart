import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/data/remote_task_data_source.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/task_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

/// Integration tests: BLoC → TaskRepository → RemoteTaskDataSource → ApiClient (mocked)
///
/// Tests the full flow from BLoC through Repository and DataSource with only ApiClient mocked.
void main() {
  late MockApiClient mockApiClient;
  late TaskDataSource taskDataSource;
  late TaskRepository taskRepository;

  setUp(() {
    mockApiClient = MockApiClient();
    taskDataSource = RemoteTaskDataSource(mockApiClient);
    taskRepository = TaskRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      taskDataSource,
    );
  });

  group('CalendarBloc integration', () {
    late CalendarBloc calendarBloc;

    setUp(() {
      calendarBloc = CalendarBloc(taskRepository);
    });

    test('initial state has today as selectedDate and initial status', () {
      final now = DateTime.now();
      expect(calendarBloc.state.selectedDate.year, equals(now.year));
      expect(calendarBloc.state.selectedDate.month, equals(now.month));
      expect(calendarBloc.state.selectedDate.day, equals(now.day));
      expect(calendarBloc.state.status, const CalendarStatus.initial());
    });

    final testDate = DateTime(2025, 1, 15);

    blocTest<CalendarBloc, CalendarState>(
      'completes full successful flow for getTasksByDate',
      build: () {
        when(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: any(named: 'path'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => [TaskMockModels.task1]);

        return calendarBloc;
      },
      act: (bloc) => bloc.add(CalendarEvent.dateSelected(testDate)),
      expect: () => [
        CalendarState(
          selectedDate: testDate,
          status: const CalendarStatus.loading(),
        ),
        CalendarState(
          selectedDate: testDate,
          status: CalendarStatus.success(tasks: [TaskMockModels.task1]),
        ),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: '/tasks/date/${testDate.toIso8601String()}',
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    );

    blocTest<CalendarBloc, CalendarState>(
      'handles network error through full stack',
      build: () {
        when(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: any(named: 'path'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(const NoInternetException());

        return calendarBloc;
      },
      act: (bloc) => bloc.add(CalendarEvent.dateSelected(testDate)),
      expect: () => [
        CalendarState(
          selectedDate: testDate,
          status: const CalendarStatus.loading(),
        ),
        CalendarState(
          selectedDate: testDate,
          status: const CalendarStatus.failure(
            exception: NoInternetException(),
          ),
        ),
      ],
    );

    blocTest<CalendarBloc, CalendarState>(
      'refreshed() event triggers getTasksByDate with current selected date',
      build: () {
        when(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: any(named: 'path'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => [TaskMockModels.task1]);

        return calendarBloc;
      },
      seed: () => CalendarState(
        selectedDate: testDate,
        status: const CalendarStatus.initial(),
      ),
      act: (bloc) => bloc.add(const CalendarEvent.refreshed()),
      expect: () => [
        CalendarState(
          selectedDate: testDate,
          status: const CalendarStatus.loading(),
        ),
        CalendarState(
          selectedDate: testDate,
          status: CalendarStatus.success(tasks: [TaskMockModels.task1]),
        ),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: '/tasks/date/${testDate.toIso8601String()}',
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    );
  });

  group('TasksListBloc integration', () {
    late TasksListBloc tasksListBloc;

    setUp(() {
      tasksListBloc = TasksListBloc(taskRepository);
    });

    test('initial state is initial()', () {
      expect(tasksListBloc.state, const TasksListState.initial());
    });

    blocTest<TasksListBloc, TasksListState>(
      'completes full successful flow: getTasks, groups by date, sorts by time',
      build: () {
        when(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: '/tasks',
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => TaskMockModels.allTasks);

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
        verify(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: '/tasks',
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    );

    blocTest<TasksListBloc, TasksListState>(
      'handles network error through full stack',
      build: () {
        when(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: '/tasks',
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(const NoInternetException());

        return tasksListBloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () => [
        const TasksListState.loading(),
        const TasksListState.failure(NoInternetException()),
      ],
    );

    blocTest<TasksListBloc, TasksListState>(
      'handles empty task list',
      build: () {
        when(
          () => mockApiClient.requestJsonList<Task>(
            method: any(named: 'method'),
            path: '/tasks',
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => []);

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
    );
  });
}
