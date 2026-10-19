import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/data/api_task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';

import '../model/task_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

// ignore: avoid_implementing_value_types
class FakeTaskCreateRequest extends Fake implements TaskCreateRequest {}

void main() {
  setUpAll(() => registerFallbackValue(FakeTaskCreateRequest()));

  late ApiTaskDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ApiTaskDataSource(mockApiClient);
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
            invocation.namedArguments[#fromJson]
                as Task Function(Map<String, dynamic>);

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

      expect(() => dataSource.getTasks(), throwsA(isA<Exception>()));
    });
  });

  group('getTasksByDate', () {
    final testDate = DateTime(2025, 1, 15);

    test(
      'returns list of tasks for specific date when API call is successful',
      () async {
        when(
          () => mockApiClient.requestJsonList<Task>(
            method: HttpMethod.get,
            path: '/tasks/date/${testDate.toIso8601String()}',
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((invocation) async {
          final fromJson =
              invocation.namedArguments[#fromJson]
                  as Task Function(Map<String, dynamic>);

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
      },
    );

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

  group('searchTasks', () {
    test('sends query and page and decodes the paginated tasks', () async {
      when(
        () => mockApiClient.requestJson<PaginatedListItems<Task>>(
          method: HttpMethod.get,
          path: '/tasks/search',
          queryParameters: {'query': 'Task', 'page': 2},
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((invocation) async {
        final fromJson =
            invocation.namedArguments[#fromJson]
                as PaginatedListItems<Task> Function(Map<String, dynamic>);

        return fromJson(TaskMockModels.rawSearchPage);
      });

      final result = await dataSource.searchTasks('Task', page: 2);

      expect(result.elements, [TaskMockModels.task1, TaskMockModels.task2]);
      expect(result.countItems, 12);
      expect(result.countPages, 2);
      expect(result.pageLimit, 10);
    });

    test('throws exception when API call fails', () async {
      when(
        () => mockApiClient.requestJson<PaginatedListItems<Task>>(
          method: HttpMethod.get,
          path: '/tasks/search',
          queryParameters: any(named: 'queryParameters'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.searchTasks('Task', page: 1),
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
            invocation.namedArguments[#fromJson]
                as Task Function(Map<String, dynamic>);

        return fromJson(TaskMockModels.rawTask3);
      });

      final result = await dataSource.createTask(taskRequest);

      expect(result, TaskMockModels.task3);
      final body =
          verify(
                () => mockApiClient.requestJson<Task>(
                  method: HttpMethod.post,
                  path: '/tasks',
                  body: captureAny(named: 'body'),
                  fromJson: any(named: 'fromJson'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(body, {
        'title': 'New Task',
        'description': 'New Description',
        'date': '2025-01-20T00:00:00.000',
        'startTime': '2025-01-20T09:00:00.000',
        'endTime': '2025-01-20T10:00:00.000',
      });
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
            invocation.namedArguments[#fromJson]
                as Task Function(Map<String, dynamic>);

        return fromJson(TaskMockModels.rawTask1);
      });

      final result = await dataSource.updateTask(taskId, taskRequest);

      expect(result, TaskMockModels.task1);
      final body =
          verify(
                () => mockApiClient.requestJson<Task>(
                  method: HttpMethod.put,
                  path: '/tasks/$taskId',
                  body: captureAny(named: 'body'),
                  fromJson: any(named: 'fromJson'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(body, {
        'title': 'Updated Task',
        'description': 'Updated Description',
        'date': '2025-01-20T00:00:00.000',
        'startTime': '2025-01-20T09:00:00.000',
        'endTime': '2025-01-20T10:00:00.000',
      });
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

      expect(() => dataSource.deleteTask(taskId), throwsA(isA<Exception>()));
    });
  });
}
