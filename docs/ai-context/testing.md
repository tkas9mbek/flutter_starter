# Testing — AI Context

Concise rules. Full guide: [../guides/testing.md](../guides/testing.md).

**Core idea:** test layers with *logic* (blocs, executors) and make the **no-mock vertical slice (#4)** the backbone — bloc + executor + repo delegation + `Mock*DataSource`, nothing stubbed. Features ship `Mock*DataSource` and `Api*DataSource` behind `useMock`; feature-flow tests wire the mock twin (no network stack), the `Api*DataSource` contract is locked once per data source with a mocked `ApiClient`. Optimise coverage-per-effort, not a percentage.

## Test types

| # | Type | Covers |
|---|------|--------|
| 1 | Model serialization | real `fromJson`/`toJson` exercised **on the way** through the `Api*DataSource` test — standalone only for enum/`@JsonKey` defaults no DS reaches |
| 2 | **BLoC unit** (backbone) | every event→state; failure via an *immediately-throwing* repo/DS (no retry timing) |
| 3 | Repository executor (central) | error mapping, retry timing, cache — once, for all repos |
| 4 | **Feature-flow** (backbone) | `BLoC → Repo → Mock*DataSource` — **happy path + one failure state** |
| 5 | **Widget smoke** (data-driven) | a `(widget, state)` table builds without throwing; l10n keys; nullable branches |
| 6 | **DI graph smoke** | every registered type resolves from GetIt |

## Hard rules

| # | Rule |
|---|------|
| T1 | **No per-repository unit test** — a repo is a thin facade; delegation is proven by the feature-flow test (#4). Add one only if a repo gains real logic. |
| T2 | **#4 is mandatory per feature**: happy path + one failure-state assertion, real BLoC → real Repo → real `Mock*DataSource` (`MockNetworkBehavior.instant()`). |
| T3 | Test the **repository executor once, centrally** (error/retry/cache), never per-repo. Retry *timing* lives here, not in bloc tests. |
| T4 | Expected models come from a per-feature **`*MockModels`** builder (`.user` / `.rawUser` from `assets/*.json`), never inline. Standalone model test (#1) **only** for enum/`@JsonKey` defaults. |
| T4b | **API DS tests run the real `fromJson`/`toJson` on the way:** invoke the captured `fromJson` on a raw fixture; `captureAny(named: 'body')` + assert concrete serialized values for `toJson`. Never `fromJson: any(named:)` → return a hand-built model. |
| T5 | `registerFallbackValue` for every custom type in `any(named:)` (in `setUpAll`) — incl. `HttpMethod` and the `T Function(Map<String,dynamic>)` fromJson type. |
| T6 | `blocTest` `wait:` is for **debounce only** — never to sit through retry backoff; assert failure with a repo/DS that throws immediately. |
| T7 | Widget smoke = `(widget, state)` table → `pumpWidget(wrapApp(w))` → `pumpAndSettle()` → `expect(takeException(), isNull)`. Bespoke finder only where content matters. No pixels. |
| T8 | Coverage is a **filter, not a target**: exclude `*.g.dart`, `*.freezed.dart`, `main.dart`, DI module files. |

**Per-feature policy:** 1 feature-flow test (happy + error) · 1 bloc test (success/empty/failure) · widget smoke coverage for reused widgets/param-screens (one app-wide table today) · present in the DI graph test. Model test only for non-trivial mapping. Test count can fall while coverage rises.

## Layout

```
test/features/{feature}/{assets,model,data,bloc,integration}/   # assets/ = feature-local fixtures
test/core/di_graph_test.dart              # DI smoke (app-wide)
test/uikit/uikit_widgets_smoke_test.dart  # data-driven widget smoke table (app-wide)
test/support/{pump,fixtures,finders}.dart # wrapApp()/wrapWidget(); fixtureMap/List(feature, file), sharedFixtureMap/List(file); finders
test/support/assets/                      # shared cross-feature fixtures — create when 2+ features use one
```

No per-feature `widget/` test dirs — add one only when a feature accumulates bespoke-finder tests. Load fixtures via `fixtureMap('task', 'task1.json')` / `sharedFixtureMap('x.json')`, never a hand-rolled `File(...).readAsStringSync()`.

## Widget smoke loop

```dart
// wrapApp (test/support/pump.dart): MaterialApp, locale 'ru', Localizer/UikitLocalizer/ToolkitLocalizer + Global* delegates,
// home: ThemeProvider(child: child). wrapWidget() adds a Scaffold for leaf widgets.
smokeCases.forEach((name, build) => testWidgets('$name builds', (t) async {
  await t.pumpWidget(wrapApp(build()));
  await t.pumpAndSettle();
  expect(t.takeException(), isNull);
}));
```

Don't pump bloc-driven full screens (they use `getIt`) — cover child widgets + the bloc test.

## Feature-flow (#4) — happy + error

Real example: `test/features/task/integration/integration_test.dart`. The error path uses a **private throwing data source** declared in the test — there is no `Mock*DataSource.failing()`:

```dart
class _ThrowingTaskDataSource implements TaskDataSource {
  const _ThrowingTaskDataSource();

  @override
  Future<List<Task>> getTasks() async => throw const NoInternetException();
  // …every other method throws the same way
}

TasksListBloc buildBloc(TaskDataSource ds) =>
    TasksListBloc(TaskRepository(const RawRepositoryExecutor().withErrorHandling(), ds));

// happy: buildBloc(MockTaskDataSource(const MockNetworkBehavior.instant()))
// error: buildBloc(const _ThrowingTaskDataSource())
bloc.add(const TasksListEvent.requested());
await bloc.stream.firstWhere((s) => s is SuccessTasksListState || s is FailureTasksListState);
expect(bloc.state, isA<FailureTasksListState>());   // or SuccessTasksListState for happy
```

## API DS — real `fromJson`/`toJson` on the way (#1, `T4b`)

```dart
// Run the REAL fromJson the DS passed, on a raw fixture.
Future<User> Function(Invocation) deserialize(Map<String, dynamic> raw) => (invocation) async {
  final fromJson = invocation.namedArguments[#fromJson] as User Function(Map<String, dynamic>);
  return fromJson(raw);
};

// fromJson on the way (GET)
when(() => client.requestJson<User>(method: HttpMethod.get, path: '/profile', fromJson: any(named: 'fromJson')))
    .thenAnswer(deserialize(ProfileMockModels.rawUser));
expect(await ds.getUserProfile(), ProfileMockModels.user);

// toJson on the way (PUT) — capture the body, assert concrete serialized values
final body = verify(() => client.requestJson<User>(
      method: HttpMethod.put, path: '/profile',
      body: captureAny(named: 'body'), fromJson: any(named: 'fromJson')))
    .captured.single as Map<String, dynamic>;
expect(body['birthday'], '1990-01-01T00:00:00.000');   // real toJson ran
```

Void endpoints (`logout`): `when(() => client.requestVoid(method: HttpMethod.post, path: '/auth/logout')).thenAnswer((_) async {})` + `verify(...).called(1)` — wiring only.

## DI graph smoke & coverage filter

```dart
SharedPreferences.setMockInitialValues({});   // + stub secure-storage channel
await getIt.reset();
await AppConfigurator.configure();
expect(getIt<TasksListBloc>(), isA<TasksListBloc>());   // one line per feature bloc (test/core/di_graph_test.dart)
```

```bash
fvm flutter test --coverage --concurrency 4
lcov --remove coverage/lcov.info '*.g.dart' '*.freezed.dart' '*/main.dart' '*/configs/*_module.dart' '*/di/*' -o coverage/lcov.cleaned.info
```

## Don't

- ❌ Unit-test a thin repository (use #4) or a `Mock*DataSource` / its fault-injection trigger — cover its happy + error paths through #4 (`mocking.md` `M9`).
- ❌ Ship a #4 with only a happy path.
- ❌ Round-trip every model, or stub `fromJson: any(named:)` returning a hand-built model (`T4`/`T4b`).
- ❌ `wait: 8s` for retry in a bloc test (`T6`).
- ❌ Hand-write N near-identical widget smokes — loop a table (`T7`).
- ❌ Integration-test the `ApiClient` path with a full feature-flow slice — lock its contract with a mocked `ApiClient`.
- ❌ Assert pixels/layout in smoke tests; chase coverage %.
