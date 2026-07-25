part of 'task_creation_bloc.dart';

@freezed
sealed class TaskCreationEvent with _$TaskCreationEvent {
  const factory TaskCreationEvent.submitted(TaskCreateForm form) =
      _SubmittedTaskCreationEvent;
}

@freezed
sealed class TaskCreationState with _$TaskCreationState {
  const TaskCreationState._();

  const factory TaskCreationState.initial() = InitialTaskCreationState;

  const factory TaskCreationState.loading() = LoadingTaskCreationState;

  const factory TaskCreationState.success(Task task) = SuccessTaskCreationState;

  const factory TaskCreationState.failure(AppException exception) =
      FailureTaskCreationState;

  bool get isLoading => this is LoadingTaskCreationState;
}
