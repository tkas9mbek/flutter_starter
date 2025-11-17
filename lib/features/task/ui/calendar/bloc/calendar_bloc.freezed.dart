// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalendarEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime date) dateSelected,
    required TResult Function(String taskId) taskToggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime date)? dateSelected,
    TResult? Function(String taskId)? taskToggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateSelected,
    TResult Function(String taskId)? taskToggled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DateSelectedCalendarEvent value) dateSelected,
    required TResult Function(_TaskToggledCalendarEvent value) taskToggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult? Function(_TaskToggledCalendarEvent value)? taskToggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult Function(_TaskToggledCalendarEvent value)? taskToggled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventCopyWith<$Res> {
  factory $CalendarEventCopyWith(
          CalendarEvent value, $Res Function(CalendarEvent) then) =
      _$CalendarEventCopyWithImpl<$Res, CalendarEvent>;
}

/// @nodoc
class _$CalendarEventCopyWithImpl<$Res, $Val extends CalendarEvent>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DateSelectedCalendarEventImplCopyWith<$Res> {
  factory _$$DateSelectedCalendarEventImplCopyWith(
          _$DateSelectedCalendarEventImpl value,
          $Res Function(_$DateSelectedCalendarEventImpl) then) =
      __$$DateSelectedCalendarEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime date});
}

/// @nodoc
class __$$DateSelectedCalendarEventImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$DateSelectedCalendarEventImpl>
    implements _$$DateSelectedCalendarEventImplCopyWith<$Res> {
  __$$DateSelectedCalendarEventImplCopyWithImpl(
      _$DateSelectedCalendarEventImpl _value,
      $Res Function(_$DateSelectedCalendarEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
  }) {
    return _then(_$DateSelectedCalendarEventImpl(
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DateSelectedCalendarEventImpl implements _DateSelectedCalendarEvent {
  const _$DateSelectedCalendarEventImpl(this.date);

  @override
  final DateTime date;

  @override
  String toString() {
    return 'CalendarEvent.dateSelected(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateSelectedCalendarEventImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateSelectedCalendarEventImplCopyWith<_$DateSelectedCalendarEventImpl>
      get copyWith => __$$DateSelectedCalendarEventImplCopyWithImpl<
          _$DateSelectedCalendarEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime date) dateSelected,
    required TResult Function(String taskId) taskToggled,
  }) {
    return dateSelected(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime date)? dateSelected,
    TResult? Function(String taskId)? taskToggled,
  }) {
    return dateSelected?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateSelected,
    TResult Function(String taskId)? taskToggled,
    required TResult orElse(),
  }) {
    if (dateSelected != null) {
      return dateSelected(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DateSelectedCalendarEvent value) dateSelected,
    required TResult Function(_TaskToggledCalendarEvent value) taskToggled,
  }) {
    return dateSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult? Function(_TaskToggledCalendarEvent value)? taskToggled,
  }) {
    return dateSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult Function(_TaskToggledCalendarEvent value)? taskToggled,
    required TResult orElse(),
  }) {
    if (dateSelected != null) {
      return dateSelected(this);
    }
    return orElse();
  }
}

abstract class _DateSelectedCalendarEvent implements CalendarEvent {
  const factory _DateSelectedCalendarEvent(final DateTime date) =
      _$DateSelectedCalendarEventImpl;

