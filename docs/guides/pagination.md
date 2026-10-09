# Pagination Guide

Page-based "load more" lists with the toolkit/uikit pieces shipped in this starter. Compact rules (`PAG-*`):
[../ai-context/pagination.md](../ai-context/pagination.md). Worked example throughout: **Task search**
(`lib/features/task/ui/search/`), the only paginated flow in the template. Pull-to-refresh comes from **Task list**
(`lib/features/task/ui/list/`), the canonical `RefreshableBloc` consumer.

## 1. Overview

| Layer | Type | Where | Role |
|---|---|---|---|
| Data / Domain | `PaginatedListItems<T>` | `packages/starter_toolkit/lib/data/model/paginated_list_items.dart` | Wire model — what the API returns; `DataSource`/`Repository` methods are typed with it |
| BLoC state | `PaginatedData<T>` | `packages/starter_toolkit/lib/utils/bloc/paginated_data.dart` | Immutable Equatable accumulator of pages: `canLoadMore`, `nextPage`, `merge(...)` |
| BLoC state | `BlocLoadState` | `packages/starter_toolkit/lib/utils/bloc/bloc_load_state.dart` | Enum `initial / loading / loaded / failure` — the **load-more** status, nested in the data-carrying state variant |
| UI | `PaginatedListView<T>` / `SliverPaginatedListView<T>` | `packages/starter_uikit/lib/widgets/screen/paginated_list_view.dart` | Renders `PaginatedData`, calls `onLoadMore` when the trailing slot appears, shows the loading/error slot |
| UI | `MultiBlocRefreshIndicator` + `RefreshableBloc` | `packages/starter_uikit/lib/widgets/screen/multi_bloc_refresh_indicator.dart`, `packages/starter_toolkit/lib/utils/bloc/refreshable_bloc.dart` | Pull-to-refresh that waits for every listed BLoC to finish reloading |

Flow: the `DataSource` returns one `PaginatedListItems<T>` per `page`; the BLoC converts it with
`PaginatedData.fromApi(...)`, stores it next to a `BlocLoadState loadMoreState`, and appends later pages with
`data.merge(...)`. The widget owns scroll-position logic, the BLoC owns page logic.

Live demo: `packages/starter_uikit/lib/example/screens/pagination_example_screen.dart` (UI Kit gallery → "Pagination",
via the dev-mode tap gesture). It uses `setState` only to show the widget; in an app the state pair lives in a BLoC.

## 2. Core classes

### `PaginatedListItems<T>` — wire model

`@Freezed(genericArgumentFactories: true)`; JSON keys equal the field names. No helpers on purpose — it is the API
contract, not state.

```dart
PaginatedListItems<T>({
  required int pageLimit,   // items per page the server used
  required int countItems,  // total matching items
  required int countPages,  // total pages
  required List<T> elements,
})
```

### `PaginatedData<T>` — state accumulator

Plain `Equatable` (not Freezed) so it can live inside any Freezed state and compare by value.
Fields: `page` (last merged page), `pagesCount`, `items`, `itemsCount`, `perPage`;
`PaginatedData.fromApi(PaginatedListItems<T> data, {int page = 1})`.

| Member | Meaning |
|---|---|
| `items` / `length` / `isEmpty` | What has been loaded so far |
| `canLoadMore` / `reachedEnd` | `page < pagesCount` / `page == pagesCount` |
| `nextPage` | `page + 1` — pass this to the repository |
| `merge(next)` | Appends `next.items`, bumps `page`, takes the counts from the new page |
| `add(item)` / `addToStart(item)` | Optimistic insert; bumps `itemsCount` |
| `copyWith(...)` | Field-level override |

There is **no** `remove` / `removeWhere` / `update` / `map` — see §9.

### `BlocLoadState`

`enum { initial, loading, loaded, failure }` with `isLoading`. Being an enum, a load-more `failure` carries no
`AppException` (§9). The first-page load uses the state's normal `loading` / `success` / `failure(AppException)` variants.

### `PaginatedListView<T>` / `SliverPaginatedListView<T>`

Required: `data`, `status` (the load-more status), `itemBuilder(context, item, index)`, `onLoadMore`. Optional on the
box variant: `shrinkWrap`, `loadingIndicator` (default adaptive spinner), `errorWidget` (default `SizedBox.shrink()` —
pass a retry button), `controller`, `padding`, `physics`, `separator` (switches to `ListView.separated`). The sliver
variant takes `data`, `status`, `itemBuilder`, `onLoadMore`, `loadingIndicator`, `errorWidget` and goes inside a
`CustomScrollView`.

