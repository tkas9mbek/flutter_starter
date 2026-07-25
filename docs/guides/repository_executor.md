# Repository Executors

Cross-cutting resilience for repository calls (error normalization, retry,
caching, and future concerns) via the decorator pattern — composed in DI
modules, injected into repositories, tested through constructor params.

Exception types and UI mapping live in
[exception_handling.md](exception_handling.md). The bridge between the two
topics is `ErrorHandlingExecutor`, which converts anything thrown by a data
source into an `AppException`.

## Table of Contents

1. [The pattern in one page](#the-pattern-in-one-page)
2. [How to use it in a repository](#how-to-use-it-in-a-repository)
3. [How to add a new executor](#how-to-add-a-new-executor)
4. [How to test](#how-to-test)
5. [Built-in reference](#built-in-reference)

---

## The pattern in one page

`RepositoryExecutor` has a single method:

```dart
abstract class RepositoryExecutor {
  Future<T> execute<T>(Future<T> Function() function);
}
```

Decorators (`RepositoryExecutorDecorator`) wrap another executor and add one
behavior each. Chains are built with extension methods, reading inner → outer
left to right:

```dart
final base = const RawRepositoryExecutor().withErrorHandling();
final retrying = base.withRetry(maxRetries: 3);
```

**The three invariants** (everything else in this guide follows from them):

1. `withErrorHandling()` is always the innermost decorator — every other
   decorator then sees normalized `AppException`s (`RetryExecutor` depends on
   `AppException.canRetry`).
2. Executor chains are composed in exactly one place per repository: the
   repository's registration closure in its `configs/*_module.dart`, always
   from a single local `base`. Repositories **never** import
   `repository_executor_extensions.dart` and never call `withX()` themselves.
3. A repository receives one `RepositoryExecutor` constructor param per
   distinct behavior its methods need. The DI container never registers
   executors — they are plain local expressions inside the repo's one
   registration.

Why: one composition site per repo means the whole chain shape is visible on
adjacent lines (you cannot double-wrap `withRetry` without seeing it), DI
registrations stay at one per repository forever, and every behavior is
swappable in tests because it arrives through the constructor.

---

## How to use it in a repository

### The default: one behavior for all methods

Most repositories need one chain for everything. This is today's shape —
nothing new to learn:

```dart
class ProfileRepository {
  const ProfileRepository(this._executor, this._dataSource);

  final RepositoryExecutor _executor;
  final ProfileDataSource _dataSource;

  Future<Profile> getProfile() =>
      _executor.execute(_dataSource.getProfile);
}
```

```dart
// profile_module.dart
..registerLazySingleton<ProfileRepository>(
  () => ProfileRepository(
    const RawRepositoryExecutor().withErrorHandling().withRetry(
      maxRetries: 3,
      retryDelay: const Duration(seconds: 2),
    ),
    getIt<ProfileDataSource>(),
  ),
)
```

### Growing a second behavior

When one method needs different resilience (say, creation should retry harder
than reads), do three things — and nothing else:

1. Switch the repository constructor to **named** params and add one
   `RepositoryExecutor` param + field for the new behavior.
2. Compose the new chain in the module closure, from the same local `base`.
3. Use the matching executor in the method body.

```dart
class TaskRepository {
  const TaskRepository({
    required RepositoryExecutor executor,
    required RepositoryExecutor creationExecutor,
    required TaskDataSource dataSource,
  })  : _executor = executor,
        _creationExecutor = creationExecutor,
        _dataSource = dataSource;

  final RepositoryExecutor _executor;          // baseline
  final RepositoryExecutor _creationExecutor;  // retry-heavy writes
  final TaskDataSource _dataSource;

  Future<List<Task>> getTasks() =>
      _executor.execute(_dataSource.getTasks);

  Future<Task> createTask(TaskCreateRequest request) =>
      _creationExecutor.execute(() => _dataSource.createTask(request));
}
```

```dart
// task_module.dart — still ONE registration; one local base.
..registerFactory(() {
  final base = const RawRepositoryExecutor().withErrorHandling();

  return TaskRepository(
    executor: base,
    creationExecutor: base.withRetry(
      maxRetries: 5,
      retryDelay: const Duration(seconds: 1),
    ),
    dataSource: getIt<TaskDataSource>(),
  );
})
```

Every further behavior costs the same three lines (param, field, composed
expression). Keep single-executor repos on the plain positional signature —
only switch to named params when the second executor appears.

### Caching: `RepositoryCache`, a collaborator — not a decorator

Caching needs a key per call and holds cross-call state, so it does not fit
the executor chain. It is a separate injected interface:

```dart
abstract class RepositoryCache {
  Future<T> getOrFetch<T>(
    Future<T> Function() fetch, {
    required String key,
    Duration? ttl,
  });

  void invalidate([String? key]);
}
```

A repository that caches takes it as a sibling constructor dependency. Keys
and TTLs are per-call data and belong in the method body:

```dart
Future<List<Task>> getTasks() => _cache.getOrFetch(
      () => _executor.execute(_dataSource.getTasks),
      key: 'tasks',
      ttl: const Duration(minutes: 5),
    );
```

Note the nesting: the executor pipeline runs *inside* the fetch closure, so a
cache hit skips error handling and retry entirely — there is nothing to
handle or retry when no call is made.

Wiring: one app-wide singleton, registered in `lib/core/di/data_module.dart`
**only once a real consumer exists** (do not pre-register — dead DI entries
fail review):

```dart
..registerLazySingleton<RepositoryCache>(InMemoryRepositoryCache.new)
```

Invalidate after mutations from the repository itself, e.g.
`_cache.invalidate('tasks')` at the end of `createTask`.

### Escalation valve: many behaviors on one repository

If a repository accumulates more than ~3 executor params, group them into a
small per-repo value type so the constructor stays readable:

```dart
class TaskExecutors {
  const TaskExecutors({required this.base, required this.creation});

  final RepositoryExecutor base;
  final RepositoryExecutor creation;
}
```

The module still composes every field in the registration closure from one
local `base`, and tests still construct the type field-by-field. This is a
mechanical regrouping — it changes nothing about where composition happens or
how tests inject. Do not introduce it earlier than needed.

---

## How to add a new executor

### First: decide what you are actually building

Walk this decision tree **before** writing a decorator:

1. **Does the concern need per-call parameters beyond the operation itself**
   (a key, a TTL, a codec)? → It is not a decorator. Build a separate
   collaborator interface injected into the repository (Bucket C).
   `RepositoryCache` is the exemplar.
2. **Does correctness depend on state that must survive across calls or
   instances** (failure counters, token buckets, open/closed flags)? → The
   *state* must be a DI singleton; the decorator is a thin stateless shell
   referencing it (Bucket B). Never hold such state in decorator fields:
   repositories may be `registerFactory` (a fresh chain per bloc resolution),
   so instance-held state silently resets.
3. **Otherwise** (stateless, fits `execute(fn)`) → a plain decorator
   (Bucket A). `RetryExecutor` is the exemplar.

### Bucket A worked example: `LoggingExecutor`

```dart
// packages/starter_toolkit/lib/data/repository_executor/logging_executor.dart
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Decorator logging duration and outcome of repository operations.
class LoggingExecutor extends RepositoryExecutorDecorator {
  const LoggingExecutor(super.wrapped, this._logger);

  final Logger _logger;

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    final stopwatch = Stopwatch()..start();
    try {
      final result = await wrapped.execute(function);
      _logger.info(
        'Repository call completed in ${stopwatch.elapsedMilliseconds}ms',
      );

      return result;
    } on AppException catch (e) {
      _logger.error(
        'Repository call failed after ${stopwatch.elapsedMilliseconds}ms',
        error: e,
      );
      rethrow;
    }
  }
}
```

Add the extension next to the others in
`repository_executor_extensions.dart`:

```dart
/// Wraps executor with duration/outcome logging.
RepositoryExecutor withLogging(Logger logger) {
  return LoggingExecutor(this, logger);
}
```

Compose it in the module closure — the closure has `getIt` in scope, so the
repository never holds a `Logger` just to build a decorator:

```dart
..registerFactory(() {
  final base = const RawRepositoryExecutor()
      .withErrorHandling()
      .withLogging(getIt<Logger>());

  return TaskRepository(base, getIt<TaskDataSource>());
})
```

Notes: extend `RepositoryExecutorDecorator` (never hand-roll a `_wrapped`
field); there is only `execute()` to override; catch `on AppException` —
error handling is innermost, so that is what reaches you.

### Bucket B worked example: circuit breaker

The state object is the singleton; the decorator is disposable:

```dart
// packages/starter_toolkit/lib/data/repository_executor/circuit_breaker.dart

/// Shared circuit state. Register as a DI singleton — never construct one
/// inside a repository or a registration closure, or the state resets with
/// every factory resolution.
class CircuitBreaker {
  CircuitBreaker({
    this.failureThreshold = 5,
    this.timeout = const Duration(minutes: 1),
  });

  final int failureThreshold;
  final Duration timeout;

  int _failureCount = 0;
  DateTime? _lastFailureTime;

  bool get isOpen {
    if (_failureCount < failureThreshold) {
      return false;
    }

    return DateTime.now().difference(_lastFailureTime!) < timeout;
  }

  void recordSuccess() {
    _failureCount = 0;
    _lastFailureTime = null;
  }

  void recordFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();
  }
}
```

```dart
// packages/starter_toolkit/lib/data/repository_executor/circuit_breaker_executor.dart
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/circuit_breaker.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Thin stateless shell around a shared [CircuitBreaker].
class CircuitBreakerExecutor extends RepositoryExecutorDecorator {
  const CircuitBreakerExecutor(super.wrapped, this._breaker);

  final CircuitBreaker _breaker;

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    if (_breaker.isOpen) {
      throw const ServerException(statusCode: 503);
    }

    try {
      final result = await wrapped.execute(function);
      _breaker.recordSuccess();

      return result;
    } on AppException {
      _breaker.recordFailure();
      rethrow;
    }
  }
}
```

Extension and wiring:

```dart
/// Wraps executor with a shared circuit breaker.
RepositoryExecutor withCircuitBreaker(CircuitBreaker breaker) {
  return CircuitBreakerExecutor(this, breaker);
}
```

```dart
..registerLazySingleton<CircuitBreaker>(CircuitBreaker.new)
..registerFactory(() {
  final base = const RawRepositoryExecutor()
      .withErrorHandling()
      .withCircuitBreaker(getIt<CircuitBreaker>());

  return ProfileRepository(base, getIt<ProfileDataSource>());
})
```

The same shape applies to rate limiting: a `RateLimiter` singleton owning the
request-time queue, plus a `RateLimitingExecutor(wrapped, limiter)` shell.

### Bucket C: build a collaborator instead

If your concern needs a key, a scope, or a codec per call, a decorator cannot
express it — `execute(fn)` has no room for the parameter, and widening the
base interface would force every decorator to forward a method it does not
care about. Define a small interface (like `RepositoryCache`), implement it,
register it as a singleton, and inject it into the repositories that need it.

### Invariants checklist for any new executor

- [ ] Composed only in module closures, from the single local `base`.
- [ ] `withErrorHandling()` stays innermost; your decorator catches
      `AppException`, not raw errors.
- [ ] No mutable fields on the decorator (state → DI singleton, Bucket B).
- [ ] Extension method added in `repository_executor_extensions.dart`,
      returning the base `RepositoryExecutor` type.
- [ ] No new getIt registrations for executors themselves (only for Bucket B
      state objects and Bucket C collaborators).

---

## How to test

### The seam

Every executor a repository uses is a constructor param, so a test builds its
own chain and passes it in. The rule stays what it always was: **mock the
data source, never the executor.** Do not create a `MockRepositoryExecutor` —
the chain is cheap, deterministic, and part of the behavior under test; the
new lever is that *you* choose its construction parameters per test.

```dart
late MockTaskDataSource mockDataSource;
late TaskRepository repository;

setUp(() {
  mockDataSource = MockTaskDataSource();
  final base = const RawRepositoryExecutor().withErrorHandling();

  repository = TaskRepository(
    executor: base,
    creationExecutor:
        base.withRetry(maxRetries: 5, retryDelay: Duration.zero),
    dataSource: mockDataSource,
  );
});
```

Each behavior is independently substitutable: to test `createTask`'s retry
exhaustion you re-tune `creationExecutor` only; `getTasks` still runs the
plain baseline.

### Testing retry paths: `retryDelay: Duration.zero`

`RetryExecutor` sleeps with a real `Future.delayed` and has **no injectable
clock** — do not go looking for a fake-timer hook; there isn't one, by
design. Passing `Duration.zero` runs the *real* retry loop (attempt counting,
`canRetry` checks, terminal rethrow) with zero wall-clock cost:

```dart
test('createTask surfaces error after exhausting retries', () async {
  when(() => mockDataSource.createTask(any()))
      .thenThrow(const ServerException(statusCode: 500)); // canRetry: true

  await expectLater(
    () => repository.createTask(request),
    throwsA(isA<ServerException>()),
  );
  verify(() => mockDataSource.createTask(any())).called(5); // maxRetries
});
```

Also test the non-retryable branch: a `canRetry: false` exception must reach
the caller after exactly one data-source call.

### Testing methods that use `RepositoryCache`

Inject a fresh `InMemoryRepositoryCache()` per test (build it in `setUp` and
keep it in a test-local variable so `invalidate` is reachable) — no shared
state between tests, nothing to reset. Assert hits and misses by counting
data-source invocations:

```dart
test('getTasks caches: second call within TTL skips the data source',
    () async {
  when(mockDataSource.getTasks).thenAnswer((_) async => tasks);

  await repository.getTasks(); // miss — fetches
  await repository.getTasks(); // hit — served from cache

  verify(mockDataSource.getTasks).called(1);
});

test('invalidate forces a refetch', () async {
  when(mockDataSource.getTasks).thenAnswer((_) async => tasks);

  await repository.getTasks();
  cache.invalidate('tasks');
  await repository.getTasks();

  verify(mockDataSource.getTasks).called(2);
});
```

For expiry, pass a tiny TTL and `await Future<void>.delayed(...)` past it —
no fake_async needed. To take caching out of play entirely, inject a no-op
fake implementing `RepositoryCache` that always calls `fetch`.

---

## Built-in reference

| Type | Kind | Behavior |
|------|------|----------|
| `RawRepositoryExecutor` | executor | Pass-through; the chain's core |
| `ErrorHandlingExecutor` | decorator (Bucket A) | Converts any throw to `AppException`; always innermost |
| `RetryExecutor` | decorator (Bucket A) | Up to `maxRetries` attempts, backoff `retryDelay * attempt`, only when `canRetry` |
| `RepositoryCache` / `InMemoryRepositoryCache` | collaborator (Bucket C) | Keyed TTL cache; singleton; hits bypass the executor pipeline |

Retry backoff example (defaults `maxRetries: 3`, `retryDelay: 2s`): waits
2s, then 4s between attempts; three attempts total before the final rethrow.
