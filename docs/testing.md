# Testing Guide

> **AI Context**: Testing strategy for Flutter project with BLoC pattern. Every BLoC must have integration tests. Write unit tests for classes with logic.

## Core Testing Strategy

**AI Instruction**: Two types of tests - integration tests for BLoC stack, unit tests for logic

### 1. BLoC Integration Tests (Required)

**AI Instruction**: Test entire BLoC → Repository → DataSource → Service chain with only Service mocked

```
BLoC (Real) → Repository (Real) → DataSource (Real) → Service (Mock)
```

**Minimum**: Every BLoC must have integration tests covering all events and states.

### 2. Unit Tests (Conditional)

**AI Instruction**: Write unit tests when class has logic beyond simple delegation

**Write unit tests for:**
- Service: Always test API serialization/deserialization
- DataSource: When has transformation logic or error handling
- Repository: When has complex coordination or business logic
- State helpers: Test custom getters/methods

**Don't write unit tests when:**
- Class only delegates to another (e.g., simple Repository)
- No logic to test

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

## BLoC Integration Test Pattern

**AI Instruction**: Follow this exact pattern for all BLoC tests

### Step 1: Create Mock Models Helper

```dart
// test/features/user/helpers/user_mock_models.dart
class UserMockModels {
  static Map<String, dynamic> get rawUserListJson => {
    'users': [
      {'id': '1', 'name': 'John'},
      {'id': '2', 'name': 'Jane'}
    ]
  };

  static List<User> get userList => [
    const User(id: '1', name: 'John'),
    const User(id: '2', name: 'Jane'),
  ];

  static const emptyUserList = <User>[];
}
```

### Step 2: Create Integration Test Helper

```dart
// test/features/user/helpers/user_integration_test_helper.dart
class MockUserService extends Mock implements UserService {}

class UserIntegrationTestHelper {
  late UserService service;
  late UserDataSource dataSource;
  late UserRepository repository;

  void setUp() {
    service = MockUserService();
    dataSource = RemoteUserDataSource(service);
    repository = UserRepository(dataSource);
  }
}
```

### Step 3: Write BLoC Tests

**AI Instruction**: Test all scenarios for each event: success, empty, failure

```dart
// test/features/user/ui/list/bloc/user_list_bloc_test.dart
void main() {
  late UserListBloc bloc;
  final helper = UserIntegrationTestHelper();

  setUp(() {
    helper.setUp();
    bloc = UserListBloc(helper.repository);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is UserListState.initial()', () {
    expect(bloc.state, const UserListState.initial());
  });

  group('on requested event', () {
    const event = UserListEvent.requested();

    blocTest<UserListBloc, UserListState>(
      'emits [loading, success] when getUsers returns data',
      build: () {
        when(() => helper.service.getUsers())
            .thenAnswer((_) async => UserMockModels.userList);
        return bloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const UserListState.loading(),
        UserListState.success(UserMockModels.userList),
      ],
    );

    blocTest<UserListBloc, UserListState>(
      'emits [loading, success with empty] when getUsers returns empty list',
      build: () {
        when(() => helper.service.getUsers())
            .thenAnswer((_) async => UserMockModels.emptyUserList);
        return bloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const UserListState.loading(),
        const UserListState.success([]),
      ],
    );

    blocTest<UserListBloc, UserListState>(
      'emits [loading, failure] when getUsers throws exception',
      build: () {
        when(() => helper.service.getUsers())
            .thenThrow(Exception('Network error'));
        return bloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const UserListState.loading(),
        predicate<UserListState>(
          (state) => state.maybeWhen(
            failure: (exception) => exception is Exception,
            orElse: () => false,
          ),
        ),
      ],
    );
  });

  group('state helper methods', () {
    const initialState = UserListState.initial();
    const loadingState = UserListState.loading();
    final failureState = UserListState.failure(Exception('Error'));
    final successState = UserListState.success(UserMockModels.userList);

    test('isLoading returns correct values', () {
      expect(loadingState.isLoading, true);
      expect(initialState.isLoading, false);
      expect(failureState.isLoading, false);
      expect(successState.isLoading, false);
    });

    test('hasData returns correct values', () {
      expect(successState.hasData, true);
      expect(initialState.hasData, false);
      expect(loadingState.hasData, false);
      expect(failureState.hasData, false);
    });
  });
}
```

---

## Service Unit Test Pattern

**AI Instruction**: Always write unit tests for Service classes

### Example: Testing Retrofit Service

