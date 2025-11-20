# Repository Executors Guide

> **AI Context**: Comprehensive guide to creating and using custom repository executors with the decorator pattern.

## Overview

Repository executors provide a decorator pattern for adding cross-cutting concerns to repositories without modifying their code. They wrap repository operations with additional functionality like error handling, retry logic, caching, logging, and more.

**Benefits:**
- Composable decorators that can be chained
- No code duplication across repositories
- Easy to add new executors without modifying existing code
- Testable in isolation
- Memory leak prevention (automatic cleanup)

---

## Built-in Executors

### RawRepositoryExecutor

Base executor that simply executes operations without any additional behavior.

```dart
final executor = RawRepositoryExecutor();
```

**Use when**: Starting point for all executor chains

### ErrorHandlingExecutor

Normalizes all errors to `AppException` for consistent error handling.

```dart
final executor = RawRepositoryExecutor().withErrorHandling();
```

**Converts:**
- `DioException` → `AppException.noInternet()` or `AppException.server()`
- `SocketException` → `AppException.noInternet()`
- Unknown errors → `AppException.unknown()` (production) or rethrows (debug)

**Use when**: You want consistent exception types across all repositories

### RetryExecutor

Automatic retry with exponential backoff for failed operations.

```dart
final executor = RawRepositoryExecutor()
  .withErrorHandling()
  .withRetry(
    maxRetries: 3,
    retryDelay: Duration(seconds: 2),
  );
```

**Parameters:**
- `maxRetries` - Maximum number of retry attempts (default: 3)
- `retryDelay` - Initial delay before first retry (default: 2 seconds)
- Exponential backoff: 2s, 4s, 8s...

**Use when**: Network operations that might fail temporarily

### CachingExecutor

Time-based caching with automatic cleanup to prevent memory leaks.

```dart
final executor = RawRepositoryExecutor()
  .withErrorHandling()
  .withCaching(defaultTtl: Duration(minutes: 5));

// Use with cached() method
final data = await executor.cached(
  () => _dataSource.getData(),
  key: 'user_list',
  ttl: Duration(minutes: 10), // Override default
);
```

**Features:**
- Time-to-live (TTL) based expiration
- Automatic memory cleanup via timer
- Key-based cache storage
- Per-operation TTL override

**Use when**: Expensive operations with stable data

---

## When to Create Custom Executors

### ✅ Create executor when:

1. **Shared behavior** across multiple repositories
   - Logging all API calls
   - Analytics tracking for operations
   - Rate limiting API requests
   - Offline queue management

2. **Cross-cutting concern** that doesn't belong in repository logic
   - Performance monitoring
   - Request/response transformation
   - Circuit breaker pattern
   - Request deduplication

3. **Reusable decorator** that can be composed with other executors
   - Can be chained: `.withErrorHandling().withLogging().withRetry()`
   - Independent of specific repository implementations

### ❌ DO NOT create executor for:

- **Feature-specific logic** → belongs in Repository
  - Business rules
  - Data transformation
  - Feature-specific validation

- **One-time operations** → use regular methods
  - Temporary debugging
  - One-off data migration

- **UI-specific concerns** → belongs in BLoC or widgets
  - Loading states
  - User interaction logic
  - Navigation

---

## Creating Custom Executors

### Step-by-Step Example: LoggingExecutor

**Step 1: Create executor class**

```dart
// packages/starter_toolkit/lib/data/repository_executor/logging_executor.dart
import 'package:logger/logger.dart';
import 'repository_executor.dart';

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
      _logger.i('Repository operation completed in ${stopwatch.elapsedMilliseconds}ms');
      return result;
    } catch (e) {
      stopwatch.stop();
      _logger.e('Repository operation failed after ${stopwatch.elapsedMilliseconds}ms', error: e);
      rethrow;
    }
  }

  @override
  Future<T> cached<T>(
    Future<T> Function() operation, {
    required String key,
    Duration? ttl,
  }) async {
    _logger.d('Repository cached operation: $key');
    return await _wrapped.cached(operation, key: key, ttl: ttl);
  }
}
```

**Step 2: Add extension method for fluent API**

```dart
// packages/starter_toolkit/lib/data/repository_executor/repository_executor.dart
extension RepositoryExecutorExtensions on RepositoryExecutor {
  RepositoryExecutor withLogging({Logger? logger}) {
    return LoggingExecutor(this, logger: logger);
  }
}
```

**Step 3: Export from package**

```dart
// packages/starter_toolkit/lib/data/repository_executor/repository_executor.dart
export 'logging_executor.dart';
```

**Step 4: Use in DI configuration**

