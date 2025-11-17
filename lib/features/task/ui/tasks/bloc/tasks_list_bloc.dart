import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'tasks_list_bloc.freezed.dart';

@freezed
class TasksListEvent with _$TasksListEvent {
  const factory TasksListEvent.loaded() = _LoadedTasksListEvent;

  const factory TasksListEvent.taskToggled(String taskId) =
      _TaskToggledTasksListEvent;

  const factory TasksListEvent.taskDeleted(String taskId) =
      _TaskDeletedTasksListEvent;
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

  const factory TasksListState.failure(AppException exception) =
      _FailureTasksListState;

  bool get isLoading => this is _LoadingTasksListState;
}

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  final TaskRepository _repository;

  TasksListBloc(this._repository) : super(const TasksListState.initial()) {
    on<TasksListEvent>(
      (event, emit) => event.when(
        loaded: () => _onLoaded(emit),
        taskToggled: (taskId) => _onTaskToggled(taskId, emit),
        taskDeleted: (taskId) => _onTaskDeleted(taskId, emit),
      ),
    );
  }

  Future<void> _onLoaded(Emitter<TasksListState> emit) async {
    emit(const TasksListState.loading());

    try {
      final tasks = await _repository.getTasks();
      final groupedTasks = _groupTasksByDate(tasks);

      emit(
        TasksListState.success(
          tasks: tasks,
          groupedTasks: groupedTasks,
        ),
      );
    } on AppException catch (e) {
      emit(TasksListState.failure(e));
    }
  }

  Future<void> _onTaskToggled(
    String taskId,
    Emitter<TasksListState> emit,
  ) async {
    final currentState = state;

    if (currentState is! _SuccessTasksListState) {
      return;
    }

    try {
      final updatedTask = await _repository.toggleTaskCompletion(taskId);

      final updatedTasks = currentState.tasks.map((task) {
        return task.id == taskId ? updatedTask : task;
      }).toList();

      final groupedTasks = _groupTasksByDate(updatedTasks);

      emit(
        TasksListState.success(
          tasks: updatedTasks,
          groupedTasks: groupedTasks,
        ),
      );
    } on AppException catch (e) {
      emit(TasksListState.failure(e));
    }
  }

  Future<void> _onTaskDeleted(
    String taskId,
    Emitter<TasksListState> emit,
  ) async {
    final currentState = state;

    if (currentState is! _SuccessTasksListState) {
      return;
    }

    try {
      await _repository.deleteTask(taskId);

      final updatedTasks = currentState.tasks
          .where((task) => task.id != taskId)
          .toList();

      final groupedTasks = _groupTasksByDate(updatedTasks);

      emit(
        TasksListState.success(
          tasks: updatedTasks,
          groupedTasks: groupedTasks,
        ),
      );
    } on AppException catch (e) {
      emit(TasksListState.failure(e));
    }
  }

  Map<DateTime, List<Task>> _groupTasksByDate(List<Task> tasks) {
    final Map<DateTime, List<Task>> grouped = {};

    for (final task in tasks) {
      final dateKey = DateTime(
        task.date.year,
        task.date.month,
        task.date.day,
      );

      if (grouped.containsKey(dateKey)) {
        grouped[dateKey]!.add(task);
      } else {
        grouped[dateKey] = [task];
      }
    }

    // Sort tasks within each group by start time
    for (final entry in grouped.entries) {
      entry.value.sort((a, b) => a.startTime.compareTo(b.startTime));
    }

    return grouped;
  }
}