  DateTime get date;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateSelectedCalendarEventImplCopyWith<_$DateSelectedCalendarEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskToggledCalendarEventImplCopyWith<$Res> {
  factory _$$TaskToggledCalendarEventImplCopyWith(
          _$TaskToggledCalendarEventImpl value,
          $Res Function(_$TaskToggledCalendarEventImpl) then) =
      __$$TaskToggledCalendarEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$TaskToggledCalendarEventImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$TaskToggledCalendarEventImpl>
    implements _$$TaskToggledCalendarEventImplCopyWith<$Res> {
  __$$TaskToggledCalendarEventImplCopyWithImpl(
      _$TaskToggledCalendarEventImpl _value,
      $Res Function(_$TaskToggledCalendarEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$TaskToggledCalendarEventImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskToggledCalendarEventImpl implements _TaskToggledCalendarEvent {
  const _$TaskToggledCalendarEventImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'CalendarEvent.taskToggled(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskToggledCalendarEventImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskToggledCalendarEventImplCopyWith<_$TaskToggledCalendarEventImpl>
      get copyWith => __$$TaskToggledCalendarEventImplCopyWithImpl<
          _$TaskToggledCalendarEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime date) dateSelected,
    required TResult Function(String taskId) taskToggled,
  }) {
    return taskToggled(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime date)? dateSelected,
    TResult? Function(String taskId)? taskToggled,
  }) {
    return taskToggled?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateSelected,
    TResult Function(String taskId)? taskToggled,
    required TResult orElse(),
  }) {
    if (taskToggled != null) {
      return taskToggled(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DateSelectedCalendarEvent value) dateSelected,
    required TResult Function(_TaskToggledCalendarEvent value) taskToggled,
  }) {
    return taskToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult? Function(_TaskToggledCalendarEvent value)? taskToggled,
  }) {
    return taskToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult Function(_TaskToggledCalendarEvent value)? taskToggled,
    required TResult orElse(),
  }) {
    if (taskToggled != null) {
      return taskToggled(this);
    }
    return orElse();
  }
}

abstract class _TaskToggledCalendarEvent implements CalendarEvent {
  const factory _TaskToggledCalendarEvent(final String taskId) =
      _$TaskToggledCalendarEventImpl;

  String get taskId;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskToggledCalendarEventImplCopyWith<_$TaskToggledCalendarEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CalendarState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DateTime selectedDate) loading,
    required TResult Function(DateTime selectedDate, List<Task> tasks) success,
    required TResult Function(DateTime selectedDate, AppException exception)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(DateTime selectedDate)? loading,
    TResult? Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult? Function(DateTime selectedDate, AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DateTime selectedDate)? loading,
    TResult Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult Function(DateTime selectedDate, AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarState value) initial,
    required TResult Function(_LoadingCalendarState value) loading,
    required TResult Function(_SuccessCalendarState value) success,
    required TResult Function(_FailureCalendarState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarState value)? initial,
    TResult? Function(_LoadingCalendarState value)? loading,
    TResult? Function(_SuccessCalendarState value)? success,
    TResult? Function(_FailureCalendarState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarState value)? initial,
    TResult Function(_LoadingCalendarState value)? loading,
    TResult Function(_SuccessCalendarState value)? success,
    TResult Function(_FailureCalendarState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
          CalendarState value, $Res Function(CalendarState) then) =
      _$CalendarStateCopyWithImpl<$Res, CalendarState>;
}

