# Flutter Testing Guidelines

> **AI Context**: This document defines the testing strategy and standards for this Flutter project. It covers integration testing for the BLoC-Repository-DataSource stack, unit testing for services, test quality requirements, code coverage measurement, and practical examples using `bloc_test`, `mocktail`, and `http_mock_adapter`. All tests must be fast (<1 second per class), independent (no real network/database), and aim for 100% coverage of business logic.

---

This document outlines the standards and best practices for writing tests in this project. The goal is to ensure our codebase is reliable, maintainable, and easy to refactor with confidence.

## 1. Our Core Testing Strategy

We divide our logic into two categories, each with its own testing approach. The goal is to achieve nearly 100% coverage for these classes.

### a. Unit Tests

Unit tests focus on testing individual classes or methods in isolation. All external dependencies are mocked to ensure the test runs independently.

### b. Integration Tests for the BLoC Stack

BLoC, Repository, and DataSource work together as a single unit to manage application state. We test them jointly to verify the entire data flow from user events to state changes.

**Minimum Requirement**: Every BLoC must have an integration test that covers its interaction with real Repository and DataSource instances. The deepest dependency of the DataSource (e.g., Service or local storage) is mocked.

```
BLoC (Real) -> Repository (Real) -> DataSource (Real) -> Service (Mock)
```

**Note**: If a BLoC depends on Repositories from other features (e.g., CoreRepository), you can mock them because they should be tested in their respective features.

**Conditional Unit Tests**: While integration testing is primary, you should also write unit tests for Repository or DataSource if they contain complex logic that goes beyond simple method calls.

## 2. How to Calculate Test Coverage

Verifying coverage requirements is mandatory.

**Step 1: Collect Coverage Data**
Run the following command to execute all tests and generate raw coverage data at `coverage/lcov.info`:

```bash
flutter test --coverage
```

**Step 2: Install LCOV (if not installed)**

```bash
brew install lcov
```

**Step 3: Generate HTML Report**
Run this command to create a user-friendly HTML report:

```bash
genhtml coverage/lcov.info -o coverage/html
```

**Step 4: View the Report**
Open the index.html file in your browser to see the detailed report:

```bash
open coverage/html/index.html
```

## 3. Test Quality Requirements

All tests must meet these standards:

**Fast Execution**: Tests should be very fast. The entire test suite for a single class should run in less than one second.

**High Coverage**: Aim for 100% test coverage for all BLoCs, Repositories, DataSources, and Services. Use the coverage report to identify and eliminate gaps.

**Independence**: Tests cannot depend on a running backend, local database, or network connection. All external dependencies must be mocked.

**Reliability**: A test should consistently pass if the code is correct, and consistently fail if the code is incorrect. "Flaky" tests are unacceptable.

## 4. Required Packages and Useful Methods

### a. Development Dependencies (dev_dependencies)

Add the following packages to your pubspec.yaml file:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.5
  mocktail: ^1.0.1
  http_mock_adapter: ^0.6.1
