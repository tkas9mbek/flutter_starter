# Testing Guide

> **Philosophy:** test the layers that contain *logic*, and lean on the **no-mock vertical slice** for everything else. The app ships both `Mock*DataSource` and `Api*DataSource` implementations behind a per-feature `useMock` switch. Feature-flow tests wire the `Mock*DataSource` because it needs no network stack and still proves the real bloc/repository/executor wiring; the `Api*DataSource` contract (method, path, body, `fromJson`) is locked separately, once per data source (§5.4 callout) — not by re-running the whole feature-flow slice against it. Prioritise by coverage-per-unit-of-effort, not by a coverage percentage.

**The single most coverage-dense test is the feature-flow slice (#4).** One run lights up the bloc, the executor, the repository's delegation, and the mock data source's happy path simultaneously — with nothing stubbed. It is therefore the **backbone alongside the bloc test (#2)**, and it is **mandatory per feature**, not reserved for critical ones. Most of the policy below follows from that reweighting: spend less on narrow, mock-heavy tests that mostly cover generated or mock-config code, and more on the slice that proves real wiring.

> **Current suite vs. this doctrine:** parts of the existing suite predate this policy — the
> per-repository unit tests (`test/features/*/data/*_repository_test.dart`) and the
> `ApiClient`-mocked integration tests (e.g. `test/features/task/integration/integration_test.dart`)
> are **grandfathered**. Don't add new tests in those shapes; write new tests in the shapes below.

## 1. The test types

| # | Type | Tests a layer with… | What it covers | What it can't | Effort |
|---|------|---------------------|----------------|---------------|--------|
| 1 | **Model serialization** | mapping | real `fromJson`/`toJson` **exercised on the way** through the `Api*DataSource` test (§5.1); standalone only for enum/`@JsonKey` defaults no DS reaches | vanity round-trips, logic, UI | XS |
| 2 | **BLoC unit** *(backbone)* | logic | every event→state transition, repo calls, error→failure (with an *immediately-throwing* repo) | retry *timing* (that's #3), rendering, wiring | S |
| 3 | **Repository executor** *(central)* | logic | error mapping, retry/backoff timing, cache TTL — once, for all repos | per-feature behaviour | S |
| 4 | **Feature-flow** *(backbone, integration)* | thin glue | `BLoC → Repository → MockDataSource` end-to-end — **happy path + one error branch** | API contracts, pixels | M |
| 5 | **Widget smoke** *(data-driven)* | rendering | a table of `(widget, state)` pairs builds without throwing; l10n keys exist; nullable branches render | exact pixels, deep behaviour | S |
| 6 | **DI graph smoke** | wiring | every registered type resolves from GetIt | logic, UI | XS |

**Do NOT write per-repository unit tests.** A concrete repository is a thin facade (`getX() => _executor.execute(_ds.getX)`); a unit test for it only re-asserts that delegation delegates. The delegation is proven *transitively* by the **feature-flow test (#4)** — which is why #4 is now mandatory — and the only real repo-layer logic, the executor decorators, is tested **once, centrally (#3)**. Add a repository unit test back **only** when a repo gains real logic (coordinates multiple data sources, merges/transforms results, owns cache keys). Existing per-repo tests are grandfathered.

## 2. What each feature must have (the policy)

Replace "aim for 100%" with a per-feature checklist:

- ✅ **One feature-flow test per feature (#4)** — real BLoC → real Repo → real `Mock*DataSource`, **happy path + one failure-state assertion**. This is the backbone; it closes the delegation blind spot for *every* feature, not just critical ones.
- ✅ **One BLoC unit test per bloc/cubit (#2)** — success, empty, failure for every event. Drop scattered mocked-repo edge cases that #4 now covers with real wiring.
- ✅ **A data-driven widget smoke (#5)** covering each reused widget and param-only screen in its key states (currently one app-wide table in `test/uikit/uikit_widgets_smoke_test.dart`).
- ✅ The feature's blocs **appear in the DI graph smoke test (#6)** (`test/core/di_graph_test.dart`).
- ✅ **Model test (#1) only** for non-trivial mapping (enums, `@JsonKey` defaults, non-obvious nested) — skip plain round-trips entirely.

Central, once for the whole app: the **executor tests (#3)** and the **DI graph smoke test (#6)** — both already at the efficient frontier; leave them as-is.

> **Net effect:** test *count* can drop while coverage *rises* — you trade narrow mocked-repo bloc cases and model round-trips for one real vertical slice per feature, and collapse the widget layer into a table.

## 3. Layout

The current tree:

```
test/features/{feature}/
├── assets/        # feature-local JSON fixtures (e.g. task/task1.json, profile/user.json)
├── model/         # *MockModels fixture builder (rawX + built X via fromJson)
├── data/          # API-DS unit tests (+ grandfathered per-repo tests — don't add new ones)
├── bloc/          # bloc unit tests
└── integration/   # feature-flow tests (mandatory per feature)
test/core/di_graph_test.dart              # DI smoke (app-wide)
test/uikit/uikit_widgets_smoke_test.dart  # data-driven widget smoke table (app-wide)
test/support/
├── pump.dart      # wrapApp() / wrapWidget() for widget smokes
├── finders.dart   # shared finders
├── fixtures.dart  # fixtureMap/List(feature, file)  +  sharedFixtureMap/List(file)
└── assets/        # shared cross-feature fixtures (add when a fixture is used by 2+ features)
```

There are no per-feature `widget/` test directories today — widget smokes live in the app-wide
table; add a per-feature dir only when a feature accumulates bespoke-finder tests.

**Fixtures have two homes:** a fixture used by **one** feature lives in `test/features/<feature>/assets/` (load via `fixtureMap('<feature>', 'x.json')`); a fixture used by **several** features lives in `test/support/assets/` (load via `sharedFixtureMap('x.json')` — no feature, so there's no cross-feature path coupling). Never hand-roll a `_rawJson`/`File(...).readAsStringSync()` loader — always go through `test/support/fixtures.dart`.

## 4. Shared conventions

- **Build models from JSON + `fromJson`**, never construct domain models inline in assertions. Keep fixtures in `assets/` and the built models in a per-feature `*MockModels` builder (e.g. `TaskMockModels.task1` / `ProfileMockModels.user` / `.rawUser`) so DS, bloc, and integration tests share one source of truth.
- **Exercise real `fromJson`/`toJson` on the way** through the `Api*DataSource` test — invoke the captured `fromJson` on a raw fixture, capture the request `body` for `toJson` (§5.1). Don't stub `fromJson: any(named:)` and return a hand-built model.
- **`registerFallbackValue`** for every custom type used inside an `any(named:)`/`any()` matcher (mocktail), in `setUpAll` — including `HttpMethod` and the `T Function(Map<String,dynamic>)` `fromJson` type when those are matched with `any(named:)`.
- **No `state.toString()` assertions** — compare states via Freezed's generated equality.
- **No sleep-based waits.** Use `blocTest`'s `wait:` only for **debounce** windows; **never** to sit through retry backoff — assert the failure state with a repo that throws immediately and let the executor test (#3) own retry timing.

## 5. Patterns

### 5.1 Model serialization (#1) — exercise real `fromJson`/`toJson` *on the way*

A standalone `fromJson`/`toJson` round-trip tests the **generator** (already tested upstream) and only inflates line coverage on `*.g.dart`/`*.freezed.dart`. **Don't write round-trips.** Instead, exercise the model's *real* (de)serialization **on the production path** — through the `Api*DataSource` test that already has to exist, where the data source passes `fromJson:`/`body: model.toJson()` to `ApiClient.requestJson`. One test then covers the DS wiring **and** the serialization, with no duplicated model literals.

#### Step 1 — a fixture builder per feature (no duplication)

Keep the raw JSON and the built models in one place, so every test (DS, bloc, integration) shares a single source of truth:

```dart
// test/features/profile/model/profile_mock_models.dart
class ProfileMockModels {
  static dynamic _json(String f) =>
      jsonDecode(File('test/features/profile/assets/$f').readAsStringSync());

  static final Map<String, dynamic> _rawUser = _json('user.json') as Map<String, dynamic>;

  static Map<String, dynamic> get rawUser => Map<String, dynamic>.from(_rawUser);
  static final User user = User.fromJson(_rawUser);          // built once, via the real fromJson
}
```

#### Step 2 — run the *real* `fromJson` (don't stub it away)

`requestJson<T>` takes a `fromJson:` callback. Stubbing it with `fromJson: any(named: 'fromJson')` and returning a hand-built model **bypasses deserialization entirely**. Instead, reach into the recorded invocation, pull out the **real** callback the DS passed, and apply it to the raw fixture — so `T.fromJson` actually runs:

```dart
// A reusable answer: applies the real fromJson the DS passed to a raw fixture.
Future<User> Function(Invocation) deserialize(Map<String, dynamic> raw) =>
    (invocation) async {
      final fromJson =
          invocation.namedArguments[#fromJson] as User Function(Map<String, dynamic>);

      return fromJson(raw);
    };

test('GETs /profile and deserializes via the real User.fromJson', () async {
  when(
    () => mockApiClient.requestJson<User>(
      method: HttpMethod.get,
      path: '/profile',
      fromJson: any(named: 'fromJson'),
    ),
  ).thenAnswer(deserialize(ProfileMockModels.rawUser));      // ← real fromJson runs here

  final result = await dataSource.getUserProfile();

  expect(result, ProfileMockModels.user);                    // equal to the fixture-built model
});
```

The exact methods: `invocation.namedArguments[#fromJson]` (the `#fromJson` symbol keys the named arg) → cast to `T Function(Map<String, dynamic>)` → call it on the raw map.

#### Step 3 — run the *real* `toJson` (capture the request body)

For write endpoints the DS sends `body: model.toJson()`. Capture it with `captureAny(named: 'body')` and assert **concrete serialized values** (not just equality to `model.toJson()`, which is circular) — that proves `toJson` produced the right wire shape, e.g. a `DateTime` rendered as ISO:

```dart
test('PUTs the User serialized via the real toJson, then deserializes the reply', () async {
  when(
    () => mockApiClient.requestJson<User>(
      method: HttpMethod.put,
      path: '/profile',
      body: any(named: 'body'),
      fromJson: any(named: 'fromJson'),
    ),
  ).thenAnswer(deserialize(ProfileMockModels.rawUpdatedUser));

  final result = await dataSource.updateUserProfile(ProfileMockModels.user);

  expect(result, ProfileMockModels.updatedUser);

  final body = verify(
    () => mockApiClient.requestJson<User>(
      method: HttpMethod.put,
      path: '/profile',
      body: captureAny(named: 'body'),                       // ← capture what toJson produced
      fromJson: any(named: 'fromJson'),
    ),
  ).captured.single as Map<String, dynamic>;

  expect(body['birthday'], '1990-01-01T00:00:00.000');       // real toJson: DateTime → ISO
  expect(body, ProfileMockModels.user.toJson());             // DS forwards the serialized model
});
```

#### Fallbacks & matchers

- If the `when` matcher uses `any(named: 'method')` / `any(named: 'fromJson')`, register fallbacks **once** in `setUpAll`: `registerFallbackValue(HttpMethod.get);` and a fallback for the function type (`registerFallbackValue(User.fromJson);`). If instead you match the **literal** `method: HttpMethod.get` / `path: '/profile'` (preferred — it also asserts the wiring), no `HttpMethod` fallback is needed.
- **Void endpoints** (`requestVoid`, e.g. `logout`) carry no model — assert the wiring only:
  ```dart
  test('logout POSTs /auth/logout', () async {
    when(() => mockApiClient.requestVoid(method: HttpMethod.post, path: '/auth/logout'))
        .thenAnswer((_) async {});
    await dataSource.logout();
    verify(() => mockApiClient.requestVoid(method: HttpMethod.post, path: '/auth/logout')).called(1);
  });
  ```

#### The only standalone #1 test left

Write a separate model test **only** when a non-obvious mapping is reached by *no* DS test — an enum fallback or `@JsonKey(defaultValue:)`:

```dart
test('TaskPriority falls back to normal on an unknown wire string', () {
  expect(Task.fromJson(fixtureMap('task', 'task_unknown_priority.json')).priority,
      TaskPriority.normal);
});
```

### 5.2 BLoC unit (#2) — the backbone

Mock the repository, drive every event, assert the state sequence. Cover **success, empty, failure** per event.

```dart
class MockTaskRepository extends Mock implements TaskRepository {}

blocTest<TasksListBloc, TasksListState>(
  'emits [loading, success] on requested',
  build: () {
    when(() => repository.getTasks())
        .thenAnswer((_) async => TaskMockModels.allTasks);
    return TasksListBloc(repository);
  },
  act: (bloc) => bloc.add(const TasksListEvent.requested()),
  expect: () => [
    const TasksListState.loading(),
    isA<SuccessTasksListState>(),
  ],
);
```

- **Nested-status blocs** (e.g. `CalendarBloc`): drive the bloc and assert against the state's persistent data plus the nested status (`state.selectedDate`, `state.status`) — that's the contract the UI consumes. **Debounced blocs** (e.g. `TasksSearchBloc`) are the one legitimate `wait:` use.
- **Failure path:** make the mocked repo **throw immediately** and assert the bloc reaches its failure state — `expect` it directly, no `wait:`. Retry *behaviour* (that the executor retries N times with backoff) is **not** the bloc's concern; it is proven once in the executor test (#3). Never pay an `8s` `wait:` to sit through real backoff in a bloc test.


### 5.3 Repository executor (#3) — central, in `starter_toolkit` *(leave as-is)*

The only real repo-layer logic, shared by every repository, and the **single owner of retry/backoff timing**. Test it **once**. This tier is already at the efficient frontier — don't expand or duplicate it per feature.

```dart
test('withErrorHandling passes an AppException through, maps DioException', () {
  final executor = const RawRepositoryExecutor().withErrorHandling();
  expect(
    () => executor.execute<void>(() async => throw const NoInternetException()),
    throwsA(isA<NoInternetException>()),
  );
  // a DioException is mapped by status code via AppException.fromDioResponse
});

test('withRetry retries a retryable failure up to maxRetries attempts', () async {
  var calls = 0;
  final executor = const RawRepositoryExecutor()
      .withErrorHandling()
      .withRetry(maxRetries: 3, retryDelay: const Duration(milliseconds: 1));
  await expectLater(
    executor.execute<void>(() async { calls++; throw const NoInternetException(); }),
    throwsA(isA<NoInternetException>()),
  );
  expect(calls, 3); // maxRetries total attempts; non-retryable → 1
});
```

### 5.4 Feature-flow / integration (#4) — the backbone, mandatory per feature

Wire the **real** bloc, **real** repository, and the **real `Mock*DataSource`** — stub nothing else. This is the most coverage-dense test in the suite: one run proves the whole shipping path (delegation included) and exercises real behaviour, which is why it **replaces** per-repository unit tests and scattered mocked-repo bloc edge cases.

**Assert two paths, not one** — the happy path *and* one error branch. The error assertion roughly doubles the slice's vertical coverage for one extra `expect`: it exercises the executor's error *mapping*, the repo's error delegation, and the bloc's failure state together. Highest marginal ROI in the suite.

```dart
// test/features/task/integration/integration_test.dart (target shape)
class _ThrowingTaskDataSource implements TaskDataSource {
  // every method throws — e.g. `throw const NoInternetException();`
}

void main() {
  TasksListBloc buildBloc(TaskDataSource dataSource) => TasksListBloc(
        TaskRepository(
          const RawRepositoryExecutor().withErrorHandling(),
          dataSource,                    // ← the data source that ships
        ),
      );

  test('task-list flow reaches a grouped success state', () async {
    final bloc = buildBloc(MockTaskDataSource());
    bloc.add(const TasksListEvent.requested());
    await bloc.stream.firstWhere(
      (s) => s is SuccessTasksListState || s is FailureTasksListState,
    );
    expect(bloc.state, isA<SuccessTasksListState>());
  });

  test('task-list flow surfaces a failure end-to-end', () async {
    final bloc = buildBloc(_ThrowingTaskDataSource());
    bloc.add(const TasksListEvent.requested());
    await bloc.stream.firstWhere(
      (s) => s is SuccessTasksListState || s is FailureTasksListState,
    );
    expect(bloc.state, isA<FailureTasksListState>()); // executor map + repo + bloc, one expect
  });
}
```

> **Current suite note:** the existing integration tests (e.g. the task one) wire the
> `Api*DataSource` with a mocked `ApiClient` — the pre-doctrine shape. They are grandfathered;
> write new feature-flow tests in the `Mock*DataSource` shape above.
>
> **API contract path:** when an `Api*DataSource` exists or is being added, keep its `*_api_test.dart`
> separate from mock-first flow tests. Wire `Api*DataSource` + a mocked `ApiClient` to lock method/path/body
> shape, then run the captured `fromJson`/`toJson` on fixtures (see
> `test/features/profile/data/api_profile_data_source_test.dart`).

### 5.5 Widget smoke (#5) — data-driven

One helper, then a **table loop** over `(widget, state)` pairs — pump each, assert it builds. This collapses what used to be S×N hand-written `testWidgets` into roughly one `S` per widget with identical crash / l10n / nullable-branch coverage. This is the **only** layer that catches a `build()` crash, a **deleted l10n key**, a missing provider, or a broken nullable branch. The live example is `test/uikit/uikit_widgets_smoke_test.dart`.

```dart
// test/support/pump.dart
Widget wrapApp(Widget child) => MaterialApp(
  locale: const Locale('ru'),
  localizationsDelegates: const [
    Localizer.delegate, UikitLocalizer.delegate, ToolkitLocalizer.delegate,
    GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate, // so `ru` is supported by all delegates
  ],
  supportedLocales: Localizer.delegate.supportedLocales,
  home: ThemeProvider(child: child),
);
Widget wrapWidget(Widget child) => wrapApp(Scaffold(body: child)); // leaf widgets
```

```dart
// One loop replaces N near-identical testWidgets blocks
// (real table: test/uikit/uikit_widgets_smoke_test.dart).
final smokeCases = <String, Widget Function()>{
  'TitleAppBar': () => const Scaffold(appBar: TitleAppBar(title: 'Title')),
  'EmptyInformationBody': () => const EmptyInformationBody(text: 'Empty'),
  'FailureWidget.large': () =>
      FailureWidget.large(exception: _exception, onRetry: () {}),
  'FailureWidget.small': () =>
      FailureWidget.small(exception: _exception, onRetry: () {}),
  'CustomCircularProgressIndicator': () =>
      const CustomCircularProgressIndicator.adaptive(),
};

smokeCases.forEach((name, build) {
  testWidgets('$name builds without throwing', (tester) async {
    await tester.pumpWidget(wrapApp(build()));
    await tester.pumpAndSettle();              // let localization load
    expect(tester.takeException(), isNull);    // ← the assertion that matters
  });
});
```

**Grow the table from this repo's reused widgets** — each row guards every screen that embeds the widget. Good candidates beyond the uikit table: `TaskDateGroupCard` (task list), `CalendarHorizontalDatePicker` / `CalendarDatePickerItem` (calendar), `SettingsCard` / `SectionHeader` (settings menu), `TaskDetailsContent` (task details). Reserve a separate bespoke-finder test only where the *content* (not just absence of a crash) is the contract — e.g. an empty task list rendering the empty state.

> Don't pump **bloc-driven full screens** (they create their bloc via `getIt`); that needs DI setup for little gain. Their child widgets are covered by the table above, their logic by the bloc test. If you must, register a stub bloc in `getIt` for that test.

### 5.6 DI graph smoke (#6) — one test, biggest safety/line *(leave as-is)*

Configure every module, resolve every feature type. Catches a missing/broken registration (the `factory` vs `lazySingleton` bug class) instantly instead of at runtime. Already efficient — don't touch it.

```dart
// test/core/di_graph_test.dart (abridged — see the real file)
void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    // …stub the flutter_secure_storage method channel the same way
    await getIt.reset();
    await AppConfigurator.configure();
  });

  test('GetIt-registered blocs resolve', () {
    expect(getIt<CalendarBloc>(), isA<CalendarBloc>());
    expect(getIt<TasksListBloc>(), isA<TasksListBloc>());
    expect(getIt<TasksSearchBloc>(), isA<TasksSearchBloc>());
    expect(getIt<TaskCreationBloc>(), isA<TaskCreationBloc>());
    expect(getIt<LoginBloc>(), isA<LoginBloc>());
    expect(getIt<RegistrationBloc>(), isA<RegistrationBloc>());
    expect(getIt<OtpBloc>(), isA<OtpBloc>());
    expect(getIt<UserBloc>(), isA<UserBloc>());
    // …one line per feature bloc
  });
}
```

> Core/Data modules touch platform plugins (shared_preferences, secure storage). Stub those channels in `setUp` (as above). The goal is only "the graph resolves," so the stubs can be empty.

---

## 6. Running & coverage

```bash
fvm flutter test --concurrency 4              # all tests
fvm flutter test --coverage --concurrency 4   # with coverage
fvm flutter test test/features/task           # one feature
```

**Use a coverage *filter*, not a coverage *target*.** Exclude generated and wiring-only files so the number means **logic coverage** — otherwise you're tempted to write a vanity test to fill a generated line, and the "map of gaps" is unreadable. Two equivalent ways:

- Annotate generated/entry files with `// coverage:ignore-file` (top of `main.dart`, DI registration files), or
- Filter the lcov report before reading it:

```bash
fvm flutter test --coverage --concurrency 4
lcov --remove coverage/lcov.info \
  '*.g.dart' '*.freezed.dart' '*/main.dart' '*/configs/*_module.dart' '*/di/*' \
  -o coverage/lcov.cleaned.info
```

Or just run **`utils/coverage.sh`** — it runs the suite, applies the filter, prints a per-layer breakdown (BLoC / data / domain / executor vs UI), and writes `coverage/html/index.html`.

Coverage is a *map of gaps*, not a target — read the **filtered** report to find untested *logic* branches; don't chase a number. No target coverage figures are tracked; expect the logic layers to sit well above the all-in filtered number, which the untested UI-screen surface drags down — that's expected, since full bloc-driven screens aren't pumped (§5.5).

## 7. Anti-patterns

| Don't | Do |
|-------|----|
| Round-trip every model through JSON | Exercise `fromJson`/`toJson` **on the way** through the API-DS test (§5.1); standalone only for enum/`@JsonKey` defaults (#1) |
| Stub `fromJson: any(named:)` and return a hand-built model | Invoke the **captured** `fromJson` (`invocation.namedArguments[#fromJson]`) on a raw fixture; build the expected model from the same fixture |
| Assert `body == model.toJson()` and call it a toJson test | `captureAny(named: 'body')` then assert **concrete serialized values** (e.g. `body['birthday'] == '…ISO…'`) |
| Add a standalone test for a mock's fault-injection trigger | Don't unit-test the mock DS at all — cover its happy + error path via the feature-flow test (#4) |
| Pay `wait: 8s` to sit through retry backoff in a bloc test | Assert failure with an **immediately-throwing** repo; retry timing is the executor's (#3) |
| Unit-test a thin repository (`verify(ds.getX).called(1)`) | Cover it via the mandatory feature-flow test (#4); existing per-repo tests are grandfathered |
| Ship a feature-flow test with only a happy path | Add **one failure-state assertion** (#4) |
| Hand-write N near-identical widget smokes | Loop a `(widget, state)` table; bespoke finders only where content matters (#5) |
| Integration-test the `ApiClient` path with a full feature-flow slice | Integration-test the **mock** path that ships (#4); lock the `ApiClient` contract separately (§5.1) |
| Re-test error/retry per repository | Test the executor once, centrally (#3) |
| Chase 100% coverage everywhere | Follow the per-feature policy (§2); read the **filtered** coverage report |
| `sleep()` / real delays | `blocTest` `wait:` (debounce only) or `fakeAsync` |
| Construct domain models inline in tests | Build from JSON fixtures via `fromJson` |

---

## See also

- [../ai-context/testing.md](../ai-context/testing.md) — condensed cheat-sheet.
- [bloc.md](../rules/bloc.md) — bloc state shapes the bloc tests assert against.
- [exception_handling.md](./exception_handling.md) — what the executor tests (#3) verify.