```dart
// lib/core/di/modules/data_module.dart
@override
Future<void> dependencies(GetIt getIt, Environment environment) async {
  // Repository executor with logging
  getIt.registerFactory<RepositoryExecutor>(() {
    return RawRepositoryExecutor()
      .withErrorHandling()
      .withLogging()      // ✓ Add custom executor
      .withRetry()
      .withCaching();
  });
}
```

---

## Common Custom Executor Patterns

### 1. Rate Limiting Executor

Limits the number of requests within a time window.

```dart
// packages/starter_toolkit/lib/data/repository_executor/rate_limiting_executor.dart
import 'dart:collection';

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

      if (waitTime.isNegative == false) {
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
  Future<T> cached<T>(
    Future<T> Function() operation, {
    required String key,
    Duration? ttl,
  }) async {
    await _waitIfNeeded();
    _requestTimes.add(DateTime.now());
    return await _wrapped.cached(operation, key: key, ttl: ttl);
  }
}

// Extension method
extension RateLimitingExtension on RepositoryExecutor {
  RepositoryExecutor withRateLimiting({
    int maxRequests = 10,
    Duration period = const Duration(seconds: 1),
  }) {
    return RateLimitingExecutor(
      this,
      maxRequests: maxRequests,
      period: period,
    );
  }
}
```

**Usage:**
```dart
final executor = RawRepositoryExecutor()
  .withErrorHandling()
  .withRateLimiting(maxRequests: 5, period: Duration(seconds: 1))
  .withRetry();
```

### 2. Analytics Executor

Tracks repository operation metrics for analytics.

```dart
// packages/starter_toolkit/lib/data/repository_executor/analytics_executor.dart
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

      _analytics.logEvent('repository_operation_success', parameters: {
        'operation': operationName,
        'duration_ms': DateTime.now().difference(startTime).inMilliseconds,
      });

      return result;
    } catch (e) {
      _analytics.logEvent('repository_operation_failure', parameters: {
        'operation': operationName,
        'duration_ms': DateTime.now().difference(startTime).inMilliseconds,
        'error_type': e.runtimeType.toString(),
      });

      rethrow;
    }
  }

  @override
  Future<T> cached<T>(
    Future<T> Function() operation, {
    required String key,
    Duration? ttl,
  }) async {
    _analytics.logEvent('repository_cache_access', parameters: {
      'cache_key': key,
    });

    return await _wrapped.cached(operation, key: key, ttl: ttl);
  }
}

// Extension method
extension AnalyticsExtension on RepositoryExecutor {
  RepositoryExecutor withAnalytics(AnalyticsService analytics) {
    return AnalyticsExecutor(this, analytics);
  }
}
```

### 3. Offline Queue Executor

Queues operations when offline and executes them when connection is restored.

```dart
// packages/starter_toolkit/lib/data/repository_executor/offline_queue_executor.dart
class OfflineQueueExecutor extends RepositoryExecutor {
  final RepositoryExecutor _wrapped;
  final ConnectivityService _connectivity;
  final Queue<_QueuedOperation> _queue = Queue();
  bool _isProcessing = false;

  OfflineQueueExecutor(this._wrapped, this._connectivity) {
    _connectivity.onConnectivityChanged.listen((_) {
      if (_connectivity.isConnected) {
        processQueue();
      }
    });
  }

  @override
  Future<T> execute<T>(Future<T> Function() operation) async {
    if (await _connectivity.isConnected) {
      return await _wrapped.execute(operation);
    } else {
      // Queue for later execution
      final completer = Completer<T>();
      _queue.add(_QueuedOperation(
        operation: () async {
          try {
            final result = await _wrapped.execute(operation);
            completer.complete(result);
          } catch (e) {
            completer.completeError(e);
          }
        },
      ));

      return completer.future;
    }
  }

  Future<void> processQueue() async {
    if (_isProcessing || _queue.isEmpty) return;

    _isProcessing = true;

    while (_queue.isNotEmpty && await _connectivity.isConnected) {
      final queuedOp = _queue.removeFirst();
      try {
        await queuedOp.operation();
      } catch (e) {
        // Log error but continue processing
        print('Queued operation failed: $e');
      }
    }

    _isProcessing = false;
  }

  @override
  Future<T> cached<T>(
    Future<T> Function() operation, {
    required String key,
    Duration? ttl,
  }) async {
    // Cached operations should work offline (from cache)
    return await _wrapped.cached(operation, key: key, ttl: ttl);
  }
}

class _QueuedOperation {
  final Future<void> Function() operation;

  _QueuedOperation({required this.operation});
}
```

### 4. Circuit Breaker Executor

Prevents repeated calls to failing operations (circuit breaker pattern).

