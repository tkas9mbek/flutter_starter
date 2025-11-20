import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/task_mock_models.dart';

class MockTaskDataSource extends Mock implements TaskDataSource {}

class FakeTaskCreateRequest extends Fake implements TaskCreateRequest {}

void main() {
  late TaskRepository repository;
  late MockTaskDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(FakeTaskCreateRequest());
  });

  setUp(() {
    mockDataSource = MockTaskDataSource();
    repository = TaskRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      mockDataSource,
    );
  });

  group('getTasks', () {
    test('returns list of tasks from data source', () async {
      when(() => mockDataSource.getTasks())
          .thenAnswer((_) async => TaskMockModels.allTasks);

      final result = await repository.getTasks();

      expect(result, equals(TaskMockModels.allTasks));
      verify(() => mockDataSource.getTasks()).called(1);
    });
  });

  group('getTasksByDate', () {
    test('returns list of tasks for specific date from data source', () async {
      final testDate = DateTime(2025, 1, 15);
      when(() => mockDataSource.getTasksByDate(testDate))
          .thenAnswer((_) async => [TaskMockModels.task1]);

      final result = await repository.getTasksByDate(testDate);

      expect(result.length, equals(1));
      expect(result[0], equals(TaskMockModels.task1));
      verify(() => mockDataSource.getTasksByDate(testDate)).called(1);
    });
  });

  group('createTask', () {
    test('returns created task from data source', () async {
      final request = TaskCreateRequest(
        title: 'New Task',
        description: 'Description',
        date: DateTime(2025, 1, 20),
        startTime: DateTime(2025, 1, 20, 9, 0),
        endTime: DateTime(2025, 1, 20, 10, 0),
      );

      when(() => mockDataSource.createTask(any()))
          .thenAnswer((_) async => TaskMockModels.task3);

      final result = await repository.createTask(request);

      expect(result, equals(TaskMockModels.task3));
      verify(() => mockDataSource.createTask(request)).called(1);
    });
  });

  group('updateTask', () {
    test('returns updated task from data source', () async {
      const taskId = '1';
      final request = TaskCreateRequest(
        title: 'Updated Task',
        description: 'Updated Description',
        date: DateTime(2025, 1, 20),
        startTime: DateTime(2025, 1, 20, 9, 0),
        endTime: DateTime(2025, 1, 20, 10, 0),
      );

      when(() => mockDataSource.updateTask(taskId, any()))
          .thenAnswer((_) async => TaskMockModels.task1);

      final result = await repository.updateTask(taskId, request);

      expect(result, equals(TaskMockModels.task1));
      verify(() => mockDataSource.updateTask(taskId, request)).called(1);
    });
  });

  group('deleteTask', () {
    test('delegates to data source', () async {
      const taskId = '1';

      when(() => mockDataSource.deleteTask(taskId))
          .thenAnswer((_) async => {});

      await repository.deleteTask(taskId);

      verify(() => mockDataSource.deleteTask(taskId)).called(1);
    });
  });
}
