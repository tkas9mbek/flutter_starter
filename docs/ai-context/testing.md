# Testing — AI Context

Concise rules. Full guide: [../guides/testing.md](../guides/testing.md).

**Core idea:** test layers with *logic* (blocs, executors), and make the **no-mock vertical slice (#4)** the backbone — it's the most coverage-dense test (bloc + executor + repo delegation + mock DS, nothing stubbed). Features ship both `Mock*DataSource` and `Api*DataSource` behind a per-feature `useMock` switch; feature-flow tests still wire the `Mock*DataSource` (no network stack needed), while the `Api*DataSource` contract is locked separately, once per data source. Optimise coverage-per-effort, not a percentage.

## Test types

| # | Type | Covers |
|---|------|--------|
| 1 | Model serialization | real `fromJson`/`toJson` **exercised on the way** through the `Api*DataSource` test — **not** standalone round-trips (standalone only for enum/`@JsonKey` defaults no DS reaches) |
| 2 | **BLoC unit** (backbone) | every event→state; failure via an *immediately-throwing* repo (no retry timing) |
| 3 | Repository executor (central) | error mapping, retry timing, cache — once, for all repos *(leave as-is)* |
| 4 | **Feature-flow** (backbone, integration) | `BLoC → Repo → MockDataSource` end-to-end — **happy path + one error branch** |
| 5 | **Widget smoke** (data-driven) | a `(widget, state)` table builds without throwing; l10n keys; nullable branches |
| 6 | **DI graph smoke** | every registered type resolves from GetIt *(leave as-is)* |

## Hard rules

| # | Rule |
|---|------|
| T1 | **No per-repository unit test.** A repo is a thin facade — delegation is proven by the **mandatory** feature-flow test (#4). Add one back only if a repo gains real logic. *(Existing `test/features/*/data/*_repository_test.dart` files predate this doctrine and are grandfathered — don't add new ones.)* |
| T2 | **#4 is mandatory per feature** (not just critical), with **happy path + one failure-state assertion**: real BLoC → real Repo → real `Mock*DataSource`. |
| T3 | Test the **repository executor once, centrally** (error/retry/cache). Never per-repo. Retry *timing* lives here, not in bloc tests. |
| T4 | Build expected models from a per-feature **`*MockModels`** builder (`.user` / `.rawUser` from `assets/*.json`), never inline. Standalone model test (#1) **only** for enum/`@JsonKey` defaults. |
| T4b | **API DS tests run the real `fromJson`/`toJson` on the way:** invoke the captured `fromJson` on a raw fixture; `captureAny(named: 'body')` + assert concrete serialized values for `toJson`. Never `fromJson: any(named:)` → return a hand-built model. |
| T5 | `registerFallbackValue` for every custom type in `any(named:)` (in `setUpAll`) — incl. `HttpMethod` and the `T Function(Map<String,dynamic>)` fromJson type when matched with `any(named:)`. |
| T6 | `blocTest` `wait:` is for **debounce only** — never to sit through retry backoff; assert failure with a repo that throws immediately. |
| T7 | Widget smoke = a `(widget, state)` table → `pumpWidget(wrapApp(w))` → `pumpAndSettle()` → `expect(takeException(), isNull)`. Bespoke finder only where content matters. No pixels. |
| T8 | Coverage is a **filter, not a target**: exclude `*.g.dart`, `*.freezed.dart`, `main.dart`, DI module files so the number means *logic* coverage. |

## Per-feature policy (replaces "100%")

Each feature ships: **1 feature-flow test (#4, happy + error)** · **1 bloc test** (success/empty/failure) · **widget smoke coverage** for reused widgets/param-screens (currently one app-wide table in `test/uikit/uikit_widgets_smoke_test.dart`) · appears in the **DI graph test**. Model test (#1) only for non-trivial mapping. **Net: test count can fall while coverage rises.**

## Layout

```
test/features/{feature}/{assets,model,data,bloc,integration}/   # assets/ = feature-local fixtures
test/core/di_graph_test.dart          # DI smoke (app-wide)
test/uikit/uikit_widgets_smoke_test.dart  # data-driven widget smoke table (app-wide)
test/support/pump.dart                # wrapApp() helper
test/support/fixtures.dart            # fixtureMap/List(feature,file) + sharedFixtureMap/List(file)
test/support/assets/                  # shared cross-feature fixtures (add when a fixture is used by 2+ features)
```

There are no per-feature `widget/` test dirs today — widget smokes live in the app-wide table; add a per-feature dir only when a feature accumulates bespoke-finder tests.

**Fixtures:** load via `test/support/fixtures.dart` — `fixtureMap('<feature>', 'x.json')` for feature-local (e.g. `task/task1.json`, `profile/user.json`), `sharedFixtureMap('x.json')` for cross-feature (`test/support/assets/`). Never hand-roll a `File(...).readAsStringSync()` loader.

## Widget smoke helper + data-driven loop

```dart
Widget wrapApp(Widget child) => MaterialApp(
  locale: const Locale('ru'),
  localizationsDelegates: const [
    Localizer.delegate, UikitLocalizer.delegate, ToolkitLocalizer.delegate,
    GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate, // so `ru` is supported by all delegates
  ],
  supportedLocales: Localizer.delegate.supportedLocales,
  home: ThemeProvider(child: child),     // wrapWidget() adds a Scaffold for leaf widgets
);

// One loop replaces N near-identical testWidgets blocks
// (see test/uikit/uikit_widgets_smoke_test.dart for the real table):
smokeCases.forEach((name, build) => testWidgets('$name builds', (t) async {
  await t.pumpWidget(wrapApp(build()));
  await t.pumpAndSettle();
  expect(t.takeException(), isNull);
}));
```

Don't pump bloc-driven full screens (they use `getIt`) — cover their child widgets + the bloc test instead.

## Feature-flow (#4) — happy + error

```dart
// happy — real bloc, real repo, real MockTaskDataSource (nothing stubbed)
final base = const RawRepositoryExecutor().withErrorHandling();
final bloc = TasksListBloc(TaskRepository(base, MockTaskDataSource()));
bloc.add(const TasksListEvent.requested());
await bloc.stream.firstWhere(
  (s) => s is SuccessTasksListState || s is FailureTasksListState,
);
expect(bloc.state, isA<SuccessTasksListState>());

// error — one extra expect, doubles vertical coverage (executor map + repo + bloc failure)
final failBloc = TasksListBloc(TaskRepository(base, MockTaskDataSource.failing()));
failBloc.add(const TasksListEvent.requested());
await failBloc.stream.firstWhere(
  (s) => s is SuccessTasksListState || s is FailureTasksListState,
);
expect(failBloc.state, isA<FailureTasksListState>());
```

## API DS — real `fromJson`/`toJson` on the way (#1)

```dart
// 1. Reusable answer: run the REAL fromJson the DS passed, on a raw fixture.
Future<User> Function(Invocation) deserialize(Map<String, dynamic> raw) =>
    (invocation) async {
      final fromJson =
          invocation.namedArguments[#fromJson] as User Function(Map<String, dynamic>);
      return fromJson(raw);
    };

// 2. fromJson on the way (GET)
when(() => client.requestJson<User>(
      method: HttpMethod.get, path: '/profile', fromJson: any(named: 'fromJson')))
    .thenAnswer(deserialize(ProfileMockModels.rawUser));
expect(await ds.getUserProfile(), ProfileMockModels.user);

// 3. toJson on the way (PUT) — capture the body, assert concrete serialized values
when(() => client.requestJson<User>(
      method: HttpMethod.put, path: '/profile',
      body: any(named: 'body'), fromJson: any(named: 'fromJson')))
    .thenAnswer(deserialize(ProfileMockModels.rawUpdatedUser));
await ds.updateUserProfile(ProfileMockModels.user);
final body = verify(() => client.requestJson<User>(
      method: HttpMethod.put, path: '/profile',
      body: captureAny(named: 'body'), fromJson: any(named: 'fromJson')))
    .captured.single as Map<String, dynamic>;
expect(body['birthday'], '1990-01-01T00:00:00.000');     // real toJson ran

// Void endpoints (logout): assert wiring only.
when(() => client.requestVoid(method: HttpMethod.post, path: '/auth/logout'))
    .thenAnswer((_) async {});
await ds.logout();
verify(() => client.requestVoid(method: HttpMethod.post, path: '/auth/logout')).called(1);
```

## DI graph smoke

```dart
SharedPreferences.setMockInitialValues({});            // + stub secure storage channel
await getIt.reset();
await AppConfigurator.configure();
expect(getIt<TasksListBloc>(), isA<TasksListBloc>());   // one line per feature bloc
expect(getIt<LoginBloc>(), isA<LoginBloc>());           // (see test/core/di_graph_test.dart)
```

## Coverage filter

```bash
fvm flutter test --coverage --concurrency 4
lcov --remove coverage/lcov.info \
  '*.g.dart' '*.freezed.dart' '*/main.dart' '*/configs/*_module.dart' '*/di/*' \
  -o coverage/lcov.cleaned.info        # read the filtered report
```

## Don't

- ❌ Unit-test a thin repository (re-asserts delegation) — use #4. (Existing per-repo tests are grandfathered.)
- ❌ Ship a #4 with only a happy path — add one failure-state assertion.
- ❌ Round-trip every model — exercise fromJson/toJson on the way through the API-DS test; standalone #1 only for enum/`@JsonKey` defaults.
- ❌ Stub `fromJson: any(named:)` → return a hand-built model (bypasses deserialization, duplicates the model). Invoke the captured fromJson on a raw fixture.
- ❌ Assert a mock's fault-injection trigger — test real branches; cover errors via #4.
- ❌ `wait: 8s` for retry in a bloc test — retry timing is #3's.
- ❌ Hand-write N near-identical widget smokes — loop a table.
- ❌ Integration-test the `ApiClient` path with a full feature-flow slice — lock its contract with a mocked `ApiClient` instead (not what ships as the flow path).
- ❌ Assert pixels/layout in smoke tests; chase coverage %.
