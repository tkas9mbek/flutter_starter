# Mocking

The app runs without a backend when `AppEnvironment.mock()` is active (`useMock == true`). Each feature module picks a
`Mock*DataSource` twin instead of the `Api*` one; the repository, executor and BLoC above it are the real ones. Compact
rules (`M1`-`M10`): [../ai-context/mocking.md](../ai-context/mocking.md).

## 1. The pieces

| Piece | Where | Role |
|---|---|---|
| `Mock*DataSource` | `lib/features/<feature>/data/mock/mock_<feature>_data_source.dart` | Implements the abstract DataSource; answers from scenarios |
| `Mock<Feature>Scenarios` | `lib/features/<feature>/data/mock/mock_<feature>_scenarios.dart` | Canned payloads, sentinel constants, backend-shaped `AppException` factories. Pure data |
| `MockNetworkBehavior` | `packages/starter_toolkit/lib/data/mock/mock_network_behavior.dart` | Shared wait + random failure, registered once in `DataModule` |
| `mockOrProd` | `lib/core/di/mock_or_prod.dart` | Module helper: twin when `useMock`, else the `Api*` / production class |

`MockNetworkBehavior`:

- `simulate()` — waits `wait` (default 500 ms), then throws
  `InternalServerErrorException` with probability `failureRate` (default 0.05). First call in every method.
- `delay()` — waits only; for twins that also serve non-mock builds.
- `chance(rate)` — varies a response shape (an occasional empty list).
- `MockNetworkBehavior.instant()` — no wait, no failure; for tests.

A retry that shows a *different* error than before was the dice: set `failureRate: 0` in the `DataModule` registration
to demo without flakiness.

## 2. Three kinds of answer

| Kind | What the UI sees | How the twin produces it |
|---|---|---|
| Success | The normal screen | Return a payload from the scenarios file |
| Default failure | The standard error state / snackbar | `simulate()` throws at `failureRate` |
| Failure with logic | A dedicated field / screen the UI branches on | Throw an `AppException` with the backend's text, selected by a sentinel input |

Only the third kind needs code in the twin.

## 3. Add a mock for a new endpoint

1. **Scenarios** — add the payload and any sentinel or refusal to `mock_<feature>_scenarios.dart`:

   ```dart
   abstract final class MockAuthScenarios {
     static const wrongOtp = '0000'; // sentinel: verifying this code is refused

     static AppException wrongOtpRefusal() =>
         const UnauthorizedException(message: 'Invalid verification code');
   }
   ```

2. **Twin** — implement the method on `Mock*DataSource`, starting with `simulate()`:

   ```dart
   @override
   Future<AuthToken> verifyOtp(AuthVerifyOtpRequestBody body) async {
     await _network.simulate();

     if (body.otp == MockAuthScenarios.wrongOtp) {
       throw MockAuthScenarios.wrongOtpRefusal();
     }

     return MockAuthScenarios.token;
   }
   ```

3. **Module** — register with `mockOrProd`, passing `getIt<MockNetworkBehavior>()` to the twin:

   ```dart
   ..registerLazySingleton<AuthUnauthorizedDataSource>(
     mockOrProd(
       mock: () => MockAuthUnauthorizedDataSource(getIt<MockNetworkBehavior>()),
       prod: () => ApiAuthUnauthorizedDataSource(getIt<ApiClient>()),
     ),
   )
   ```

   Keep a plain `if` only when the condition isn't just `useMock` (remote-config and notifications modules also fall
   back to a twin when `!FirebaseConfig.enabled`).
4. **Test** — extend the feature-flow test (`T2`) with `MockNetworkBehavior.instant()`; cover the sentinel through the
   flow's error branch. Don't unit-test the twin itself. The DI graph test must still resolve.
5. Walk the flow on the `mock` environment — no request may reach the network.

## 4. Rules

- A failure is always an `AppException` subtype with the **backend's** text — never `UnimplementedError`, never a
  localized string.
- Sentinels are named constants in the scenarios file.
- Twins hold their own mutable state (e.g. the task list), seeded from scenarios; one instance serves the session, so
  create/update/delete are visible to later reads.
- Platform twins with no I/O skip `simulate()`.

## 5. Not adopted: tester-editable config

A bundled `mock_config.jsonc` (forced outcomes, delays, failure rate per flavor) would need an asset, a loader and
codegen, so the starter tunes in code (`DataModule` + scenarios). Add it only when testers must drive outcomes without a
rebuild; the twin shape stays unchanged — the config just feeds `MockNetworkBehavior` and the scenario switches.
