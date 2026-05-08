# Testing Guide

> **AI Context**: Comprehensive testing strategy for Flutter project using BLoC pattern with 145 tests passing (100% pass rate). Every BLoC must have tests. Use JSON assets for mock data. All features have full integration test coverage.

## Test Structure

**AI Instruction**: All tests organized under `test/features/{feature}/` directory

```
test/features/{feature}/
├── assets/          # JSON test data files
├── model/           # Mock model helpers (use fromJson)
├── data/            # Repository and DataSource unit tests
├── bloc/            # BLoC unit tests
└── integration/     # Full-stack integration tests
```

## Core Testing Strategy

**AI Instruction**: Three types of tests - unit tests for data/repositories, BLoC tests, and integration tests

### 1. Data Layer Unit Tests (Required for Repositories)

**AI Instruction**: Test Repository and DataSource classes with mocked dependencies

```
Repository (Real) → DataSource (Mock)
DataSource (Real) → ApiClient (Mock)
```

**Always write unit tests for:**
- **Repositories**: Test all CRUD methods (create, read, update, delete)
- **DataSources**: Test API calls and fromJson deserialization
- **Request Models**: Test toJson serialization

### 2. BLoC Unit Tests (Required)

**AI Instruction**: Test BLoC with mocked Repository

```
BLoC (Real) → Repository (Mock)
```

**Test coverage:**
- Initial state
- All events with success scenarios
- All events with empty scenarios
- All events with failure scenarios
- State helper methods

### 3. Integration Tests (Recommended)

**AI Instruction**: Test entire stack with only ApiClient mocked

```
BLoC (Real) → Repository (Real) → DataSource (Real) → ApiClient (Mock)
```

**Purpose**: Verify full feature flow works end-to-end

---

## Test Quality Requirements

**AI Instruction**: All tests must meet these standards

- **Fast**: < 1 second per test class
- **Independent**: No real network/database/backend
- **Reliable**: No flaky tests
- **High Coverage**: Aim for 100% for BLoC, Service, logic classes

---

## Required Packages

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.5
  mocktail: ^1.0.1
  http_mock_adapter: ^0.6.1
```

---

## Testing Patterns

### Pattern 1: JSON Assets and Mock Models

**AI Instruction**: ALWAYS use JSON assets instead of creating models in code

#### Step 1: Create JSON Test Data

```dart
// test/features/task/assets/task1.json
{
  "id": "1",
  "title": "Buy groceries",
  "description": "Milk, eggs, bread",
  "date": "2025-01-15T00:00:00.000Z",
  "startTime": "2025-01-15T09:00:00.000Z",
  "endTime": "2025-01-15T10:00:00.000Z",
  "isCompleted": false
}
```

#### Step 2: Create Mock Model Helper

```dart
// test/features/task/model/task_mock_models.dart
import 'dart:convert';
import 'dart:io';
import 'package:starter/features/task/model/task.dart';

class TaskMockModels {
  static dynamic getJsonFromFile(String fileName) {
    const basePath = 'test/features/task/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();
    return json.decode(jsonString);
  }

  static Map<String, dynamic> get rawTask1 =>
      getJsonFromFile('task1.json') as Map<String, dynamic>;

  static Task get task1 => Task.fromJson(rawTask1);

  static List<Task> get allTasks => [task1, task2, task3];
}
```

### Pattern 2: Repository Unit Tests

**AI Instruction**: Test all Repository methods with mocked DataSource

```dart
// test/features/task/data/task_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_data_source.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/task_mock_models.dart';

class MockTaskDataSource extends Mock implements TaskDataSource {}

void main() {
  late TaskRepository repository;
  late MockTaskDataSource mockDataSource;

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

  group('createTask', () {
    test('returns created task from data source', () async {
      final request = TaskCreateRequest(...);

      when(() => mockDataSource.createTask(any()))
          .thenAnswer((_) async => TaskMockModels.task1);

      final result = await repository.createTask(request);

      expect(result, equals(TaskMockModels.task1));
      verify(() => mockDataSource.createTask(request)).called(1);
    });
  });
}
```

### Pattern 3: DataSource Tests with fromJson

**AI Instruction**: Test DataSource API calls AND fromJson deserialization

```dart
// test/features/task/data/remote_task_data_source_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/data/remote_task_data_source.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/client/api_client.dart';

