# Exception Handling & Repository Executors

> **AI Context**: Comprehensive guide for custom exceptions, exception mappers, and repository executors.

## Table of Contents

1. [Exception Handling](#exception-handling)
2. [Repository Executors](#repository-executors)

---

# Exception Handling

## Architecture

Two-layer exception system:
- **Data Layer** (`starter_toolkit`): Pure Dart `AppException` sealed classes with `@ExceptionUiConfig` annotations
- **UI Layer** (`starter_uikit`): `ExceptionUiModel` with localized messages

**Benefits**: No BuildContext in data layer, type-safe exhaustive pattern matching, decorator extensibility, code generation.

### Data Layer: AppException

```dart
sealed class AppException implements Exception {
  const AppException();
  String get name;
  bool get canRetry;
}

@ExceptionUiConfig(
  titleKey: 'errorMessageNoConnection',
  descriptionKey: 'errorMessageCouldNotConnectServer',
  snackbarKey: 'errorMessageNoConnection',
)
final class NoInternetException extends AppException {
  const NoInternetException();

  @override
  String get name => 'NoInternet';

  @override
  bool get canRetry => true;
}

@ExceptionUiConfig(
  titleKey: 'errorMessageErrorWhileRequesting',
  descriptionKey: 'errorMessageDefaultRequestError',
)
final class ServerException extends AppException {
  const ServerException({required this.statusCode, this.message});

  final int? statusCode;
  final String? message;

  @override
  String get name => 'Server';

  @override
  bool get canRetry => true;
}
```

### UI Layer: ExceptionUiModel

```dart
class ExceptionUiModel extends Equatable {
  final String? title;
  final String description;
  final String? snackbarDescription;
  final bool canRetry;
  final bool canRefresh;

  const ExceptionUiModel({
    this.title,
    required this.description,
    this.snackbarDescription,
    this.canRetry = false,
    this.canRefresh = false,
  });

  factory ExceptionUiModel.simple({
    required String description,
    bool canRetry = false,
  }) => ExceptionUiModel(description: description, canRetry: canRetry);
}
```

### Mapper: ExceptionUiMapper

Auto-generated using switch expressions for exhaustive pattern matching:

```dart
class ExceptionUiMapper {
  final BuildContext context;
  late final UiLocalizer _localizer;

  ExceptionUiMapper(this.context) {
    _localizer = UiLocalizer.of(context);
  }

  ExceptionUiModel map(AppException exception) {
    return switch (exception) {
      NoInternetException() => mapNoInternet(),
      ServerException(statusCode: final statusCode, message: final message) =>
        mapServer(statusCode, message),
      UnauthorizedException(message: final message) => mapUnauthorized(message),
    };
  }

  @protected
  ExceptionUiModel mapNoInternet() {
    return ExceptionUiModel(
      description: _localizer.errorMessageCouldNotConnectServer,
      snackbarDescription: _localizer.errorMessageNoConnection,
      title: _localizer.errorMessageNoConnection,
      canRetry: true,
    );
  }

  @protected
  ExceptionUiModel mapServer(int? statusCode, String? message) {
    return ExceptionUiModel(
      description: message ?? _localizer.errorMessageDefaultRequestError,
      title: _localizer.errorMessageErrorWhileRequesting,
      canRetry: true,
    );
  }
}
```

---

## When to Add Exceptions

### ✅ Add when:
- New error type not covered (payment failure, biometric failure, session expired)
- Feature-specific error with custom UI requirements
- Distinct user action needed (retry with different params, redirect to settings)

### ❌ Don't add for:
- Minor variations → use parameters: `ServerException(statusCode: 404)` not `Server404Exception`
- Debugging → use logging
- Non-error states → use BLoC states: `State.loading()` not `LoadingException`

---

## Adding Custom Exception

**Example: PaymentFailedException**

**Step 1: Add exception class**

```dart
// packages/starter_toolkit/lib/data/exceptions/app_exception.dart
@ExceptionUiConfig(descriptionKey: 'paymentFailed', canRetry: true)
final class PaymentFailedException extends AppException {
  const PaymentFailedException({this.paymentMethod, this.errorCode});

  final String? paymentMethod;
  final String? errorCode;

  @override
  String get name => 'PaymentFailed';

  @override
  bool get canRetry => true;
}
```

**Step 2: Add localization**

```json
// lib/l10n/intl_ru.arb
{
  "paymentFailed": "Ошибка при обработке платежа. Попробуйте другой способ оплаты.",
  "insufficientFunds": "Недостаточно средств",
  "cardDeclined": "Карта отклонена"
}
```

**Step 3: Generate code**

```bash
dart run tool/generate_exception_mapper.dart
fvm flutter --no-color pub global run intl_utils:generate
```

**Step 4: Throw in data source**

```dart
class RemotePaymentDataSource implements PaymentDataSource {
  @override
  Future<Payment> processPayment(PaymentRequest request) async {
    try {
      return await _client.requestJson<Payment>(
        method: HttpMethod.post,
        path: '/payments',
        body: request.toJson(),
        fromJson: Payment.fromJson,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 402) {
        throw PaymentFailedException(
          paymentMethod: request.method,
          errorCode: e.response?.data['error_code'],
        );
      }
      rethrow;
    }
  }
}
```

**Step 5: Display in UI**

```dart
BlocBuilder<PaymentBloc, PaymentState>(
  builder: (context, state) => switch (state) {
    PaymentProcessingState() => const CircularProgressIndicator(),
    PaymentFailureState(:final exception) => Builder(
      builder: (context) {
        final uiModel = ExceptionUiMapper(context).map(exception);
        return FailureWidgetLarge(
          uiModel: uiModel,
          onRetry: () => context.read<PaymentBloc>().add(const PaymentEvent.retry()),
        );
      },
    ),
    PaymentSuccessState(:final payment) => PaymentSuccessView(payment),
    _ => const SizedBox.shrink(),
  },
)
```

---

## Common Patterns

### Exception with Context

```dart
@ExceptionUiConfig(descriptionKey: 'fileUploadFailed', canRetry: true)
final class FileUploadFailedException extends AppException {
  const FileUploadFailedException({
    required this.fileName,
    required this.fileSize,
    this.reason,
  });

  final String fileName;
  final int fileSize;
  final String? reason;

  @override
  String get name => 'FileUploadFailed';

  @override
  bool get canRetry => true;
}
```

### Exception with Validation

```dart
@ExceptionUiConfig(descriptionKey: 'validationFailed', canRetry: false)
final class ValidationFailedException extends AppException {
  const ValidationFailedException({required this.fieldErrors});

  final Map<String, String> fieldErrors;

  @override
  String get name => 'ValidationFailed';

  @override
  bool get canRetry => false;
}
```

### Exception with Retry Strategy

```dart
@ExceptionUiConfig(descriptionKey: 'rateLimitExceeded', canRetry: true)
final class RateLimitExceededException extends AppException {
  const RateLimitExceededException({required this.retryAfter});

  final Duration retryAfter;

  @override
  String get name => 'RateLimitExceeded';

  @override
  bool get canRetry => true;
}
```

---

## Feature-Specific Mappers

Extend `ExceptionUiMapperDecorator` for custom messages:

```dart
class PaymentExceptionMapper extends ExceptionUiMapperDecorator {
  PaymentExceptionMapper(super.context, super.wrapped);

  @override
  ExceptionUiModel mapPaymentFailed(String? paymentMethod, String? errorCode) {
    if (errorCode == 'insufficient_funds') {
      return ExceptionUiModel.simple(
        description: UiLocalizer.of(context).insufficientFunds,
        canRetry: false,
      );
    }
    return super.mapPaymentFailed(paymentMethod, errorCode);
  }
}
```

---

## Testing

### Test Exception

```dart
void main() {
  test('creates exception with parameters', () {
    const exception = PaymentFailedException(
      paymentMethod: 'credit_card',
      errorCode: 'insufficient_funds',
    );

    expect(exception.paymentMethod, equals('credit_card'));
    expect(exception.errorCode, equals('insufficient_funds'));
    expect(exception.canRetry, isTrue);
  });
}
```

### Test Mapper

```dart
void main() {
  late ExceptionUiMapper mapper;

  setUp(() => mapper = ExceptionUiMapper(MockBuildContext()));

  test('maps exception with error code', () {
    const exception = PaymentFailedException(errorCode: 'card_declined');
    final uiModel = mapper.map(exception);

    expect(uiModel.description, isNotEmpty);
    expect(uiModel.canRetry, isTrue);
  });
}
```

---

# Repository Executors

## Overview

Decorator pattern for adding cross-cutting concerns (error handling, retry, caching, logging) without modifying repositories.

**Benefits**: Composable, no duplication, testable in isolation, memory leak prevention.

---

## Built-in Executors

### RawRepositoryExecutor
Base executor - starting point for all chains.

```dart
final executor = RawRepositoryExecutor();
```

### ErrorHandlingExecutor
Normalizes all errors to `AppException`.

```dart
final executor = RawRepositoryExecutor().withErrorHandling();
```

**Converts**: `DioException` → `NoInternetException`/`ServerException`, `SocketException` → `NoInternetException`, Unknown → `UnknownException`

### RetryExecutor
Automatic retry with exponential backoff.

```dart
final executor = RawRepositoryExecutor()
  .withErrorHandling()
  .withRetry(maxRetries: 3, retryDelay: Duration(seconds: 2));
```

**Backoff**: 2s, 4s, 8s...

### CachingExecutor
Time-based caching with auto cleanup.

```dart
final executor = RawRepositoryExecutor()
  .withErrorHandling()
  .withCaching(defaultTtl: Duration(minutes: 5));

// Use cached() method
final data = await executor.cached(
  () => _dataSource.getData(),
  key: 'user_list',
  ttl: Duration(minutes: 10),
);
```

---

## When to Create Executors

### ✅ Create when:
- Shared behavior across repositories (logging, analytics, rate limiting)
- Cross-cutting concern (performance monitoring, circuit breaker)
- Reusable decorator that can be composed

### ❌ Don't create for:
- Feature-specific logic → belongs in Repository
- One-time operations → use regular methods
- UI concerns → belongs in BLoC/widgets

---

## Creating Custom Executor

**Example: LoggingExecutor**

**Step 1: Create class**

```dart
// packages/starter_toolkit/lib/data/repository_executor/logging_executor.dart
import 'package:logger/logger.dart';

class LoggingExecutor extends RepositoryExecutor {
  final RepositoryExecutor _wrapped;
  final Logger _logger;

  LoggingExecutor(this._wrapped, {Logger? logger})
      : _logger = logger ?? Logger();

  @override
  Future<T> execute<T>(Future<T> Function() operation) async {
    final stopwatch = Stopwatch()..start();
    _logger.d('Repository operation started');

    try {
      final result = await _wrapped.execute(operation);
      stopwatch.stop();
      _logger.i('Completed in ${stopwatch.elapsedMilliseconds}ms');
      return result;
    } catch (e) {
      stopwatch.stop();
      _logger.e('Failed after ${stopwatch.elapsedMilliseconds}ms', error: e);
      rethrow;
    }
  }

  @override
  Future<T> cached<T>(
    Future<T> Function() operation, {
    required String key,
    Duration? ttl,
  }) async {
    _logger.d('Cached operation: $key');
    return await _wrapped.cached(operation, key: key, ttl: ttl);
  }
}
```

**Step 2: Add extension**

```dart
extension RepositoryExecutorExtensions on RepositoryExecutor {
  RepositoryExecutor withLogging({Logger? logger}) =>
      LoggingExecutor(this, logger: logger);
}
```

**Step 3: Use in DI**

```dart
getIt.registerFactory<RepositoryExecutor>(() {
  return RawRepositoryExecutor()
    .withErrorHandling()
    .withLogging()
    .withRetry()
    .withCaching();
});
```

---

## Common Patterns

### Rate Limiting

```dart
class RateLimitingExecutor extends RepositoryExecutor {
  final RepositoryExecutor _wrapped;
  final int _maxRequests;
  final Duration _period;
  final Queue<DateTime> _requestTimes = Queue();

  RateLimitingExecutor(
    this._wrapped, {
    int maxRequests = 10,
    Duration period = const Duration(seconds: 1),
  })  : _maxRequests = maxRequests,
        _period = period;

  @override
  Future<T> execute<T>(Future<T> Function() operation) async {
    await _waitIfNeeded();
    _requestTimes.add(DateTime.now());
    return await _wrapped.execute(operation);
  }

  Future<void> _waitIfNeeded() async {
    _cleanOldRequests();
    if (_requestTimes.length >= _maxRequests) {
      final oldestRequest = _requestTimes.first;
      final waitTime = _period - DateTime.now().difference(oldestRequest);
      if (!waitTime.isNegative) {
        await Future.delayed(waitTime);
        _cleanOldRequests();
      }
    }
  }

  void _cleanOldRequests() {
    final cutoff = DateTime.now().subtract(_period);
    while (_requestTimes.isNotEmpty && _requestTimes.first.isBefore(cutoff)) {
      _requestTimes.removeFirst();
    }
  }

  @override
  Future<T> cached<T>(Future<T> Function() operation, {
    required String key,
    Duration? ttl,
  }) async {
    await _waitIfNeeded();
    _requestTimes.add(DateTime.now());
    return await _wrapped.cached(operation, key: key, ttl: ttl);
  }
}
```

### Analytics

```dart
class AnalyticsExecutor extends RepositoryExecutor {
  final RepositoryExecutor _wrapped;
  final AnalyticsService _analytics;

  AnalyticsExecutor(this._wrapped, this._analytics);

  @override
  Future<T> execute<T>(Future<T> Function() operation) async {
    final startTime = DateTime.now();
    final operationName = operation.runtimeType.toString();

    try {
      final result = await _wrapped.execute(operation);
      _analytics.logEvent('repository_success', parameters: {
        'operation': operationName,
        'duration_ms': DateTime.now().difference(startTime).inMilliseconds,
      });
      return result;
    } catch (e) {
      _analytics.logEvent('repository_failure', parameters: {
        'operation': operationName,
        'duration_ms': DateTime.now().difference(startTime).inMilliseconds,
        'error_type': e.runtimeType.toString(),
      });
      rethrow;
    }
  }
}
```

### Circuit Breaker

```dart
class CircuitBreakerExecutor extends RepositoryExecutor {
  final RepositoryExecutor _wrapped;
  final int _failureThreshold;
  final Duration _timeout;

  int _failureCount = 0;
  DateTime? _lastFailureTime;
  CircuitBreakerState _state = CircuitBreakerState.closed;

  CircuitBreakerExecutor(
    this._wrapped, {
    int failureThreshold = 5,
    Duration timeout = const Duration(minutes: 1),
  })  : _failureThreshold = failureThreshold,
        _timeout = timeout;

  @override
  Future<T> execute<T>(Future<T> Function() operation) async {
    if (_state == CircuitBreakerState.open) {
      if (DateTime.now().difference(_lastFailureTime!) > _timeout) {
        _state = CircuitBreakerState.halfOpen;
      } else {
        throw const ServiceUnavailableException();
      }
    }

    try {
      final result = await _wrapped.execute(operation);
      _failureCount = 0;
      _state = CircuitBreakerState.closed;
      return result;
    } catch (e) {
      _failureCount++;
      _lastFailureTime = DateTime.now();
      if (_failureCount >= _failureThreshold) {
        _state = CircuitBreakerState.open;
      }
      rethrow;
    }
  }
}

enum CircuitBreakerState { closed, open, halfOpen }
```

---

## Testing

```dart
class MockRepositoryExecutor extends Mock implements RepositoryExecutor {}
class MockLogger extends Mock implements Logger {}

void main() {
  late LoggingExecutor executor;
  late MockRepositoryExecutor mockWrapped;
  late MockLogger mockLogger;

  setUp(() {
    mockWrapped = MockRepositoryExecutor();
    mockLogger = MockLogger();
    executor = LoggingExecutor(mockWrapped, logger: mockLogger);
  });

  test('logs successful operations', () async {
    when(() => mockWrapped.execute(any())).thenAnswer((_) async => 'result');

    final result = await executor.execute(() async => 'result');

    expect(result, equals('result'));
    verify(() => mockLogger.d('Repository operation started')).called(1);
    verify(() => mockLogger.i(any(that: contains('Completed')))).called(1);
  });

  test('logs failed operations', () async {
    final exception = Exception('test');
    when(() => mockWrapped.execute(any())).thenThrow(exception);

    expect(() => executor.execute(() async => throw exception), throwsA(equals(exception)));

    verify(() => mockLogger.e(any(that: contains('Failed')), error: exception)).called(1);
  });
}
```

---

## Best Practices

### 1. Decorator Order

```dart
// ✓ Correct
RawRepositoryExecutor()
  .withErrorHandling()  // 1. Normalize errors
  .withLogging()        // 2. Log normalized errors
  .withRetry()          // 3. Retry failures
  .withCaching()        // 4. Cache successes

// ✗ Wrong
RawRepositoryExecutor()
  .withCaching()        // ✗ Caches before error handling
  .withRetry()          // ✗ Retries before logging
```

### 2. Single Responsibility

```dart
// ✓ Good
class LoggingExecutor extends RepositoryExecutor { }

// ✗ Bad
class LoggingAndCachingExecutor extends RepositoryExecutor { }
```

### 3. Implement Both Methods

```dart
@override
Future<T> execute<T>(Future<T> Function() operation) async {
  return await _wrapped.execute(operation);
}

@override
Future<T> cached<T>(Future<T> Function() operation, {
  required String key,
  Duration? ttl,
}) async {
  return await _wrapped.cached(operation, key: key, ttl: ttl);
}
```

---

**Last Updated**: November 20, 2025
