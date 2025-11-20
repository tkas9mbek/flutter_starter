import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/task_mock_models.dart';

class MockTaskDataSource extends Mock implements TaskDataSource {}

void main() {
  late CalendarBloc calendarBloc;
  late MockTaskDataSource mockDataSource;
  late TaskRepository taskRepository;

  setUp(() {
    mockDataSource = MockTaskDataSource();
    taskRepository = TaskRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      mockDataSource,
    );
    calendarBloc = CalendarBloc(taskRepository);
  });

  test('initial state has today as selectedDate and initial status', () {
    final now = DateTime.now();
    expect(calendarBloc.state.selectedDate.year, equals(now.year));
    expect(calendarBloc.state.selectedDate.month, equals(now.month));
    expect(calendarBloc.state.selectedDate.day, equals(now.day));
    expect(calendarBloc.state.status, const CalendarStatus.initial());
  });

  group('on dateSelected() event', () {
    final testDate = DateTime(2025, 1, 15);

    blocTest<CalendarBloc, CalendarState>(
      'emits [loading, success] with selected date and tasks',
      build: () {
        when(() => mockDataSource.getTasksByDate(testDate))
            .thenAnswer((_) async => TaskMockModels.tasksForDate1);

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
          status: CalendarStatus.success(tasks: TaskMockModels.tasksForDate1),
        ),
      ],
      verify: (_) {
        verify(() => mockDataSource.getTasksByDate(testDate)).called(1);
      },
    );

    blocTest<CalendarBloc, CalendarState>(
      'emits [loading, success] with empty task list',
      build: () {
        when(() => mockDataSource.getTasksByDate(testDate))
            .thenAnswer((_) async => []);

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
          status: const CalendarStatus.success(tasks: []),
        ),
      ],
      verify: (_) {
        verify(() => mockDataSource.getTasksByDate(testDate)).called(1);
      },
    );

    blocTest<CalendarBloc, CalendarState>(
      'emits [loading, failure] when getTasksByDate fails',
      build: () {
        when(() => mockDataSource.getTasksByDate(testDate))
            .thenThrow(const NoInternetException());

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
      verify: (_) {
        verify(() => mockDataSource.getTasksByDate(testDate)).called(1);
      },
    );

    blocTest<CalendarBloc, CalendarState>(
      'updates selectedDate when switching between dates',
      build: () {
        when(() => mockDataSource.getTasksByDate(any()))
            .thenAnswer((_) async => TaskMockModels.tasksForDate1);

        return calendarBloc;
      },
      act: (bloc) => bloc
        ..add(CalendarEvent.dateSelected(DateTime(2025, 1, 10)))
        ..add(CalendarEvent.dateSelected(DateTime(2025, 1, 20))),
      expect: () => [
        CalendarState(
          selectedDate: DateTime(2025, 1, 10),
          status: const CalendarStatus.loading(),
        ),
        CalendarState(
          selectedDate: DateTime(2025, 1, 10),
          status: CalendarStatus.success(tasks: TaskMockModels.tasksForDate1),
        ),
        CalendarState(
          selectedDate: DateTime(2025, 1, 20),
          status: const CalendarStatus.loading(),
        ),
        CalendarState(
          selectedDate: DateTime(2025, 1, 20),
          status: CalendarStatus.success(tasks: TaskMockModels.tasksForDate1),
        ),
      ],
    );
  });

  group('on refreshed() event', () {
    final initialDate = DateTime(2025, 1, 15);

    blocTest<CalendarBloc, CalendarState>(
      'emits [loading, success] with current selectedDate',
      build: () {
        when(() => mockDataSource.getTasksByDate(initialDate))
            .thenAnswer((_) async => [TaskMockModels.task1]);

        return calendarBloc;
      },
      seed: () => CalendarState(
        selectedDate: initialDate,
        status: const CalendarStatus.initial(),
      ),
      act: (bloc) => bloc.add(const CalendarEvent.refreshed()),
      expect: () => [
        CalendarState(
          selectedDate: initialDate,
          status: const CalendarStatus.loading(),
        ),
        CalendarState(
          selectedDate: initialDate,
          status: CalendarStatus.success(tasks: [TaskMockModels.task1]),
        ),
      ],
      verify: (_) {
        verify(() => mockDataSource.getTasksByDate(initialDate)).called(1);
      },
    );

    blocTest<CalendarBloc, CalendarState>(
      'emits [loading, failure] when refresh fails',
      build: () {
        when(() => mockDataSource.getTasksByDate(initialDate))
            .thenThrow(const ServerException(statusCode: 500));

        return calendarBloc;
      },
      seed: () => CalendarState(
        selectedDate: initialDate,
        status: CalendarStatus.success(tasks: [TaskMockModels.task1]),
      ),
      act: (bloc) => bloc.add(const CalendarEvent.refreshed()),
      expect: () => [
        CalendarState(
          selectedDate: initialDate,
          status: const CalendarStatus.loading(),
        ),
        CalendarState(
          selectedDate: initialDate,
          status: const CalendarStatus.failure(
            exception: ServerException(statusCode: 500),
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockDataSource.getTasksByDate(initialDate)).called(1);
      },
    );

    blocTest<CalendarBloc, CalendarState>(
      'preserves selectedDate when refreshing',
      build: () {
        when(() => mockDataSource.getTasksByDate(initialDate))
            .thenAnswer((_) async => [TaskMockModels.task1]);

        return calendarBloc;
      },
      seed: () => CalendarState(
        selectedDate: initialDate,
        status: const CalendarStatus.initial(),
      ),
      act: (bloc) => bloc.add(const CalendarEvent.refreshed()),
      verify: (bloc) {
        expect(bloc.state.selectedDate, equals(initialDate));
      },
    );
  });

  group('state helper methods', () {
    final testDate = DateTime(2025, 1, 15);
    final initialState = CalendarState.initial();
    final loadingState = CalendarState(
      selectedDate: testDate,
      status: const CalendarStatus.loading(),
    );
    final successState = CalendarState(
      selectedDate: testDate,
      status: const CalendarStatus.success(tasks: []),
    );
    final failureState = CalendarState(
      selectedDate: testDate,
      status: const CalendarStatus.failure(
        exception: NoInternetException(),
      ),
    );

    test('isLoading returns true for loading status', () {
      calendarBloc.emit(loadingState);
      expect(calendarBloc.state.isLoading, isTrue);
    });

    test('isLoading returns false for non-loading statuses', () {
      calendarBloc.emit(initialState);
      expect(calendarBloc.state.isLoading, isFalse);

      calendarBloc.emit(successState);
      expect(calendarBloc.state.isLoading, isFalse);

      calendarBloc.emit(failureState);
      expect(calendarBloc.state.isLoading, isFalse);
    });
  });
}