Trigger: when `data.canLoadMore`, the list renders one extra trailing slot. It calls `onLoadMore()` (via
`addPostFrameCallback`) when it first enters the tree **and** whenever `status` changes, but only while `status` is
`initial` or `loaded`. `loading` shows the indicator; `failure` shows `errorWidget` and waits — nothing auto-retries, so
the error widget must dispatch the event again.

### `RefreshableBloc` and `MultiBlocRefreshIndicator`

`RefreshableBloc` is a mixin with `refreshing` (get/set), `refreshingStream`, and `dispose()` (call from `close()`).
`MultiBlocRefreshIndicator({child, blocs, onRefresh, …RefreshIndicator options})` sets `refreshing = true` on every
bloc, awaits `onRefresh` (dispatch `.refreshed()` there), then keeps the spinner until every bloc sets
`refreshing = false`.

## 3. The BLoC

### 3.1 Events

Three past-tense events (`BLOC-8`) with private case classes: `requested()`, `loadMoreRequested()`, `refreshed()`.
Task search replaces `requested()` with `queryChanged(query)` / `querySubmitted(query)` because the trigger carries input.

### 3.2 State

Pick Shape A or B per [freezed_bloc.md](freezed_bloc.md#state-shape-decisions). The only pagination-specific rule is
**where the load-more status lives**: inside the variant that carries the data, as `BlocLoadState loadMoreState`
defaulting to `loaded` — never a separate `loadingMore` variant or a top-level bool.

Shape A (only the list persists — a plain feed): `success({required PaginatedData<Item> data,
@Default(BlocLoadState.loaded) BlocLoadState loadMoreState})` next to `initial` / `loading` / `failure(AppException)`.

Shape B is what Task search ships (`tasks_search_event_state.dart`): query and recent queries persist in an outer
`abstract` state, the list lives in the nested status union:

```dart
const factory TasksSearchStatus.results({
  required PaginatedData<Task> data,
  required String query,
  @Default(BlocLoadState.loaded) BlocLoadState loadMoreState,
}) = ResultsTasksSearchStatus;
// siblings: idle, loading, suggestions({tasks, query}), failure(AppException)
// outer TasksSearchState: status, query, recentQueries
```

Why `@Default(BlocLoadState.loaded)`: a fresh first page is "settled", and `PaginatedListView` auto-requests page 2 from
`loaded` as soon as the trailing slot is visible — so a short first page on a tall screen fills the viewport with no
extra code.

### 3.3 Handlers

The real load-more handler (`tasks_search_bloc.dart`), annotated:

```dart
on<_LoadMoreRequestedTasksSearchEvent>(
  _onLoadMoreRequested,
  transformer: droppable(),             // (1) a load-more while one is in flight is dropped
);

Future<void> _onLoadMoreRequested(_LoadMoreRequestedTasksSearchEvent event, Emitter<TasksSearchState> emit) async {
  final status = state.status;
  if (status is! ResultsTasksSearchStatus || !status.data.canLoadMore) {
    return;                             // (2) only from the data-carrying variant, only if a page is left
  }

  emit(state.copyWith(
    status: status.copyWith(loadMoreState: BlocLoadState.loading),  // (3) items stay on screen
  ));

  try {
    final nextPage = await _taskRepository.searchTasks(
      status.query,
      page: status.data.nextPage,       // (4) page number comes from the data, never a counter field
    );
    if (emit.isDone) {
      return;
    }

    return emit(state.copyWith(
      status: status.copyWith(
        data: status.data.merge(PaginatedData.fromApi(nextPage)),   // (5) immutable append
        loadMoreState: BlocLoadState.loaded,
      ),
    ));
  } on AppException catch (_) {
    return emit(state.copyWith(
      status: status.copyWith(loadMoreState: BlocLoadState.failure),  // (6) keep data, flag the slot
    ));
  }
}
```

First page and refresh share one private method (`_runQuery`): emit `loading`, fetch `page: 1`, emit
`results(data: PaginatedData.fromApi(firstPage), query: query)` or `failure(e)`. `refreshed()` re-runs it with
`state.query` — the UI never re-extracts data from state to retry. Register the BLoC like any other
(`..registerFactory(() => TasksSearchBloc(getIt<TaskRepository>()))` in `task_module.dart`).

For a Shape A list the handler is the same with `successState.copyWith(...)` instead of `status.copyWith(...)`. Add
`with RefreshableBloc` for pull-to-refresh and copy `_onRefreshed` / `close()` from `TasksListBloc`:

```dart
/// No `loading` emit: the indicator is already visible and `loading` would unmount the scrollable.
Future<void> _onRefreshed(_RefreshedItemsListEvent event, Emitter<ItemsListState> emit) async {
  try {
    return await _loadFirstPage(emit);   // fetches page 1, emits success(data: PaginatedData.fromApi(...)) or failure(e)
  } finally {
    refreshing = false;
  }
}

@override
Future<void> close() {
  dispose();

  return super.close();
}
```

`CalendarBloc` shows the variant where `refreshed()` also serves the retry button: `if (!refreshing) emit(loading)`.

## 4. API / data-source contract

One method per paginated endpoint, typed with the wire model, page as a required named parameter:

```dart
// TaskDataSource (domain/) — TaskRepository is a pass-through under the executor
Future<PaginatedListItems<Task>> searchTasks(String query, {required int page});
```

The REST implementation (`ApiTaskDataSource`, `lib/features/task/data/api_task_data_source.dart`) puts `page` in the
query string and passes the generic `fromJson` through:

```dart
_client.requestJson<PaginatedListItems<Task>>(
  method: HttpMethod.get,
  path: '/tasks/search',
  queryParameters: {'query': query, 'page': page},
  fromJson: (json) => PaginatedListItems.fromJson(json, (e) => Task.fromJson(e! as Map<String, dynamic>)),
);
```

Expected body: `{ "pageLimit": 10, "countItems": 42, "countPages": 5, "elements": [ ... ] }`. If a backend uses different
keys, map them in the data source (a per-feature DTO), not in the BLoC.

The mock twin (`lib/features/task/data/mock/mock_task_data_source.dart`) returns the **same shape**: after
`await _network.simulate()` it filters the seed, slices `(page - 1) * pageSize` with
`MockTaskScenarios.searchPageSize` (`mock_task_scenarios.dart`), and reports `countItems` / `countPages`
(`(matches.length / pageSize).ceil()`) like the server would.

Page numbering is **1-based** everywhere: the BLoC asks for `page: 1` first, `fromApi` defaults `page` to 1, `nextPage`
is `page + 1`.

## 5. UI

### 5.1 Rendering the list

The screen switches exhaustively on the status and hands the two fields to a small widget
(`tasks_search_screen.dart`, `search_results_list.dart`):

```dart
ResultsTasksSearchStatus(:final data, :final loadMoreState) =>
    SearchResultsList(data: data, loadMoreState: loadMoreState),
// other arms: idle → RecentQueriesList, loading → skeleton,
// failure → FailureWidget.large(onRetry: add(TasksSearchEvent.refreshed()))
```

```dart
// SearchResultsList.build
if (data.isEmpty) {
  return EmptyInformationBody(text: Localizer.of(context).noResultsFound);
}

return PaginatedListView<Task>(
  data: data,
  status: loadMoreState,
  onLoadMore: () => context.read<TasksSearchBloc>().add(const TasksSearchEvent.loadMoreRequested()),
  errorWidget: Center(
    child: TextButton(
      onPressed: () => context.read<TasksSearchBloc>().add(const TasksSearchEvent.loadMoreRequested()),
      child: Text(Localizer.of(context).retry),
    ),
  ),
  itemBuilder: (context, task, index) => Card(margin: EdgeInsets.zero, child: TaskListItemTile(task: task)),
);
```

Copy: the empty check **before** the list (`EmptyInformationBody`, `UI-3`); `errorWidget` re-dispatching
`loadMoreRequested()`; strings from `Localizer` (`UI-1`). Wrapping a non-paginated list in a single-page
`PaginatedData` (the `suggestions` arm) is an acceptable way to reuse the widget.

### 5.2 Slivers

Inside a `CustomScrollView` use `SliverPaginatedListView<Item>(data:, status:, onLoadMore:, itemBuilder:)` among the
slivers — same arguments, no scroll parameters.

### 5.3 Pull-to-refresh

`MultiBlocRefreshIndicator` wraps the `BlocBuilder` so the indicator survives state changes (`tasks_list_screen.dart`):

```dart
body: MultiBlocRefreshIndicator(
  blocs: [context.read<TasksListBloc>()],
  onRefresh: () async => context.read<TasksListBloc>().add(const TasksListEvent.refreshed()),
  child: BlocBuilder<TasksListBloc, TasksListState>(builder: (context, state) => TasksListStatusBody(state: state)),
),
```

Requirements: every bloc in `blocs` mixes in `RefreshableBloc`; its refresh handler ends with
`finally { refreshing = false; }` (else the spinner never hides); `close()` calls `dispose()`. For several blocs, list
them all and dispatch each `.refreshed()` inside `onRefresh` (`calendar_screen.dart` shows the single-bloc case).

Combining both on one screen (none does yet — the search screen deliberately has no pull-to-refresh, inferred from
`TasksSearchBloc` not mixing in `RefreshableBloc`): `MultiBlocRefreshIndicator` outside, `PaginatedListView` inside with
`physics: const AlwaysScrollableScrollPhysics()` so a short first page can still be pulled (as in
`pagination_example_screen.dart`).

## 6. Load-more rules

1. **Guard first.** Return unless the status is the data-carrying variant **and** `data.canLoadMore`; match with `is!`
   on a local so the promoted local is reused.
2. **One in flight.** `transformer: droppable()` replaces an `isLoadingMore` flag; a request arriving mid-load is
   dropped, not queued.
3. **Flag, don't replace.** First emit is `copyWith(loadMoreState: loading)` on the existing variant; items stay on screen.
4. **Ask for `data.nextPage`.** No counter field on the bloc (`BLOC-1`).
5. **Merge immutably.** `data.merge(PaginatedData.fromApi(nextPage))` — never `items.add(...)`, never hand-build `PaginatedData`.
6. **Failure keeps the data.** `on AppException` → `loadMoreState: failure` on the same variant; the top-level
   `failure(exception)` would throw away everything already scrolled.
7. **Guard after every `await`** in a `restartable()`/`droppable()` handler: `if (emit.isDone) return;`
   ([bloc.md](../ai-context/bloc.md), "Debounced / restartable handlers").
8. **Refresh = page 1 again** from state (`state.query` in search), producing a brand-new `PaginatedData` — never a merge.

Known edge (inference, not a bug report): handlers for *different* event types run concurrently, so a `refreshed()`
completing while a load-more is in flight is overwritten by the load-more's `status.copyWith(...)` built from the
pre-refresh `status`. If a screen can trigger both at once, re-read `state.status` after the `await` and bail when it is
no longer the same results variant (same `query`, same `data.page`).

## 7. Anti-patterns

Each is the inverse of a §6 rule; the extras:

| Don't | Do instead |
|---|---|
| `ListView.builder` + `ScrollController` listener / `addPostFrameCallback` to fire load-more | `PaginatedListView` / `SliverPaginatedListView` (`UI-3`) |
| A `loadingMore` variant or `isLoadingMore: bool` on the outer state | `loadMoreState` inside the data-carrying variant |
| `int _page = 1;` on the bloc; `state.data.items.add(...)` | `data.nextPage`; `data.merge(...)` / `data.add(item)` (in-place mutation defeats `BlocBuilder` equality and `blocTest`) |
| Top-level `failure(e)` when page N fails | `loadMoreState: failure` |
| Emitting `loading` from `refreshed()` under `MultiBlocRefreshIndicator`; leaving `refreshing` true | Skip the emit (or `if (!refreshing)`); `finally { refreshing = false; }` |
| `List<T>` from the data source with page metadata invented in the bloc | `PaginatedListItems<T>`; the twin returns the same shape (`M1`) |
| `Future.delayed` or a per-feature page-size literal in the twin | `await _network.simulate()`, `Mock*Scenarios.searchPageSize` (`M3`, `M7`) |

## 8. Testing notes

Per [testing.md](testing.md): a **BLoC unit test (#2)** and the feature's **feature-flow test (#4)**; the list widget is
already a row in the uikit smoke table (#5).

### 8.1 BLoC unit (#2) — load-more branches

Scaffold like `test/features/task/bloc/tasks_list_bloc_test.dart` (mocktail `Mock` of the abstract data source behind a
real `TaskRepository` with `RawRepositoryExecutor().withErrorHandling()`). Build page fixtures through
`TaskMockModels` (`T4`; add `searchPage1` / `searchPage2` returning `PaginatedListItems<Task>`) and seed the results state:

```dart
blocTest<TasksSearchBloc, TasksSearchState>(
  'loadMoreRequested merges page 2 and settles on loaded',
  build: () {
    when(() => dataSource.searchTasks(any(), page: 2)).thenAnswer((_) async => TaskMockModels.searchPage2);

    return bloc;
  },
  seed: () => TasksSearchState(
    query: 'task',
    status: TasksSearchStatus.results(data: PaginatedData.fromApi(TaskMockModels.searchPage1), query: 'task'),
  ),
  act: (bloc) => bloc.add(const TasksSearchEvent.loadMoreRequested()),
  expect: () => [
    // results(loadMoreState: loading) on page 1, then results(data: page1.merge(page 2), loaded)
  ],
);
```

Cover the three branches `TEST-4` asks for: merge (success), `canLoadMore == false` → no emit (empty), failure
(`thenThrow(const NoInternetException())` → `loadMoreState == failure` and page 1 still in `data`; immediate throw, no
`wait:` — `T6`). `PaginatedData` is Equatable, so `expect:` can compare whole states.

### 8.2 Feature-flow (#4) — real twin, nothing stubbed

Mirror `test/features/task/integration/integration_test.dart` (its `buildBloc` / `settle` helpers and
`_ThrowingTaskDataSource`) for the search bloc: build `TasksSearchBloc(TaskRepository(const
RawRepositoryExecutor().withErrorHandling(), MockTaskDataSource(const MockNetworkBehavior.instant())))`, add
`querySubmitted('meeting')`, await a `Results…` / `Failure…` status, assert `isA<ResultsTasksSearchStatus>()`; the error
branch swaps in `const _ThrowingTaskDataSource()`.

To make load-more observable through the twin, `MockTaskScenarios.seed()` must return more than `searchPageSize`
matches for some query — today 4 tasks against a page size of 10, so page 2 is unreachable in mock builds and in this
test (§9).

### 8.3 Widget smoke (#5)

`PaginatedListView` (end reached, loading more) and `MultiBlocRefreshIndicator` already have rows in
`test/uikit/uikit_widgets_smoke_test.dart`. The `loading` row sits in `endlessAnimationCases` because the trailing
spinner never settles — do the same for any new row rendering the loading slot. `SearchResultsList` reads
`TasksSearchBloc`, so it is covered through the bloc test, not pumped standalone.

## 9. Gaps vs eldik / recommended additions

The eldik guide this was adapted from describes things the starter does **not** have. None are required to use
pagination today; they are listed so nobody looks for them.

| eldik concept | Starter equivalent | Gap |
|---|---|---|
| `PaginatedItemsList<T>` (`offset`, `limit`, `totalCount`) | `PaginatedData<T>` (`page`, `pagesCount`, `itemsCount`, `perPage`) | Page-based, not offset-based. Nothing to add; map vocabulary (`offset/limit` → `page/perPage`, `totalCount` → `itemsCount`, `nextOffset` → `nextPage`). |
| `PaginationStatus` union with `failure(error)` | `BlocLoadState` enum | **A load-more failure carries no `AppException`** — `TasksSearchBloc` discards it (`on AppException catch (_)`), so the error row shows only a generic retry. Recommended: a sealed `PaginationStatus` (`initial / loading / loaded / failure(AppException)`) in `starter_toolkit/lib/utils/bloc/` with `PaginatedListView.status` widened, **or** a lighter `AppException? loadMoreException` next to `loadMoreState`. |
| `remove`, `removeWhere`, `update`, `map` on the container | `merge`, `add`, `addToStart`, `copyWith` only | In-place edits after delete/update are not expressible; the search screen re-runs the whole query after a delete instead. Recommended: the four immutable ops on `PaginatedData`, each adjusting `itemsCount`. |
| `RefreshableBloc`, `MultiBlocRefreshIndicator` | Same names and contract | No gap. |
| `requestedMore()`; `isLoadingMore` guard | `loadMoreRequested()`; `transformer: droppable()` | Naming / equivalent; no state getter needed. |

Other observations (inferences, for triage — this guide changes no code):

- `PaginatedData.fromApi` assigns `perPage: data.countPages`; `data.pageLimit` looks like the intended source. Harmless
  today (nothing reads `perPage` for control flow) but misleading in tests.
- There is no `test/features/task/bloc/tasks_search_bloc_test.dart`, and `integration_test.dart` only drives
  `TasksListBloc` — the sole paginated flow has no automated coverage of `loadMoreRequested` (§8 sketches the tests).
  The mock seed (4 tasks, page size 10) cannot produce a second page, so a larger seed or a sentinel query in
  `MockTaskScenarios` (`M7`) is needed before a load-more test can pass against the twin.

## See also

- [freezed_bloc.md](freezed_bloc.md) — Shape A vs B, handler rules, `restartable()` / `droppable()`
- [mocking.md](mocking.md) — twin layout, `MockNetworkBehavior`, scenarios
- [testing.md](testing.md) — test types #2 / #4 / #5
- [../ai-context/pagination.md](../ai-context/pagination.md) — `PAG-*` checklist
- [../ai-context/code_review.md](../ai-context/code_review.md) — `BLOC-*`, `UI-*`, `TEST-*` rules
