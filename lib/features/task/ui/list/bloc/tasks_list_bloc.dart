import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/utils/bloc/refreshable_bloc.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

part 'tasks_list_bloc.freezed.dart';

@freezed
sealed class TasksListEvent with _$TasksListEvent {
  const factory TasksListEvent.requested() = _RequestedTasksListEvent;

  const factory TasksListEvent.refreshed() = _RefreshedTasksListEvent;
}

@freezed
sealed class TasksListState with _$TasksListState {
  const TasksListState._();

  const factory TasksListState.initial() = InitialTasksListState;
  const factory TasksListState.loading() = LoadingTasksListState;
  const factory TasksListState.success({
    required List<Task> tasks,
    required Map<DateTime, List<Task>> groupedTasks,
  }) = SuccessTasksListState;
  const factory TasksListState.failure(AppException exception) =
      FailureTasksListState;

  bool get isLoading => this is LoadingTasksListState;
}

class TasksListBloc extends Bloc<TasksListEvent, TasksListState>
    with RefreshableBloc {
  TasksListBloc(this._repository) : super(const TasksListState.initial()) {
    on<_RequestedTasksListEvent>(_onRequested);
    on<_RefreshedTasksListEvent>(_onRefreshed);
  }

  final TaskRepository _repository;

  Future<void> _onRequested(
    _RequestedTasksListEvent event,
    Emitter<TasksListState> emit,
  ) async {
    emit(const TasksListState.loading());

    return _load(emit);
  }

  /// Reload without the loading state — the pull-to-refresh indicator is
  /// already visible.
  Future<void> _onRefreshed(
    _RefreshedTasksListEvent event,
    Emitter<TasksListState> emit,
  ) async {
    try {
      return await _load(emit);
    } finally {
      refreshing = false;
    }
  }

  Future<void> _load(Emitter<TasksListState> emit) async {
    try {
      final tasks = await _repository.getTasks();
      final groupedTasks = _groupTasksByDate(tasks);

      return emit(
        TasksListState.success(tasks: tasks, groupedTasks: groupedTasks),
      );
    } on AppException catch (e) {
      return emit(TasksListState.failure(e));
    }
  }

  @override
  Future<void> close() {
    dispose();

    return super.close();
  }

  Map<DateTime, List<Task>> _groupTasksByDate(List<Task> tasks) {
    final grouped = <DateTime, List<Task>>{};

    for (final task in tasks) {
      final dateKey = task.date.onlyDay;

      if (grouped.containsKey(dateKey)) {
        grouped[dateKey]!.add(task);
      } else {
        grouped[dateKey] = [task];
      }
    }

    for (final entry in grouped.entries) {
      entry.value.sort((a, b) => a.startTime.compareTo(b.startTime));
    }

    return grouped;
  }
}