```

**bloc_test**: Simplifies BLoC testing by providing the blocTest function.

**mocktail**: A powerful and simple library for creating mocks.

**http_mock_adapter**: Allows easy mocking of HTTP requests when using the Dio client.

### b. Core Methods and Functions

Here are the most commonly used functions you'll need:

**From flutter_test**

`group(description, body)`: Groups multiple tests into one block. Helps organize tests.

`test(description, body)`: Defines an individual test.

`setUp(body)`: Runs before each test in a group. Ideal for initializing objects.

`tearDown(body)`: Runs after each test. Used for cleaning up resources.

`expect(actual, matcher)`: Asserts that the actual value matches the expected matcher.

**From mocktail**

`class MockMyService extends Mock implements MyService {}`: Creates a mock class.

`when(() => mock.someMethod(any())).thenAnswer((_) async => ...)`: Sets the behavior of a mock object for an async method when called with any arguments.

`when(() => mock.someMethod()).thenThrow(Exception())`: Sets the mock to throw an exception when the method is called.

`verify(() => mock.someMethod()).called(1)`: Verifies that the method was called exactly once.

`registerFallbackValue(MyFakeObject())`: Registers a "fallback" value for complex objects that cannot be matched with any().

**From bloc_test**

`blocTest(description, build: ..., act: ..., expect: ..., verify: ...)`: Main function for testing BLoCs.

`build`: Returns an instance of the BLoC for the test.

`act`: Function that takes the BLoC and adds events to it.

`expect`: Returns a list of states that the BLoC should emit in response to the event.

`verify`: Function to verify that dependency methods were called (e.g., from repository).

## 5. How to Write an Integration Test for the BLoC Stack

Follow this structured approach to keep your tests for BLoCs and their dependencies consistent.

**Step 1: Create Helper Classes for Mock Data**

Centralize your mock data and models in a separate file (e.g., mock_models.dart). This keeps your test files clean and allows easy reuse of test data, often loaded from JSON files in the test/assets directory.

```dart
class SocialFundMockModels {
  static dynamic getJsonFromFile(String fileName) {
    const basePath = 'test/social_fund/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();

    return json.decode(jsonString);
  }

  static Map<String, dynamic> get rawSocialFundBudgetClassifications =>
      getJsonFromFile('social_fund_budget_classification_list.json')
          as Map<String, dynamic>;

  static SocialFundBudgetClassificationList
      get socialFundBudgetClassifications =>
          SocialFundBudgetClassificationList.fromJson(
            rawSocialFundBudgetClassifications,
          );
}
```

**Step 2: Create a Helper Class for Dependency Injection**

To avoid repetitive setup code in your test files, create a helper class that instantiates your BLoC's dependency chain. This class will use real instances of DataSource and Repository, while mocking the Service and Repositories from other features if the BLoC depends on them.

```dart
class MockSocialFundService extends Mock implements SocialFundService {}

class SocialFundIntegrationTestHelper {
  late SocialFundService socialFundService;
  late SocialFundProvider socialFundProvider;
  late SocialFundRepository repository;

  void setUp() {
    socialFundService = MockSocialFundService();
    socialFundProvider = RemoteSocialFundProvider(socialFundService);
    repository = SocialFundRepository(socialFundProvider);
  }
}
```

**Step 3: Set Up the Test File for BLoC**

In your _test.dart file, use the helper class to set up the BLoC instance. Use setUp and tearDown for initialization and cleanup.

```dart
void main() {
  late SocialFundDebtsBloc bloc;
  final helper = SocialFundIntegrationTestHelper();

  registerFallbackValue(
    FakeSocialFundDebtsRequestBody(),
  );

  setUp(() {
    helper.setUp();
    bloc = SocialFundDebtsBloc(helper.repository);
  });

  tearDown(() {
    bloc.close();
  });
}
```

**Step 4: Test All Scenarios for Each Event**

For each BLoC event, write a blocTest for each possible outcome:

**Success State**: The "happy path" when dependencies return correct data.

**Empty State**: A successful response that returns an empty list or no data.

**Error State**: A scenario where the dependency throws an exception.

```dart
test('initial state is SocialFundDebtsState.initial()', () {
  expect(bloc.state, const SocialFundDebtsState.initial());
});