```dart
// packages/starter_toolkit/lib/data/repository_executor/circuit_breaker_executor.dart
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
        throw AppException.serviceUnavailable();
      }
    }

    try {
      final result = await _wrapped.execute(operation);

      // Success - reset circuit
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

  @override
  Future<T> cached<T>(
    Future<T> Function() operation, {
    required String key,
    Duration? ttl,
  }) async {
    return await execute(() => _wrapped.cached(operation, key: key, ttl: ttl));
  }
}

enum CircuitBreakerState {
  closed,  // Normal operation
  open,    // Failing - reject requests
  halfOpen // Testing if service recovered
}
```

---

## Testing Custom Executors

### Unit Testing

```dart
// test/data/repository_executor/logging_executor_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logger/logger.dart';

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

  group('execute', () {
    test('logs successful operations with duration', () async {
      when(() => mockWrapped.execute(any())).thenAnswer((_) async => 'result');

      final result = await executor.execute(() async => 'result');

      expect(result, equals('result'));
      verify(() => mockLogger.d('Repository operation started')).called(1);
      verify(() => mockLogger.i(any(that: contains('completed')))).called(1);
    });

    test('logs failed operations with error', () async {
      final exception = Exception('test error');
      when(() => mockWrapped.execute(any())).thenThrow(exception);

      expect(
        () => executor.execute(() async => throw exception),
        throwsA(equals(exception)),
      );

      verify(() => mockLogger.d('Repository operation started')).called(1);
      verify(() => mockLogger.e(
        any(that: contains('failed')),
        error: exception,
      )).called(1);
    });
  });

  group('cached', () {
    test('logs cache key', () async {
      when(() => mockWrapped.cached(
        any(),
        key: any(named: 'key'),
        ttl: any(named: 'ttl'),
      )).thenAnswer((_) async => 'cached_result');

      final result = await executor.cached(
        () async => 'cached_result',
        key: 'test_key',
      );

      expect(result, equals('cached_result'));
      verify(() => mockLogger.d('Repository cached operation: test_key')).called(1);
    });
  });
}
```

### Integration Testing

```dart
// test/data/repository_executor/executor_integration_test.dart
void main() {
  test('executors can be chained', () async {
    var executionCount = 0;

    final executor = RawRepositoryExecutor()
      .withErrorHandling()
      .withLogging()
      .withRetry(maxRetries: 2);

    // Test that all executors work together
    final result = await executor.execute(() async {
      executionCount++;
      if (executionCount < 2) {
        throw Exception('Temporary error');
      }
      return 'success';
    });

    expect(result, equals('success'));
    expect(executionCount, equals(2)); // Initial + 1 retry
  });
}
```

---

## Best Practices

### 1. Decorator Order Matters

Place executors in logical order:

```dart
// ✓ Correct order
RawRepositoryExecutor()
  .withErrorHandling()    // 1. Normalize errors first
  .withLogging()          // 2. Log normalized errors
  .withRetry()            // 3. Retry failed operations
  .withCaching()          // 4. Cache successful results

// ✗ Wrong order
RawRepositoryExecutor()
  .withCaching()          // ✗ Caches before error handling
  .withRetry()            // ✗ Retries before logging
  .withErrorHandling()    // ✗ Too late
```

### 2. Keep Executors Simple

Each executor should have a single responsibility:

```dart
// ✓ Good - Single responsibility
class LoggingExecutor extends RepositoryExecutor {
  // Only handles logging
}

// ✗ Bad - Multiple responsibilities
class LoggingAndCachingExecutor extends RepositoryExecutor {
  // Handles both logging and caching - should be separate
}
```

### 3. Make Executors Configurable

Use constructor parameters for configuration:

```dart
// ✓ Good - Configurable
class RetryExecutor extends RepositoryExecutor {
  final int maxRetries;
  final Duration retryDelay;

  RetryExecutor(this._wrapped, {
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });
}
```

### 4. Handle Both execute() and cached()

Always implement both methods:

```dart
@override
Future<T> execute<T>(Future<T> Function() operation) async {
  // Your logic here
  return await _wrapped.execute(operation);
}

@override
Future<T> cached<T>(
  Future<T> Function() operation, {
  required String key,
  Duration? ttl,
}) async {
  // Your logic here (might be different from execute)
  return await _wrapped.cached(operation, key: key, ttl: ttl);
}
```

### 5. Clean Up Resources

Implement cleanup if your executor holds resources:

```dart
class OfflineQueueExecutor extends RepositoryExecutor {
  StreamSubscription? _subscription;

  OfflineQueueExecutor(this._wrapped, this._connectivity) {
    _subscription = _connectivity.onConnectivityChanged.listen(...);
  }

  void dispose() {
    _subscription?.cancel();
  }
}
```

---

## Related Documentation

- [Architecture Guide](./architecture.md) - Overall architecture patterns
- [Exception Handling](./custom-exceptions.md) - Custom exception guide
- [Testing Guide](./testing.md) - Testing strategies

---

**Last Updated**: November 20, 2025
