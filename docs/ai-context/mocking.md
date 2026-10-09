# Mocking — AI Context

Concise rules. Full guide: [../guides/mocking.md](../guides/mocking.md).

Every REST/platform `DataSource` has an offline `Mock*DataSource` twin; `useMock` (`AppEnvironment.mock()`) swaps it in at DI time, so the app runs end to end without a backend. Latency and random failures come from one shared `MockNetworkBehavior` (`packages/starter_toolkit/lib/data/mock/mock_network_behavior.dart`: `simulate()` waits then fails at `failureRate`; `delay()` waits only; `chance(rate)` varies a response shape; `.instant()` = no wait/failure).

## Hard rules

| # | Rule |
|---|------|
| M1 | **No endpoint without a twin.** A new `Api*DataSource` method ships with the same method on its `Mock*DataSource`. |
| M2 | Layout: `data/mock/mock_<feature>_data_source.dart` + `data/mock/mock_<feature>_scenarios.dart`. Scenarios = canned payloads, sentinel constants, backend-shaped errors — pure data, no DI. |
| M3 | Every twin method that models a network call starts with `await _network.simulate()`. Never `Future.delayed` in a twin. |
| M4 | A twin that also serves **non-mock builds** (`MockRemoteConfigDataSource` when Firebase is off) uses `_network.delay()` — wait, never fail at random. |
| M5 | `MockNetworkBehavior` is a constructor argument, resolved in the module via `getIt<MockNetworkBehavior>()` (registered once in `DataModule` — the single place to tune wait / failure rate). Tests pass `MockNetworkBehavior.instant()`. |
| M6 | A failure is an `AppException` subtype carrying the **backend's** text (`ServerException(statusCode: 404, message: 'Task not found')`). Never `UnimplementedError`, never a localized/UI string — the UI decides the copy. |
| M7 | Sentinel inputs select outcomes (`MockAuthScenarios.wrongOtp`); name them in the scenarios file, no magic literals in the twin. |
| M8 | Platform twins with no I/O (`MockMessagingDataSource`, `MockPushTokenDataSource`) skip `simulate()`. |
| M9 | Tests: the feature-flow test (`T2`) wires the real twin with `.instant()`; sentinel branches are covered through that flow. Never unit-test a twin or its fault-injection trigger. |
| M10 | Pick twin vs prod with `mockOrProd(mock: …, prod: …)` (`lib/core/di/mock_or_prod.dart`) passed to `registerFactory` / `registerLazySingleton`. Plain `if` only when the condition differs from `useMock` (e.g. `useMock \|\| !FirebaseConfig.enabled`). |

## Shape

```dart
class MockTaskDataSource implements TaskDataSource {
  MockTaskDataSource(this._network) : _tasks = MockTaskScenarios.seed();

  final MockNetworkBehavior _network;
  final List<Task> _tasks;

  @override
  Future<Task> updateTask(String id, TaskCreateRequest request) async {
    await _network.simulate();

    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) {
      throw MockTaskScenarios.taskNotFound();
    }
    // ...
  }
}
```

## Don't

- ❌ `Future.delayed` inside a twin, or a second source of mock latency (per-feature constants) — tune `MockNetworkBehavior`.
- ❌ Hand-written UI strings or `UnimplementedError` as a mock failure.
- ❌ Inline `Random()` / `DateTime.now()` offsets in a twin — data in scenarios, dice in `MockNetworkBehavior`.
