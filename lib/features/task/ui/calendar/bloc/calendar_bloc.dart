import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'calendar_bloc.freezed.dart';

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.dateSelected(DateTime date) = _DateSelectedCalendarEvent;

  const factory CalendarEvent.taskToggled(String taskId) = _TaskToggledCalendarEvent;
}

@freezed
class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState.initial() = _InitialCalendarState;

  const factory CalendarState.loading({
    required DateTime selectedDate,
  }) = _LoadingCalendarState;

  const factory CalendarState.success({
    required DateTime selectedDate,
    required List<Task> tasks,
  }) = _SuccessCalendarState;

  const factory CalendarState.failure({
    required DateTime selectedDate,
    required AppException exception,
  }) = _FailureCalendarState;

  bool get isLoading => this is _LoadingCalendarState;

  DateTime get selectedDate => when(
        initial: () => DateTime.now(),
        loading: (date) => date,
        success: (date, _) => date,
        failure: (date, _) => date,
      );
}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final TaskRepository _repository;

  CalendarBloc(this._repository) : super(const CalendarState.initial()) {
    on<CalendarEvent>(
      (event, emit) => event.when(
        dateSelected: (date) => _onDateSelected(date, emit),
        taskToggled: (taskId) => _onTaskToggled(taskId, emit),
      ),
    );
  }

  Future<void> _onDateSelected(
    DateTime date,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarState.loading(selectedDate: date));

    try {
      final tasks = await _repository.getTasksByDate(date);

      emit(
        CalendarState.success(
          selectedDate: date,
          tasks: tasks,
        ),
      );
    } on AppException catch (e) {
      emit(
        CalendarState.failure(
          selectedDate: date,
          exception: e,
        ),
      );
    }
  }

  Future<void> _onTaskToggled(
    String taskId,
    Emitter<CalendarState> emit,
  ) async {
    final currentState = state;

    if (currentState is! _SuccessCalendarState) {
      return;
    }

    try {
      final updatedTask = await _repository.toggleTaskCompletion(taskId);

      final updatedTasks = currentState.tasks.map((task) {
        return task.id == taskId ? updatedTask : task;
      }).toList();

      emit(
        CalendarState.success(
          selectedDate: currentState.selectedDate,
          tasks: updatedTasks,
        ),
      );
    } on AppException catch (e) {
      emit(
        CalendarState.failure(
          selectedDate: currentState.selectedDate,
          exception: e,
        ),
      );
    }
  }
}
