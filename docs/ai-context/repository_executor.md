# Repository Executors — AI Context

Concise rules. Full guide: [../guides/repository_executor.md](../guides/repository_executor.md).

## Composition rules

- One `RepositoryExecutor` constructor param per distinct behavior a repo needs; named params once there is more than one.
- Chains are composed **only** in the repo's registration closure in `configs/*_module.dart`, from a single local `base = const RawRepositoryExecutor().withErrorHandling()`. `withErrorHandling()` is always innermost.
- Repositories never import `repository_executor_extensions.dart` and never call `withX()`.
- Executors are never registered in getIt — local expressions in the repo's one registration.
- Retry (`.withRetry(maxRetries: 3, retryDelay: ...)`) only for idempotent reads.

## Caching

- Caching is **not** a decorator: inject the `RepositoryCache` collaborator. No consumer exists yet; when one does, register `registerLazySingleton<RepositoryCache>(InMemoryRepositoryCache.new)` in `DataModule` (`lib/core/di/data_module.dart`).
- Keys/TTLs live in repository method bodies; the executor pipeline runs inside the `getOrFetch` fetch closure (a hit skips it).
- Invalidate after mutations: `_cache.invalidate('key')`.

## New cross-cutting concern — pick the bucket

1. Needs per-call params (key/codec)? → collaborator interface, not a decorator (like `RepositoryCache`).
2. Needs cross-call state (counters, queues, open/closed)? → state object as DI singleton + thin stateless decorator shell (`base.withX(getIt<XState>())`). Never state in decorator fields — factory-registered repos rebuild chains per resolution.
3. Otherwise → plain decorator extending `RepositoryExecutorDecorator`; catch `AppException`, add a `withX()` extension.

## Testing

- Mock the data source, never the executor; tests build real chains and pass them via the constructor.
- Retry paths: `retryDelay: Duration.zero` (`RetryExecutor` has no injectable clock; zero delay runs the real loop instantly); assert attempts via data-source `verify(...).called(n)`.
- Cache: fresh `InMemoryRepositoryCache()` per test; hit vs miss = count data-source calls.