import '../model/task_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late RemoteTaskDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = RemoteTaskDataSource(mockApiClient);
  });

  group('getTasks', () {
    test('returns list of tasks when API call is successful', () async {
      // Mock API call to use fromJson with raw JSON
      when(
        () => mockApiClient.requestJsonList<Task>(
          method: any(named: 'method'),
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
      verify(
        () => mockApiClient.requestJsonList<Task>(
          method: any(named: 'method'),
          path: '/tasks',
          fromJson: any(named: 'fromJson'),
        ),
      ).called(1);
    });
  });
}
```

### Pattern 4: BLoC Unit Tests

**AI Instruction**: Test all scenarios for each event: success, empty, failure

```dart
// test/features/task/bloc/tasks_list_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

import '../model/task_mock_models.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TasksListBloc bloc;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    bloc = TasksListBloc(mockRepository);
  });

  test('initial state is initial()', () {
    expect(bloc.state, const TasksListState.initial());
  });

  group('on requested() event', () {
    blocTest<TasksListBloc, TasksListState>(
      'emits [loading, success] when getTasks is successful',
      build: () {
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => TaskMockModels.allTasks);
        return bloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () => [
        const TasksListState.loading(),
        TasksListState.success(
          tasks: TaskMockModels.allTasks,
          groupedTasks: {...},  // Expected grouped result
        ),
      ],
    );

    blocTest<TasksListBloc, TasksListState>(
      'emits [loading, success] with empty task list',
      build: () {
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () => [
        const TasksListState.loading(),
        const TasksListState.success(tasks: [], groupedTasks: {}),
      ],
    );

    blocTest<TasksListBloc, TasksListState>(
      'emits [loading, failure] when getTasks fails',
      build: () {
        when(() => mockRepository.getTasks())
            .thenThrow(const NoInternetException());
        return bloc;
      },
      act: (bloc) => bloc.add(const TasksListEvent.requested()),
      expect: () => [
        const TasksListState.loading(),
        const TasksListState.failure(NoInternetException()),
      ],
    );
  });

  group('state helper methods', () {
    test('isLoading returns true for loading state', () {
      const state = TasksListState.loading();
      expect(state.isLoading, true);
    });

    test('isLoading returns false for non-loading states', () {
      const initialState = TasksListState.initial();
      const successState = TasksListState.success(tasks: [], groupedTasks: {});

      expect(initialState.isLoading, false);
      expect(successState.isLoading, false);
    });
  });
}
```

### Pattern 5: Integration Tests

**AI Instruction**: Test full stack with only ApiClient/SharedPreferences mocked

```dart
// test/features/auth/integration/integration_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/data/remote_auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class MockApiClient extends Mock implements ApiClient {}

AuthToken _fakeFromJson(Map<String, dynamic> json) => AuthToken.fromJson(json);