```dart
// test/features/user/data/user_service_test.dart
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late UserService userService;

  const baseUrl = 'https://api.example.com/';

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    dioAdapter = DioAdapter(dio: dio);
    userService = UserService(dio);
  });

  group('getUsers', () {
    test('returns List<User> on successful request', () async {
      dioAdapter.onGet(
        'users',
        (server) => server.reply(200, UserMockModels.rawUserListJson),
      );

      final result = await userService.getUsers();

      expect(result, isA<List<User>>());
      expect(result.length, 2);
      expect(result[0].name, 'John');
    });

    test('throws DioException on 500 error', () async {
      dioAdapter.onGet(
        'users',
        (server) => server.reply(500, {'message': 'Server error'}),
      );

      expect(
        () => userService.getUsers(),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('createUser', () {
    final requestBody = UserCreateRequest(name: 'Bob');
    final mockResponse = {'id': '3', 'name': 'Bob'};

    test('returns created User on successful request', () async {
      dioAdapter.onPost(
        'users',
        (server) => server.reply(201, mockResponse),
        data: requestBody.toJson(),
      );

      final result = await userService.createUser(requestBody);

      expect(result, isA<User>());
      expect(result.name, 'Bob');
    });

    test('throws DioException on 400 validation error', () async {
      dioAdapter.onPost(
        'users',
        (server) => server.reply(400, {'message': 'Invalid name'}),
        data: requestBody.toJson(),
      );

      expect(
        () => userService.createUser(requestBody),
        throwsA(isA<DioException>()),
      );
    });
  });
}
```

---

## DataSource Unit Test Pattern

**AI Instruction**: Write unit tests for DataSource only when it has transformation or error handling logic

### Example: DataSource with Transformation

```dart
// test/features/user/data/remote_user_data_source_test.dart
class MockUserService extends Mock implements UserService {}

void main() {
  late MockUserService mockService;
  late RemoteUserDataSource dataSource;

  setUp(() {
    mockService = MockUserService();
    dataSource = RemoteUserDataSource(mockService);
  });

  group('getUsers', () {
    test('returns transformed users from service', () async {
      when(() => mockService.getUsers())
          .thenAnswer((_) async => UserMockModels.userList);

      final result = await dataSource.getUsers();

      expect(result, isA<List<User>>());
      expect(result.length, 2);
      verify(() => mockService.getUsers()).called(1);
    });

    test('throws AppException when service throws DioException', () async {
      when(() => mockService.getUsers()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'users'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: 'users'),
          ),
        ),
      );

      expect(
        () => dataSource.getUsers(),
        throwsA(isA<AppException>()),
      );
    });
  });

  group('createUser', () {
    final requestBody = UserCreateRequest(name: 'Bob');
    final mockUser = const User(id: '3', name: 'Bob');

    test('creates user and returns result', () async {
      when(() => mockService.createUser(requestBody))
          .thenAnswer((_) async => mockUser);

      final result = await dataSource.createUser(requestBody);

      expect(result, mockUser);
      verify(() => mockService.createUser(requestBody)).called(1);
    });

    test('handles 404 by returning null', () async {
      when(() => mockService.createUser(requestBody)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'users'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: 'users'),
          ),
        ),
      );

      final result = await dataSource.createUser(requestBody);

      expect(result, isNull);
    });
  });
}
```

### Example: Simple DataSource (No Unit Test Needed)

```dart
// This DataSource just delegates, no unit test needed
// It's already tested by BLoC integration tests
class RemoteUserDataSource implements UserDataSource {
  final UserService _service;
  const RemoteUserDataSource(this._service);

  @override
  Future<List<User>> getUsers() => _service.getUsers();

  @override
  Future<User> createUser(UserCreateRequest request) =>
      _service.createUser(request);
}
```

---

## Coverage Measurement

**AI Instruction**: Always verify 100% coverage for logic classes

### Generate Coverage Report

```bash
# Run tests with coverage
fvm flutter test --coverage

# Install lcov (macOS)
brew install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# View report
open coverage/html/index.html
```

### Coverage Targets

| Class Type | Target | Required Tests |
|------------|--------|----------------|
| BLoC | 100% | Integration tests |
| Service | 100% | Unit tests |
| DataSource (with logic) | 100% | Unit tests |
| DataSource (simple) | N/A | Covered by integration |
| Repository (with logic) | 100% | Unit tests |
| Repository (simple) | N/A | Covered by integration |
| State helpers | 100% | Tested in BLoC tests |

---

## Testing Checklist

**AI Instruction**: Use this checklist for every feature

### BLoC Tests
- [ ] Integration test helper created
- [ ] Mock models helper created
- [ ] Initial state tested
- [ ] All events tested with success scenario
- [ ] All events tested with empty scenario
- [ ] All events tested with failure scenario
- [ ] All state helper methods tested
- [ ] Coverage verified (100%)

### Service Tests
- [ ] All methods tested with success response
- [ ] All methods tested with error responses (400, 404, 500)
- [ ] Request serialization tested
- [ ] Response deserialization tested
- [ ] Coverage verified (100%)

### DataSource Tests (if has logic)
- [ ] All methods tested with success
- [ ] Error handling tested
- [ ] Transformations tested
- [ ] Coverage verified (100%)

### Test Quality
- [ ] All tests pass consistently
- [ ] Test suite runs in < 1 second per class
- [ ] No real network/database dependencies
- [ ] No flaky tests

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
- [BLoC & Freezed](./bloc_freezed.md) - BLoC patterns
- [Code Formatting](./code_formatting.md) - Style guide

---

**Last Updated**: January 18, 2025
