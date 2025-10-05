Flutter Testing Guidelines
==========================

This document outlines the standards and best practices for writing tests in this project. The goal is to ensure our codebase is reliable, maintainable, and easy to refactor with confidence.

### 1\. Minimal Test Requirements

To ensure adequate coverage of our business logic, the following is the minimum testing requirement for any new feature:

-   BLoC Integration Test: Every BLoC must have an integration test. This test will use a real instance of the BLoC and a real instance of its Repositorym while the dependencies of the Repository (i.e., Data Sources) will be mocked.

-   Optional Unit Tests: While the BLoC integration test is the minimum, you are encouraged to write unit tests for Bloc, Repository and Data Sources.

### 2\. How to Write a Test

Follow this structure for all BLoC integration tests to ensure consistency and readability.

#### Step 1: Mock Data Sources

Create mock versions of all data sources that the Repository depends on. Use the mocktail package.

##### Step 2: Use Real BLoC and Repository

In your setUp, create real instances of your BLoC and its Repository. Inject the mocked data sources into the real Repository.

##### Step 3: Group by BLoC Events

Organize your tests within a group for each event in your BLoC (e.g., on requested() event).

##### Step 4: Test All Scenarios for Each Event

For every event, create a blocTest for each of these scenarios:

-   Success State: The "happy path" where all dependencies return valid data.

-   Empty State: A successful response that returns an empty list or no data.

-   Error/Failure State: A scenario where a dependency throws an exception.

##### Step 5: Test State Helper Methods

After testing the event logic, add a final group to test any helper methods or getters on your state class (e.g., isLoading, user). This ensures 100% coverage of the state file.

### 3\. How to Calculate Test Coverage

To verify that you are meeting the coverage requirements, you must generate an HTML report. Follow these steps in your terminal from the project's root directory.

* Step 1: Generate Coverage Data with command that runs all tests and creates a coverage/lcov.info file with the raw data.
  `flutter test --coverage`

* Step 2: Install LCOV (If you don't have it) by running
  `brew install lcov`

* Generate the HTML Report by running

  `genhtml coverage/lcov.info -o coverage/html`

* Step 4: Open the index.html file in your browser to see the detailed report.

  `open coverage/html/index.html`

### 4\. Test Quality Requirements

All tests must adhere to the following standards:

1.  Fast Execution: Tests must be fast. The entire test suite for a single class should complete in less than one second.

2.  High Coverage: Aim for 100% test coverage for all BLoCs and Repositories. Use the coverage generation commands to verify this. Generated files (.g.dart) should be excluded from the report.

3.  Independence: Tests must be completely independent of external conditions. They must not rely on a running backend, local database, or network connection. All external dependencies must be mocked.

4.  Reliability: A test must consistently pass if the underlying code is correct and consistently fail if the code is incorrect.

### 5\. Testing Workflow

To prevent regressions (where a new feature breaks an existing one), you must run the entire project's test suite after implementing any significant change or new feature.

`flutter test --coverage`

All tests must pass before a pull request can be merged.

### Example Test: UserBloc

Here is an example of a BLoC integration test that follows all the guidelines mentioned above.

```
// 1. Mock Data Sources
class MockAuthorizedDataSource extends Mock
    implements AuthAuthorizedDataSource {}

class MockUnauthorizedDataSource extends Mock
    implements AuthUnauthorizedDataSource {}

class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late UserBloc userBloc;
  late MockAuthorizedDataSource authorizedDataSource;
  late MockUnauthorizedDataSource unauthorizedDataSource;
  late MockLocalDataSource localDataSource;
  late AuthRepository authRepository;

  setUp(() {
    // 2. Use Real BLoC and Repository
    authorizedDataSource = MockAuthorizedDataSource();
    unauthorizedDataSource = MockUnauthorizedDataSource();
    localDataSource = MockLocalDataSource();
    authRepository = AuthRepository(
      const RetriableRepositoryExecutor(),
      authorizedDataSource,
      unauthorizedDataSource,
      localDataSource,
    );
    userBloc = UserBloc(authRepository);
  });

  test('initial state is initial()', () {
    expect(userBloc.state, const UserState.initial());
  });

  // 3. Group by BLoC Events
  group(
    'on requested() event',
    () {
      const event = UserEvent.requested();
      final user = AuthMockModels.user;
      const exception = AuthException('Auth failed');

      // 4. Test Scenarios (Success and Failure)
      blocTest<UserBloc, UserState>(
        'emits [success] when getUserProfile is successful.',
        build: () {
          when(() => authorizedDataSource.getUserProfile())
              .thenAnswer((_) async => user);
          return userBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          UserState.success(user: user),
        ],
        verify: (_) {
          verify(() => authorizedDataSource.getUserProfile()).called(1);
        },
      );

      blocTest<UserBloc, UserState>(
        'emits [failure] when getUserProfile throws an exception.',
        build: () {
          when(() => authorizedDataSource.getUserProfile())
              .thenThrow(exception);
          return userBloc;
        },
        act: (bloc) => bloc.add(event),
        expect: () => [
          const UserState.failure(exception),
        ],
        verify: (_) {
          verify(() => authorizedDataSource.getUserProfile()).called(1);
        },
      );
    },
  );

  // 5. Test State Helper Methods
  group('state helper methods', () {
    const initialState = UserState.initial();
    const failureState = UserState.failure(AuthException('Auth failed'));
    final successState = UserState.success(user: AuthMockModels.user);

    test('user returns user for success state', () {
      expect(successState.user, AuthMockModels.user);
    });

    test('user returns null for other states', () {
      expect(initialState.user, isNull);
      expect(failureState.user, isNull);
    });
  });
}
```