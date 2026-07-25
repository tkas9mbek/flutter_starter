// ignore_for_file: class_size_warning — one search flow: query, suggestion, and result handlers

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';

part 'tasks_search_bloc.freezed.dart';
part 'tasks_search_event_state.dart';

/// Debounced type-ahead search over tasks with paginated results.
///
/// `restartable()` cancels the in-flight query when a newer event arrives,
/// so only the latest query's result is emitted; `emit.isDone` guards the
/// window between an await completing and the handler being cancelled.
class TasksSearchBloc extends Bloc<TasksSearchEvent, TasksSearchState> {
  TasksSearchBloc(this._taskRepository) : super(const TasksSearchState()) {
    on<_QueryChangedTasksSearchEvent>(
      _onQueryChanged,
      transformer: restartable(),
    );
    on<_QuerySubmittedTasksSearchEvent>(
      _onQuerySubmitted,
      transformer: restartable(),
    );
    on<_RefreshedTasksSearchEvent>(_onRefreshed, transformer: restartable());
    on<_LoadMoreRequestedTasksSearchEvent>(
      _onLoadMoreRequested,
      transformer: droppable(),
    );
    on<_RecentClearedTasksSearchEvent>(
      (event, emit) => emit(state.copyWith(recentQueries: const [])),
    );
  }

  static const _maxRecentQueries = 5;

  final TaskRepository _taskRepository;

  Future<void> _onQueryChanged(
    _QueryChangedTasksSearchEvent event,
    Emitter<TasksSearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      return emit(state.copyWith(status: const TasksSearchStatus.idle()));
    }

    try {
      final firstPage = await _taskRepository.searchTasks(query, page: 1);
      if (emit.isDone) {
        return;
      }

      return emit(
        state.copyWith(
          status: TasksSearchStatus.suggestions(
            tasks: firstPage.elements,
            query: query,
          ),
        ),
      );
    } on AppException catch (e) {
      return emit(state.copyWith(status: TasksSearchStatus.failure(e)));
    }
  }

  Future<void> _onQuerySubmitted(
    _QuerySubmittedTasksSearchEvent event,
    Emitter<TasksSearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      return;
    }

    return _runQuery(query, emit);
  }

  Future<void> _onRefreshed(
    _RefreshedTasksSearchEvent event,
    Emitter<TasksSearchState> emit,
  ) async {
    final query = state.query;
    if (query.isEmpty) {
      return;
    }

    return _runQuery(query, emit);
  }

  Future<void> _onLoadMoreRequested(
    _LoadMoreRequestedTasksSearchEvent event,
    Emitter<TasksSearchState> emit,
  ) async {
    final status = state.status;
    if (status is! ResultsTasksSearchStatus || !status.data.canLoadMore) {
      return;
    }

    emit(
      state.copyWith(
        status: status.copyWith(loadMoreState: BlocLoadState.loading),
      ),
    );

    try {
      final nextPage = await _taskRepository.searchTasks(
        status.query,
        page: status.data.nextPage,
      );
      if (emit.isDone) {
        return;
      }

      return emit(
        state.copyWith(
          status: status.copyWith(
            data: status.data.merge(PaginatedData.fromApi(nextPage)),
            loadMoreState: BlocLoadState.loaded,
          ),
        ),
      );
    } on AppException catch (_) {
      return emit(
        state.copyWith(
          status: status.copyWith(loadMoreState: BlocLoadState.failure),
        ),
      );
    }
  }

  Future<void> _runQuery(
    String query,
    Emitter<TasksSearchState> emit,
  ) async {
    emit(
      state.copyWith(
        query: query,
        status: const TasksSearchStatus.loading(),
        recentQueries: _withRecent(query),
      ),
    );

    try {
      final firstPage = await _taskRepository.searchTasks(query, page: 1);
      if (emit.isDone) {
        return;
      }

      return emit(
        state.copyWith(
          status: TasksSearchStatus.results(
            data: PaginatedData.fromApi(firstPage),
            query: query,
          ),
        ),
      );
    } on AppException catch (e) {
      return emit(state.copyWith(status: TasksSearchStatus.failure(e)));
    }
  }

  List<String> _withRecent(String query) => [
    query,
    ...state.recentQueries.where(
      (recent) => recent.toLowerCase() != query.toLowerCase(),
    ),
  ].take(_maxRecentQueries).toList();
}