group('on requested event', () {
  final debtsForm = SocialFundMockModels.socialFundDebtsForm;
  final event = SocialFundDebtsEvent.requested(debtsForm);
  final requestBody = debtsForm.toRequestBody();

  blocTest<SocialFundDebtsBloc, SocialFundDebtsState>(
    'emits [loading, success with data] when getDebts returns data',
    build: () {
      when(() => helper.socialFundProvider.getDebts(requestBody))
          .thenAnswer((_) async => debts);
      return bloc;
    },
    act: (bloc) => bloc.add(event),
    expect: () => [
      const SocialFundDebtsState.loading(),
      SocialFundDebtsState.success(debts.data),
    ],
  );

  blocTest<SocialFundDebtsBloc, SocialFundDebtsState>(
    'emits [loading, success with empty list] when getDebts returns 404',
    build: () {
      when(
        () => helper.socialFundProvider
            .getDebts(any(that: isA<SocialFundDebtsRequestBody>())),
      ).thenThrow(MockExceptions.notFoundException);
      return bloc;
    },
    act: (bloc) => bloc.add(
      SocialFundDebtsEvent.requested(
        SocialFundMockModels.socialFundDebtsForm,
      ),
    ),
    expect: () => [
      const SocialFundDebtsState.loading(),
      const SocialFundDebtsState.success([]),
    ],
  );

  blocTest<SocialFundDebtsBloc, SocialFundDebtsState>(
    'emits [loading, failure] when getDebts throws a generic Exception',
    build: () {
      when(
        () => helper.socialFundProvider
            .getDebts(any(that: isA<SocialFundDebtsRequestBody>())),
      ).thenThrow(MockExceptions.defaultException);
      return bloc;
    },
    act: (bloc) => bloc.add(event),
    expect: () => [
      const SocialFundDebtsState.loading(),
      predicate<SocialFundDebtsState>(
        (state) => state.maybeWhen(
          failure: (exception) => exception is Exception,
          orElse: () => false,
        ),
      ),
    ],
  );
});
```

**Step 5: Test State Helper Methods**

Add a final group to test any helper methods or getters in your state class (e.g., isLoading). This ensures 100% coverage of the state file.

```dart
group('bloc state helper methods', () {
  const initialState = SocialFundDebtsState.initial();
  const loadingState = SocialFundDebtsState.loading();
  final failureState = SocialFundDebtsState.failure(Exception('Error'));
  final successState = SocialFundDebtsState.success(debts.data);

  test('isLoading true when state is loading and false otherwise', () {
    expect(loadingState.isLoading, true);
    expect(initialState.isLoading, false);
    expect(failureState.isLoading, false);
    expect(successState.isLoading, false);
  });
});
```

## 6. How to Write a Unit Test for a Service

A unit test for a Service class completely isolates it by mocking its HTTP client (e.g., Dio). This allows us to test request serialization logic and response parsing without making real network calls.

**Step 1: Set Up the Service and Mock Client**

In your test's setUp, instantiate the real Service and inject a mocked version of its HTTP client. You can mock the client using http_mock_adapter or mocktail.

```dart
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late SocialFundService socialFundService;

  const baseUrl = 'https://api.example.com/';

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    dioAdapter = DioAdapter(dio: dio);

    socialFundService = SocialFundService(dio);
  });
}
```

**Step 2: Group by Methods and Test Scenarios**

For each public method in the service, create a group. Inside this group, test the successful ("happy path") and failure scenarios.

**Success Test**: Configure the mock client to return a successful status code (e.g., 200) with a correct JSON body. Ensure your service method returns a properly parsed data model.

**Failure Test**: Configure the mock client to return an error code (e.g., 400, 500). Ensure your service method throws the expected exception (e.g., DioException or custom exception).

```dart
group('initializePayment', () {
  test('returns SocialFundPaymentParams on successful request', () async {
    dioAdapter.onPost(
      'gns-tunduk/api/v1/gns-tax-payment/create-insurance-payment',
      (server) => server.reply(200, mockPaymentParamsJson),
      data: paymentRequestBody,
    );

    final result =
        await socialFundService.initializePayment(paymentRequestBody);

    expect(result, isA<SocialFundPaymentParams>());
    expect(result.transactionId, mockPaymentParams.transactionId);
  });

  test('throws DioException on failure', () async {
    dioAdapter.onPost(
      'gns-tunduk/api/v1/gns-tax-payment/create-insurance-payment',
      (server) => server.reply(400, {'message': 'Invalid TIN'}),
      data: paymentRequestBody,
    );

    expect(
      () => socialFundService.initializePayment(paymentRequestBody),
      throwsA(isA<DioException>()),
    );
  });
});
```