void main() {
  late LoginBloc loginBloc;
  late AuthRepository authRepository;
  late MockApiClient mockApiClient;

  setUpAll(() {
    // Required for any(named:) matchers
    registerFallbackValue(HttpMethod.post);
    registerFallbackValue(_fakeFromJson);
  });

  setUp(() {
    mockApiClient = MockApiClient();
    final unauthorizedDataSource = RemoteAuthUnauthorizedDataSource(mockApiClient);
    authRepository = AuthRepository(
      const RawRepositoryExecutor()
          .withErrorHandling()
          .withRetry(maxRetries: 3, retryDelay: const Duration(seconds: 2)),
      unauthorizedDataSource,
      mockLocalDataSource,
    );
    loginBloc = LoginBloc(authRepository);
  });

  blocTest<LoginBloc, LoginState>(
    'completes full successful flow: BLoC → Repository → DataSource → ApiClient',
    build: () {
      when(
        () => mockApiClient.requestJson<AuthToken>(
          method: any(named: 'method'),
          path: '/auth/login',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((_) async => AuthMockModels.authToken);

      return loginBloc;
    },
    act: (bloc) => bloc.add(LoginEvent.submitted(loginForm)),
    expect: () => [
      const LoginState.loading(),
      const LoginState.success(),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'handles network error through full stack with retry',
    build: () {
      when(
        () => mockApiClient.requestJson<AuthToken>(
          method: any(named: 'method'),
          path: '/auth/login',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(const NoInternetException());

      return loginBloc;
    },
    act: (bloc) => bloc.add(LoginEvent.submitted(loginForm)),
    wait: const Duration(seconds: 15),  // Allow time for retry attempts
    expect: () => [
      const LoginState.loading(),
      const LoginState.failure(NoInternetException()),
    ],
    verify: (_) {
      // Verify retry logic worked (3 retries = 4 total attempts)
      verify(
        () => mockApiClient.requestJson<AuthToken>(
          method: any(named: 'method'),
          path: '/auth/login',
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).called(greaterThan(1));
    },
  );
}
```

**Key Points:**
- Use real Repository and DataSource implementations
- Only mock ApiClient (or SharedPreferences for local storage)
- Register fallback values for HttpMethod and function types
- Add `wait` parameter for tests with retry logic
- Verify full stack behavior including retry attempts

### Pattern 6: Testing toJson Serialization

**AI Instruction**: Test toJson methods for request models

```dart
// test/features/auth/data/remote_auth_unauthorized_data_source_test.dart
group('AuthLoginRequestBody', () {
  test('toJson serializes correctly', () {
    final body = AuthLoginRequestBody(
      phone: '+79991234567',
      password: 'password123',
    );

    final json = body.toJson();

    expect(json['phone'], equals('+79991234567'));
    expect(json['password'], equals('password123'));
    expect(json.length, equals(2));
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
```

---

## Coverage Measurement

**AI Instruction**: Always verify coverage for all classes

### Generate Coverage Report

```bash
# Run tests with coverage
fvm flutter test --coverage

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# View report
open coverage/html/index.html
```

### Current Status (January 2025)

**Test Summary:**
- **145 tests passing** (100% pass rate)
- **Unit Tests**: 111 tests (BLoC, repositories, data sources)
- **Integration Tests**: 34 tests (full-stack flows)

**Integration Test Coverage:**
- ✅ Auth (LoginBloc, RegistrationBloc) - 10 tests
- ✅ Task (CalendarBloc, TasksListBloc, TaskDeleteBloc) - 8 tests
- ✅ Profile (UserBloc) - 1 test
- ✅ Settings (LanguageCubit, ThemeCubit) - 12 tests
- ✅ Application (EnvironmentCubit) - 9 tests

**All BLoCs/Cubits have comprehensive unit and integration test coverage.**

### Test Distribution by Feature

| Feature | Unit Tests | Integration Tests | Total |
|---------|------------|-------------------|-------|
| Task | 19 + 6 (delete) | 2 | 27 |
| Auth | 22 | 10 | 32 |
| Profile | 10 | 1 | 11 |
| Settings | 8 | 12 | 20 |
| Application | 46 | 9 | 55 |
| **TOTAL** | **111** | **34** | **145** |

---

## Testing Checklist

**AI Instruction**: Use this checklist for every feature

### JSON Assets & Mock Models
- [ ] JSON files created in `test/features/{feature}/assets/`
- [ ] Mock model helper created with `getJsonFromFile()`
- [ ] Both `raw{Model}` and `{model}` getters provided

### Repository Tests
- [ ] Test file created: `test/features/{feature}/data/{feature}_repository_test.dart`
- [ ] All CRUD methods tested (create, read, update, delete)
- [ ] Verification of data source calls
- [ ] Coverage verified (100%)

### DataSource Tests
- [ ] Test file created: `test/features/{feature}/data/remote_{feature}_data_source_test.dart`
- [ ] All API methods tested
- [ ] fromJson deserialization exercised
- [ ] toJson serialization tested for request models
- [ ] Coverage verified (80%+)

### BLoC Tests
- [ ] Test file created: `test/features/{feature}/bloc/{bloc}_test.dart`
- [ ] Initial state tested
- [ ] All events tested with success scenario
- [ ] All events tested with empty scenario
- [ ] All events tested with failure scenario
- [ ] All state helper methods tested
- [ ] Coverage verified (100%)

### Integration Tests (Optional)
- [ ] Test file created: `test/features/{feature}/integration/integration_test.dart`
- [ ] Full stack tested (BLoC → Repository → DataSource → ApiClient)
- [ ] End-to-end scenarios validated

### Test Quality
- [ ] All tests pass consistently
- [ ] No real network/database dependencies
- [ ] No flaky tests
- [ ] Tests run quickly (< 5 seconds total per feature)

---

## Common Testing Patterns

### Testing with Fallback Values

```dart
// For complex objects in any() matcher
class FakeUserCreateRequest extends Fake implements UserCreateRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUserCreateRequest());
  });

  test('example', () {
    when(() => mock.createUser(any())).thenAnswer((_) async => mockUser);
  });
}
```

### Testing State Predicates

```dart
// When you need to check state properties, not exact equality
expect: () => [
  const UserListState.loading(),
  predicate<UserListState>(
    (state) => state.maybeWhen(
      success: (users) => users.length == 2,
      orElse: () => false,
    ),
  ),
],
```

### Testing Error Types

```dart
blocTest<UserListBloc, UserListState>(
  'emits failure with NetworkException',
  build: () {
    when(() => helper.service.getUsers())
        .thenThrow(NetworkException('No connection'));
    return bloc;
  },
  act: (bloc) => bloc.add(const UserListEvent.requested()),
  expect: () => [
    const UserListState.loading(),
    predicate<UserListState>(
      (state) => state.maybeWhen(
        failure: (exception) => exception is NetworkException,
        orElse: () => false,
      ),
    ),
  ],
);
```

---

## Related Documentation

- [Architecture](./architecture.md) - Layer structure
- [BLoC & Freezed](./bloc) - BLoC patterns
- [Code Formatting](./code_formatting.md) - Style guide

---

**Last Updated**: November 20, 2025
