import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/data/remote_task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

import '../model/task_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

class FakeTaskCreateRequest extends Fake implements TaskCreateRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTaskCreateRequest());
  });

  late RemoteTaskDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = RemoteTaskDataSource(mockApiClient);
  });

  group('getTasks', () {
    test('returns list of tasks when API call is successful', () async {
      when(
        () => mockApiClient.requestJsonList<Task>(
          method: HttpMethod.get,
          path: '/tasks',
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((invocation) async {
        final fromJson =
            invocation.namedArguments[#fromJson] as Task Function(Map<String, dynamic>);
        return [
          fromJson(TaskMockModels.rawTask1),
          fromJson(TaskMockModels.rawTask2),
        ];
      });

      final result = await dataSource.getTasks();

      expect(result.length, equals(2));
      expect(result[0].id, equals(TaskMockModels.task1.id));
      expect(result[1].id, equals(TaskMockModels.task2.id));
      verify(
        () => mockApiClient.requestJsonList<Task>(
          method: HttpMethod.get,
          path: '/tasks',
          fromJson: any(named: 'fromJson'),
        ),
      ).called(1);
    });

    test('throws exception when API call fails', () async {
      when(
        () => mockApiClient.requestJsonList<Task>(
          method: HttpMethod.get,
          path: '/tasks',
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.getTasks(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getTasksByDate', () {
    final testDate = DateTime(2025, 1, 15);

    test('returns list of tasks for specific date when API call is successful',
        () async {
      when(
        () => mockApiClient.requestJsonList<Task>(
          method: HttpMethod.get,
          path: '/tasks/date/${testDate.toIso8601String()}',
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((invocation) async {
        final fromJson =
            invocation.namedArguments[#fromJson] as Task Function(Map<String, dynamic>);
        return [fromJson(TaskMockModels.rawTask1)];
      });

      final result = await dataSource.getTasksByDate(testDate);

      expect(result.length, equals(1));
      expect(result[0].id, equals(TaskMockModels.task1.id));
      verify(
        () => mockApiClient.requestJsonList<Task>(
          method: HttpMethod.get,
          path: '/tasks/date/${testDate.toIso8601String()}',
          fromJson: any(named: 'fromJson'),
        ),
      ).called(1);
    });

    test('throws exception when API call fails', () async {
      when(
        () => mockApiClient.requestJsonList<Task>(
          method: HttpMethod.get,
          path: '/tasks/date/${testDate.toIso8601String()}',
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.getTasksByDate(testDate),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('createTask', () {
    final taskRequest = TaskCreateRequest(
      title: 'New Task',
      description: 'New Description',
      date: DateTime(2025, 1, 20),
      startTime: DateTime(2025, 1, 20, 9, 0),
      endTime: DateTime(2025, 1, 20, 10, 0),
    );

    test('returns created task when API call is successful', () async {
      when(
        () => mockApiClient.requestJson<Task>(
          method: HttpMethod.post,
          path: '/tasks',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((invocation) async {
        final fromJson =
            invocation.namedArguments[#fromJson] as Task Function(Map<String, dynamic>);
        return fromJson(TaskMockModels.rawTask3);
      });

      final result = await dataSource.createTask(taskRequest);

      expect(result.id, equals(TaskMockModels.task3.id));
      expect(result.title, isNotEmpty);
      verify(
        () => mockApiClient.requestJson<Task>(
          method: HttpMethod.post,
          path: '/tasks',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).called(1);
    });

    test('throws exception when API call fails', () async {
      when(
        () => mockApiClient.requestJson<Task>(
          method: HttpMethod.post,
          path: '/tasks',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.createTask(taskRequest),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('updateTask', () {
    const taskId = '1';
    final taskRequest = TaskCreateRequest(
      title: 'Updated Task',
      description: 'Updated Description',
      date: DateTime(2025, 1, 20),
      startTime: DateTime(2025, 1, 20, 9, 0),
      endTime: DateTime(2025, 1, 20, 10, 0),
    );

    test('returns updated task when API call is successful', () async {
      when(
        () => mockApiClient.requestJson<Task>(
          method: HttpMethod.put,
          path: '/tasks/$taskId',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((invocation) async {
        final fromJson =
            invocation.namedArguments[#fromJson] as Task Function(Map<String, dynamic>);
        return fromJson(TaskMockModels.rawTask1);
      });

      final result = await dataSource.updateTask(taskId, taskRequest);

      expect(result.id, equals(TaskMockModels.task1.id));
      verify(
        () => mockApiClient.requestJson<Task>(
          method: HttpMethod.put,
          path: '/tasks/$taskId',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).called(1);
    });

    test('throws exception when API call fails', () async {
      when(
        () => mockApiClient.requestJson<Task>(
          method: HttpMethod.put,
          path: '/tasks/$taskId',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.updateTask(taskId, taskRequest),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('deleteTask', () {
    const taskId = '1';

    test('completes successfully when API call succeeds', () async {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.delete,
          path: '/tasks/$taskId',
        ),
      ).thenAnswer((_) async {});

      await dataSource.deleteTask(taskId);

      verify(
        () => mockApiClient.requestVoid(
          method: HttpMethod.delete,
          path: '/tasks/$taskId',
        ),
      ).called(1);
    });

    test('throws exception when API call fails', () async {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.delete,
          path: '/tasks/$taskId',
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.deleteTask(taskId),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('TaskCreateRequest', () {
    test('toJson serializes correctly', () {
      final date = DateTime(2025, 1, 20);
      final startTime = DateTime(2025, 1, 20, 9, 0);
      final endTime = DateTime(2025, 1, 20, 10, 30);

      final request = TaskCreateRequest(
        title: 'New Task',
        description: 'Task Description',
        date: date,
        startTime: startTime,
        endTime: endTime,
      );

      final json = request.toJson();

      expect(json['title'], equals('New Task'));
      expect(json['description'], equals('Task Description'));
      expect(json['date'], equals(date.toIso8601String()));
      expect(json['startTime'], equals(startTime.toIso8601String()));
      expect(json['endTime'], equals(endTime.toIso8601String()));
      expect(json.length, equals(5));
    });
  });
}
