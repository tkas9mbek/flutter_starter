# Pagination — AI Context

Concise rules. Full guide: [../guides/pagination.md](../guides/pagination.md).

Three types, one per layer: the DataSource returns the wire model `PaginatedListItems<T>` (`packages/starter_toolkit/lib/data/model/`); the BLoC keeps `PaginatedData<T>` + `BlocLoadState loadMoreState` (`packages/starter_toolkit/lib/utils/bloc/`); the UI renders `PaginatedListView<T>` / `SliverPaginatedListView<T>` and refreshes via `MultiBlocRefreshIndicator` + `RefreshableBloc` (`packages/starter_uikit/lib/widgets/screen/`; gallery: `lib/example/screens/pagination_example_screen.dart`). References: `lib/features/task/ui/search/` (`TasksSearchBloc`, `SearchResultsList`); pull-to-refresh: `TasksListBloc` + `tasks_list_screen.dart`.

## Hard rules

| # | Rule |
|---|------|
| PAG-1 | DataSource/Repository methods return `PaginatedListItems<T>` and take `{required int page}` (1-based); the `Mock*` twin returns the same shape, slicing `(page - 1) * pageSize` with the page size in `Mock*Scenarios`. |
| PAG-2 | State stores `PaginatedData<T> data` (built with `PaginatedData.fromApi(...)`) and `@Default(BlocLoadState.loaded) BlocLoadState loadMoreState` **inside the data-carrying variant** — no separate `loadingMore` variant/bool, no `int _page` field. |
| PAG-3 | Events: `requested()` (or `querySubmitted(q)`), `loadMoreRequested()`, `refreshed()`; load-more registered with `transformer: droppable()`. |
| PAG-4 | Load-more handler: early-return unless `status is ResultsX && status.data.canLoadMore`; emit `loadMoreState: loading` on the same variant; fetch `page: data.nextPage`; `if (emit.isDone) return;` after the await. |
| PAG-5 | Append with `data.merge(PaginatedData.fromApi(nextPage))` — never mutate `items`, never hand-build `PaginatedData`. |
| PAG-6 | Load-more failure → `copyWith(loadMoreState: BlocLoadState.failure)` keeping `data`; never top-level `failure(e)`. |
| PAG-7 | UI: `PaginatedListView<T>` / `SliverPaginatedListView<T>` with `data`, `status: loadMoreState`, `onLoadMore` → `loadMoreRequested()`, and an `errorWidget` that re-dispatches it (the widget never auto-retries from `failure`). Empty first page → `EmptyInformationBody` before the list. |
| PAG-8 | `refreshed()` reloads page 1 from state (fresh `PaginatedData`, no merge). With `MultiBlocRefreshIndicator` the bloc mixes in `RefreshableBloc`, skips the `loading` emit, ends with `finally { refreshing = false; }`, and `close()` calls `dispose()`. |
| PAG-9 | Tests: `blocTest` for `loadMoreRequested` (merge / no-op when `!canLoadMore` / failure keeps data — immediately-throwing DS, no `wait:`) plus the feature-flow test through `Mock*DataSource(const MockNetworkBehavior.instant())`. |

## Shape

```dart
const factory TasksSearchStatus.results({
  required PaginatedData<Task> data,
  required String query,
  @Default(BlocLoadState.loaded) BlocLoadState loadMoreState,
}) = ResultsTasksSearchStatus;

Future<void> _onLoadMoreRequested(_LoadMoreRequestedTasksSearchEvent event, Emitter<TasksSearchState> emit) async {
  final status = state.status;
  if (status is! ResultsTasksSearchStatus || !status.data.canLoadMore) return;

  emit(state.copyWith(status: status.copyWith(loadMoreState: BlocLoadState.loading)));

  try {
    final nextPage = await _taskRepository.searchTasks(status.query, page: status.data.nextPage);
    if (emit.isDone) return;

    return emit(state.copyWith(
      status: status.copyWith(data: status.data.merge(PaginatedData.fromApi(nextPage)), loadMoreState: BlocLoadState.loaded),
    ));
  } on AppException catch (_) {
    return emit(state.copyWith(status: status.copyWith(loadMoreState: BlocLoadState.failure)));
  }
}

// UI (SearchResultsList): PaginatedListView<Task>(data:, status: loadMoreState, itemBuilder:,
//   onLoadMore: () => context.read<TasksSearchBloc>().add(const TasksSearchEvent.loadMoreRequested()),
//   errorWidget: /* retry button dispatching the same event */)
```

## Porting vocabulary (other codebases → starter)

- `PaginationStatus` union → `BlocLoadState` enum (a load-more failure carries no `AppException`).
- `PaginatedItemsList` (offset/limit/totalCount) → `PaginatedData` (page/pagesCount/itemsCount); only `merge`, `add`, `addToStart`, `copyWith` exist — no `remove`/`update`/`map`.
- `requestedMore()` → `loadMoreRequested()`; `isLoadingMore` guard → `transformer: droppable()`.

## Don't

- ❌ `ListView.builder` + scroll listener / `addPostFrameCallback` to trigger load-more.
- ❌ Separate `loadingMore` state, `isLoadingMore` bool, or `int _page` on the bloc.
- ❌ `items.add(...)` / `addAll(...)` on state, or hand-rebuilding `PaginatedData(page: page + 1, ...)`.
- ❌ Top-level `failure(e)` when page N fails — loaded items vanish.
- ❌ `emit(loading)` inside `refreshed()` under the refresh indicator; forgetting `refreshing = false`.
- ❌ `List<T>` from the data source with page metadata invented in the bloc; a twin returning a different shape than the API.
