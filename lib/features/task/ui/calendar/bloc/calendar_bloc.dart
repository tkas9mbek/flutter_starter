import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/utils/bloc/refreshable_bloc.dart';

part 'calendar_bloc.freezed.dart';

@freezed
sealed class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.dateSelected(DateTime date) =
      _DateSelectedCalendarEvent;

  const factory CalendarEvent.refreshed() = _RefreshedCalendarEvent;
}

@freezed
sealed class CalendarStatus with _$CalendarStatus {
  const factory CalendarStatus.initial() = InitialCalendarStatus;

  const factory CalendarStatus.loading() = LoadingCalendarStatus;

  const factory CalendarStatus.success({required List<Task> tasks}) =
      SuccessCalendarStatus;

  const factory CalendarStatus.failure({required AppException exception}) =
      FailureCalendarStatus;
}

@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState({
    required DateTime selectedDate,
    required CalendarStatus status,
  }) = _CalendarState;

  const CalendarState._();

  factory CalendarState.initial() => CalendarState(
    selectedDate: DateTime.now(),
    status: const CalendarStatus.initial(),
  );

  bool get isLoading => status is LoadingCalendarStatus;
}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState>
    with RefreshableBloc {
  CalendarBloc(this._repository) : super(CalendarState.initial()) {
    on<_DateSelectedCalendarEvent>(_onDateSelected);
    on<_RefreshedCalendarEvent>(_onRefreshed);
  }

  final TaskRepository _repository;

  Future<void> _onDateSelected(
    _DateSelectedCalendarEvent event,
    Emitter<CalendarState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedDate: event.date,
        status: const CalendarStatus.loading(),
      ),
    );

    try {
      final tasks = await _repository.getTasksByDate(event.date);

      return emit(state.copyWith(status: CalendarStatus.success(tasks: tasks)));
    } on AppException catch (e) {
      return emit(state.copyWith(status: CalendarStatus.failure(exception: e)));
    }
  }

  /// Skips the loading state while a pull-to-refresh indicator is visible.
  Future<void> _onRefreshed(
    _RefreshedCalendarEvent event,
    Emitter<CalendarState> emit,
  ) async {
    if (!refreshing) {
      emit(state.copyWith(status: const CalendarStatus.loading()));
    }

    try {
      final tasks = await _repository.getTasksByDate(state.selectedDate);

      return emit(state.copyWith(status: CalendarStatus.success(tasks: tasks)));
    } on AppException catch (e) {
      return emit(state.copyWith(status: CalendarStatus.failure(exception: e)));
    } finally {
      refreshing = false;
    }
  }

  @override
  Future<void> close() {
    dispose();

    return super.close();
  }
}
