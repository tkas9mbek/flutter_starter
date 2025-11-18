import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'task_toggle_bloc.freezed.dart';

@freezed
class TaskToggleEvent with _$TaskToggleEvent {
  const factory TaskToggleEvent.toggled(String taskId) =
      _ToggledTaskToggleEvent;
}

@freezed
class TaskToggleState with _$TaskToggleState {
  const factory TaskToggleState.initial() = _InitialTaskToggleState;

  const factory TaskToggleState.loading() = _LoadingTaskToggleState;

  const factory TaskToggleState.success(Task task) = _SuccessTaskToggleState;

  const factory TaskToggleState.failure(AppException exception) =
      _FailureTaskToggleState;

  const TaskToggleState._();

  bool get isLoading => this is _LoadingTaskToggleState;
}

class TaskToggleBloc extends Bloc<TaskToggleEvent, TaskToggleState> {
  final TaskRepository _taskRepository;

  TaskToggleBloc(this._taskRepository)
      : super(const TaskToggleState.initial()) {
    on<_ToggledTaskToggleEvent>(_onToggled);
  }

  Future<void> _onToggled(
    _ToggledTaskToggleEvent event,
    Emitter<TaskToggleState> emit,
  ) async {
    emit(const TaskToggleState.loading());

    try {
      final task = await _taskRepository.toggleTaskCompletion(event.taskId);
      emit(TaskToggleState.success(task));

      return;
    } on AppException catch (e) {
      emit(TaskToggleState.failure(e));

      return;
    }
  }
}
