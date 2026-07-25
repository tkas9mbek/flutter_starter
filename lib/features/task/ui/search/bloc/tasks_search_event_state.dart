part of 'tasks_search_bloc.dart';

@freezed
sealed class TasksSearchEvent with _$TasksSearchEvent {
  const factory TasksSearchEvent.queryChanged(String query) =
      _QueryChangedTasksSearchEvent;

  const factory TasksSearchEvent.querySubmitted(String query) =
      _QuerySubmittedTasksSearchEvent;

  const factory TasksSearchEvent.refreshed() = _RefreshedTasksSearchEvent;

  const factory TasksSearchEvent.loadMoreRequested() =
      _LoadMoreRequestedTasksSearchEvent;

  const factory TasksSearchEvent.recentCleared() =
      _RecentClearedTasksSearchEvent;
}

@freezed
sealed class TasksSearchStatus with _$TasksSearchStatus {
  const factory TasksSearchStatus.idle() = IdleTasksSearchStatus;

  const factory TasksSearchStatus.loading() = LoadingTasksSearchStatus;

  const factory TasksSearchStatus.suggestions({
    required List<Task> tasks,
    required String query,
  }) = SuggestionsTasksSearchStatus;

  const factory TasksSearchStatus.results({
    required PaginatedData<Task> data,
    required String query,
    @Default(BlocLoadState.loaded) BlocLoadState loadMoreState,
  }) = ResultsTasksSearchStatus;

  const factory TasksSearchStatus.failure(AppException exception) =
      FailureTasksSearchStatus;
}

@freezed
abstract class TasksSearchState with _$TasksSearchState {
  const factory TasksSearchState({
    @Default(TasksSearchStatus.idle()) TasksSearchStatus status,
    @Default('') String query,
    @Default(<String>[]) List<String> recentQueries,
  }) = _TasksSearchState;

  const TasksSearchState._();

  bool get isLoading => status is LoadingTasksSearchStatus;
}
