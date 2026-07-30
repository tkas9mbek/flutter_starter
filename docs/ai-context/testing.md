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
| T1 | **No per-repository unit test.** A repo is a thin facade — delegation is proven by the **mandatory** feature-flow test (#4). Add one back only if a repo gains real logic. |
| T2 | **#4 is mandatory per feature** (not just critical), with **happy path + one `state.exception != null` assertion**: real BLoC → real Repo → real `Mock*DataSource`. |
| T3 | Test the **repository executor once, centrally** (error/retry/cache). Never per-repo. Retry *timing* lives here, not in bloc tests. |
| T4 | Build expected models from a per-feature **`*MockModels`** builder (`.user` / `.rawUser` from `assets/*.json`), never inline. Standalone model test (#1) **only** for enum/`@JsonKey` defaults. |
| T4b | **API DS tests run the real `fromJson`/`toJson` on the way:** invoke the captured `fromJson` on a raw fixture; `captureAny(named: 'body')` + assert concrete serialized values for `toJson`. Never `fromJson: any(named:)` → return a hand-built model. |
| T5 | `registerFallbackValue` for every custom type in `any(named:)` (in `setUpAll`) — incl. `HttpMethod` and the `T Function(Map<String,dynamic>)` fromJson type when matched with `any(named:)`. |
| T6 | `blocTest` `wait:` is for **debounce only** — never to sit through retry backoff; assert failure with a repo that throws immediately. |
| T7 | Widget smoke = a `(widget, state)` table → `pumpWidget(wrapApp(w))` → `pumpAndSettle()` → `expect(takeException(), isNull)`. Bespoke finder only where content matters. No pixels. |
| T8 | Coverage is a **filter, not a target**: exclude `*.g.dart`, `*.freezed.dart`, `main.dart`, DI module files so the number means *logic* coverage. |

## Per-feature policy (replaces "100%")

Each feature ships: **1 feature-flow test (#4, happy + error)** · **1 bloc test** (success/empty/failure) · **1 data-driven widget smoke** per reused widget/param-screen · appears in the **DI graph test**. Model test (#1) only for non-trivial mapping. **Net: test count can fall while coverage rises.**

## Layout

```
test/features/{feature}/{assets,model,data,bloc,widget,integration}/   # assets/ = feature-local fixtures
test/core/di_graph_test.dart        # DI smoke (app-wide)
test/support/pump.dart              # wrapApp() helper
test/support/fixtures.dart          # fixtureMap/List(feature,file) + sharedFixtureMap/List(file)
test/support/assets/                # shared cross-feature fixtures
```

**Fixtures:** load via `test/support/fixtures.dart` — `fixtureMap('<feature>', 'x.json')` for feature-local, `sharedFixtureMap('x.json')` for cross-feature (`test/support/assets/`). Never hand-roll a `File(...).readAsStringSync()` loader.

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

// One loop replaces N near-identical testWidgets blocks:
smokeCases.forEach((name, build) => testWidgets('$name builds', (t) async {
  await t.pumpWidget(wrapApp(build()));
  await t.pumpAndSettle();
  expect(t.takeException(), isNull);
}));
```

Don't pump bloc-driven full screens (they use `getIt`) — cover their child widgets + the bloc test instead.

## Feature-flow (#4) — happy + error

```dart
// happy
final bloc = buildBloc(MockOrderDataSource());
bloc.add(const CheckoutEvent.submitted());
await bloc.stream.firstWhere((s) => s.order != null || s.exception != null);
expect(bloc.state.order, isNotNull);

// error — one extra expect, doubles vertical coverage (executor map + repo + bloc failure)
final failBloc = buildBloc(MockOrderDataSource.failing());
failBloc.add(const CheckoutEvent.submitted());
await failBloc.stream.firstWhere((s) => s.order != null || s.exception != null);
expect(failBloc.state.exception, isNotNull);
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
SharedPreferences.setMockInitialValues({});            // + stub secure storage
await getIt.reset();
getIt.registerSingleton<AppEnvironment>(AppEnvironment.dev());
await AppConfigurator.configure();
expect(getIt<CheckoutBloc>(), isA<CheckoutBloc>());     // one line per feature bloc
```

## Coverage filter

```bash
fvm flutter test --coverage --concurrency 4
lcov --remove coverage/lcov.info \
  '*.g.dart' '*.freezed.dart' '*/main.dart' '*/configs/*_module.dart' '*/di/*' \
  -o coverage/lcov.cleaned.info        # read the filtered report
```

## Don't

- ❌ Unit-test a thin repository (re-asserts delegation) — use #4.
- ❌ Ship a #4 with only a happy path — add one `state.exception != null` assertion.
- ❌ Round-trip every model — exercise fromJson/toJson on the way through the API-DS test; standalone #1 only for enum/`@JsonKey` defaults.
- ❌ Stub `fromJson: any(named:)` → return a hand-built model (bypasses deserialization, duplicates the model). Invoke the captured fromJson on a raw fixture.
- ❌ Assert a mock's fault-injection trigger — test real branches; cover errors via #4.
- ❌ `wait: 8s` for retry in a bloc test — retry timing is #3's.
- ❌ Hand-write N near-identical widget smokes — loop a table.
- ❌ Integration-test the `ApiClient` path with a full feature-flow slice — lock its contract with a mocked `ApiClient` instead (not what ships as the flow path).
- ❌ Assert pixels/layout in smoke tests; chase coverage %.
