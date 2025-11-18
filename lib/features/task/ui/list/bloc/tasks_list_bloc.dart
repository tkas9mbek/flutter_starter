import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/utils/date/date_time_extension.dart';

part 'tasks_list_bloc.freezed.dart';

@freezed
class TasksListEvent with _$TasksListEvent {
  const factory TasksListEvent.requested() = _RequestedTasksListEvent;
}

@freezed
class TasksListState with _$TasksListState {
  const TasksListState._();

  const factory TasksListState.initial() = _InitialTasksListState;
  const factory TasksListState.loading() = _LoadingTasksListState;
  const factory TasksListState.success({
    required List<Task> tasks,
    required Map<DateTime, List<Task>> groupedTasks,
  }) = _SuccessTasksListState;
  const factory TasksListState.failure(AppException exception) = _FailureTasksListState;

  bool get isLoading => this is _LoadingTasksListState;
}

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  final TaskRepository _repository;

  TasksListBloc(this._repository) : super(const TasksListState.initial()) {
    on<_RequestedTasksListEvent>(_onRequested);
  }

  Future<void> _onRequested(
    _RequestedTasksListEvent event,
    Emitter<TasksListState> emit,
  ) async {
    emit(const TasksListState.loading());

    try {
      final tasks = await _repository.getTasks();
      final groupedTasks = _groupTasksByDate(tasks);

      return emit(
        TasksListState.success(
          tasks: tasks,
          groupedTasks: groupedTasks,
        ),
      );
    } on AppException catch (e) {
      return emit(TasksListState.failure(e));
    }
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