/// @nodoc
class _$CalendarStateCopyWithImpl<$Res, $Val extends CalendarState>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialCalendarStateImplCopyWith<$Res> {
  factory _$$InitialCalendarStateImplCopyWith(_$InitialCalendarStateImpl value,
          $Res Function(_$InitialCalendarStateImpl) then) =
      __$$InitialCalendarStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$InitialCalendarStateImpl>
    implements _$$InitialCalendarStateImplCopyWith<$Res> {
  __$$InitialCalendarStateImplCopyWithImpl(_$InitialCalendarStateImpl _value,
      $Res Function(_$InitialCalendarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialCalendarStateImpl extends _InitialCalendarState {
  const _$InitialCalendarStateImpl() : super._();

  @override
  String toString() {
    return 'CalendarState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialCalendarStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DateTime selectedDate) loading,
    required TResult Function(DateTime selectedDate, List<Task> tasks) success,
    required TResult Function(DateTime selectedDate, AppException exception)
        failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(DateTime selectedDate)? loading,
    TResult? Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult? Function(DateTime selectedDate, AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DateTime selectedDate)? loading,
    TResult Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult Function(DateTime selectedDate, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarState value) initial,
    required TResult Function(_LoadingCalendarState value) loading,
    required TResult Function(_SuccessCalendarState value) success,
    required TResult Function(_FailureCalendarState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarState value)? initial,
    TResult? Function(_LoadingCalendarState value)? loading,
    TResult? Function(_SuccessCalendarState value)? success,
    TResult? Function(_FailureCalendarState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarState value)? initial,
    TResult Function(_LoadingCalendarState value)? loading,
    TResult Function(_SuccessCalendarState value)? success,
    TResult Function(_FailureCalendarState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialCalendarState extends CalendarState {
  const factory _InitialCalendarState() = _$InitialCalendarStateImpl;
  const _InitialCalendarState._() : super._();
}

/// @nodoc
abstract class _$$LoadingCalendarStateImplCopyWith<$Res> {
  factory _$$LoadingCalendarStateImplCopyWith(_$LoadingCalendarStateImpl value,
          $Res Function(_$LoadingCalendarStateImpl) then) =
      __$$LoadingCalendarStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime selectedDate});
}

/// @nodoc
class __$$LoadingCalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$LoadingCalendarStateImpl>
    implements _$$LoadingCalendarStateImplCopyWith<$Res> {
  __$$LoadingCalendarStateImplCopyWithImpl(_$LoadingCalendarStateImpl _value,
      $Res Function(_$LoadingCalendarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
  }) {
    return _then(_$LoadingCalendarStateImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$LoadingCalendarStateImpl extends _LoadingCalendarState {
  const _$LoadingCalendarStateImpl({required this.selectedDate}) : super._();

  @override
  final DateTime selectedDate;

  @override
  String toString() {
    return 'CalendarState.loading(selectedDate: $selectedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingCalendarStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingCalendarStateImplCopyWith<_$LoadingCalendarStateImpl>
      get copyWith =>
          __$$LoadingCalendarStateImplCopyWithImpl<_$LoadingCalendarStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DateTime selectedDate) loading,
    required TResult Function(DateTime selectedDate, List<Task> tasks) success,
    required TResult Function(DateTime selectedDate, AppException exception)
        failure,
  }) {
    return loading(selectedDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(DateTime selectedDate)? loading,
    TResult? Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult? Function(DateTime selectedDate, AppException exception)? failure,
  }) {
    return loading?.call(selectedDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DateTime selectedDate)? loading,
    TResult Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult Function(DateTime selectedDate, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(selectedDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarState value) initial,
    required TResult Function(_LoadingCalendarState value) loading,
    required TResult Function(_SuccessCalendarState value) success,
    required TResult Function(_FailureCalendarState value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarState value)? initial,
    TResult? Function(_LoadingCalendarState value)? loading,
    TResult? Function(_SuccessCalendarState value)? success,
    TResult? Function(_FailureCalendarState value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarState value)? initial,
    TResult Function(_LoadingCalendarState value)? loading,
    TResult Function(_SuccessCalendarState value)? success,
    TResult Function(_FailureCalendarState value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingCalendarState extends CalendarState {
  const factory _LoadingCalendarState({required final DateTime selectedDate}) =
      _$LoadingCalendarStateImpl;
  const _LoadingCalendarState._() : super._();

  DateTime get selectedDate;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingCalendarStateImplCopyWith<_$LoadingCalendarStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessCalendarStateImplCopyWith<$Res> {
  factory _$$SuccessCalendarStateImplCopyWith(_$SuccessCalendarStateImpl value,
          $Res Function(_$SuccessCalendarStateImpl) then) =
      __$$SuccessCalendarStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime selectedDate, List<Task> tasks});
}

/// @nodoc
class __$$SuccessCalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$SuccessCalendarStateImpl>
    implements _$$SuccessCalendarStateImplCopyWith<$Res> {
  __$$SuccessCalendarStateImplCopyWithImpl(_$SuccessCalendarStateImpl _value,
      $Res Function(_$SuccessCalendarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? tasks = null,
  }) {
    return _then(_$SuccessCalendarStateImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$SuccessCalendarStateImpl extends _SuccessCalendarState {
  const _$SuccessCalendarStateImpl(
      {required this.selectedDate, required final List<Task> tasks})
      : _tasks = tasks,
        super._();

  @override
  final DateTime selectedDate;
  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'CalendarState.success(selectedDate: $selectedDate, tasks: $tasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessCalendarStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedDate, const DeepCollectionEquality().hash(_tasks));

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessCalendarStateImplCopyWith<_$SuccessCalendarStateImpl>
      get copyWith =>
          __$$SuccessCalendarStateImplCopyWithImpl<_$SuccessCalendarStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DateTime selectedDate) loading,
    required TResult Function(DateTime selectedDate, List<Task> tasks) success,
    required TResult Function(DateTime selectedDate, AppException exception)
        failure,
  }) {
    return success(selectedDate, tasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(DateTime selectedDate)? loading,
    TResult? Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult? Function(DateTime selectedDate, AppException exception)? failure,
  }) {
    return success?.call(selectedDate, tasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DateTime selectedDate)? loading,
    TResult Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult Function(DateTime selectedDate, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(selectedDate, tasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarState value) initial,
    required TResult Function(_LoadingCalendarState value) loading,
    required TResult Function(_SuccessCalendarState value) success,
    required TResult Function(_FailureCalendarState value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarState value)? initial,
    TResult? Function(_LoadingCalendarState value)? loading,
    TResult? Function(_SuccessCalendarState value)? success,
    TResult? Function(_FailureCalendarState value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarState value)? initial,
    TResult Function(_LoadingCalendarState value)? loading,
    TResult Function(_SuccessCalendarState value)? success,
    TResult Function(_FailureCalendarState value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessCalendarState extends CalendarState {
  const factory _SuccessCalendarState(
      {required final DateTime selectedDate,
      required final List<Task> tasks}) = _$SuccessCalendarStateImpl;
  const _SuccessCalendarState._() : super._();

  DateTime get selectedDate;
  List<Task> get tasks;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessCalendarStateImplCopyWith<_$SuccessCalendarStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureCalendarStateImplCopyWith<$Res> {
  factory _$$FailureCalendarStateImplCopyWith(_$FailureCalendarStateImpl value,
          $Res Function(_$FailureCalendarStateImpl) then) =
      __$$FailureCalendarStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime selectedDate, AppException exception});
}

/// @nodoc
class __$$FailureCalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$FailureCalendarStateImpl>
    implements _$$FailureCalendarStateImplCopyWith<$Res> {
  __$$FailureCalendarStateImplCopyWithImpl(_$FailureCalendarStateImpl _value,
      $Res Function(_$FailureCalendarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? exception = null,
  }) {
    return _then(_$FailureCalendarStateImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      exception: null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureCalendarStateImpl extends _FailureCalendarState {
  const _$FailureCalendarStateImpl(
      {required this.selectedDate, required this.exception})
      : super._();

  @override
  final DateTime selectedDate;
  @override
  final AppException exception;

  @override
  String toString() {
    return 'CalendarState.failure(selectedDate: $selectedDate, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureCalendarStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, exception);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureCalendarStateImplCopyWith<_$FailureCalendarStateImpl>
      get copyWith =>
          __$$FailureCalendarStateImplCopyWithImpl<_$FailureCalendarStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(DateTime selectedDate) loading,
    required TResult Function(DateTime selectedDate, List<Task> tasks) success,
    required TResult Function(DateTime selectedDate, AppException exception)
        failure,
  }) {
    return failure(selectedDate, exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(DateTime selectedDate)? loading,
    TResult? Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult? Function(DateTime selectedDate, AppException exception)? failure,
  }) {
    return failure?.call(selectedDate, exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(DateTime selectedDate)? loading,
    TResult Function(DateTime selectedDate, List<Task> tasks)? success,
    TResult Function(DateTime selectedDate, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(selectedDate, exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarState value) initial,
    required TResult Function(_LoadingCalendarState value) loading,
    required TResult Function(_SuccessCalendarState value) success,
    required TResult Function(_FailureCalendarState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarState value)? initial,
    TResult? Function(_LoadingCalendarState value)? loading,
    TResult? Function(_SuccessCalendarState value)? success,
    TResult? Function(_FailureCalendarState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarState value)? initial,
    TResult Function(_LoadingCalendarState value)? loading,
    TResult Function(_SuccessCalendarState value)? success,
    TResult Function(_FailureCalendarState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureCalendarState extends CalendarState {
  const factory _FailureCalendarState(
      {required final DateTime selectedDate,
      required final AppException exception}) = _$FailureCalendarStateImpl;
  const _FailureCalendarState._() : super._();

  DateTime get selectedDate;
  AppException get exception;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureCalendarStateImplCopyWith<_$FailureCalendarStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
