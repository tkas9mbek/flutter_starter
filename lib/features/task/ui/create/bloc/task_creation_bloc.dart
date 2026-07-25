import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/model/task_create_request.dart';
import 'package:starter/features/task/ui/create/model/task_create_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'task_creation_bloc.freezed.dart';
part 'task_creation_event_state.dart';

class TaskCreationBloc extends Bloc<TaskCreationEvent, TaskCreationState> {
  TaskCreationBloc(this._taskRepository)
    : super(const TaskCreationState.initial()) {
    on<_SubmittedTaskCreationEvent>(_onSubmitted);
  }

  final TaskRepository _taskRepository;

  Future<void> _onSubmitted(
    _SubmittedTaskCreationEvent event,
    Emitter<TaskCreationState> emit,
  ) async {
    emit(const TaskCreationState.loading());

    try {
      final form = event.form;
      final task = await _taskRepository.createTask(
        TaskCreateRequest(
          title: form.title,
          description: form.description,
          date: form.date,
          startTime: form.startDateTime,
          endTime: form.endDateTime,
        ),
      );

      return emit(TaskCreationState.success(task));
    } on AppException catch (e) {
      return emit(TaskCreationState.failure(e));
    }
  }
}
