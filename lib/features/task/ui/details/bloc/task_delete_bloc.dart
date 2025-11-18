import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'task_delete_bloc.freezed.dart';

@freezed
class TaskDeleteEvent with _$TaskDeleteEvent {
  const factory TaskDeleteEvent.deleted(String taskId) =
      _DeletedTaskDeleteEvent;
}

@freezed
class TaskDeleteState with _$TaskDeleteState {
  const factory TaskDeleteState.initial() = _InitialTaskDeleteState;

  const factory TaskDeleteState.loading() = _LoadingTaskDeleteState;

  const factory TaskDeleteState.success() = _SuccessTaskDeleteState;

  const factory TaskDeleteState.failure(AppException exception) =
      _FailureTaskDeleteState;

  const TaskDeleteState._();

  bool get isLoading => this is _LoadingTaskDeleteState;
}

class TaskDeleteBloc extends Bloc<TaskDeleteEvent, TaskDeleteState> {
  final TaskRepository _taskRepository;

  TaskDeleteBloc(this._taskRepository)
      : super(const TaskDeleteState.initial()) {
    on<_DeletedTaskDeleteEvent>(_onDeleted);
  }

  Future<void> _onDeleted(
    _DeletedTaskDeleteEvent event,
    Emitter<TaskDeleteState> emit,
  ) async {
    emit(const TaskDeleteState.loading());

    try {
      await _taskRepository.deleteTask(event.taskId);
      emit(const TaskDeleteState.success());

      return;
    } on AppException catch (e) {
      emit(TaskDeleteState.failure(e));

      return;
    }
  }
}
