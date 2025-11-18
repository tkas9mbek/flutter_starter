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
    required TResult Function() refreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime date)? dateSelected,
    TResult? Function()? refreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateSelected,
    TResult Function()? refreshed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DateSelectedCalendarEvent value) dateSelected,
    required TResult Function(_RefreshedCalendarEvent value) refreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult? Function(_RefreshedCalendarEvent value)? refreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult Function(_RefreshedCalendarEvent value)? refreshed,
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
    required TResult Function() refreshed,
  }) {
    return dateSelected(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime date)? dateSelected,
    TResult? Function()? refreshed,
  }) {
    return dateSelected?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateSelected,
    TResult Function()? refreshed,
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
    required TResult Function(_RefreshedCalendarEvent value) refreshed,
  }) {
    return dateSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult? Function(_RefreshedCalendarEvent value)? refreshed,
  }) {
    return dateSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult Function(_RefreshedCalendarEvent value)? refreshed,
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
abstract class _$$RefreshedCalendarEventImplCopyWith<$Res> {
  factory _$$RefreshedCalendarEventImplCopyWith(
          _$RefreshedCalendarEventImpl value,
          $Res Function(_$RefreshedCalendarEventImpl) then) =
      __$$RefreshedCalendarEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshedCalendarEventImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$RefreshedCalendarEventImpl>
    implements _$$RefreshedCalendarEventImplCopyWith<$Res> {
  __$$RefreshedCalendarEventImplCopyWithImpl(
      _$RefreshedCalendarEventImpl _value,
      $Res Function(_$RefreshedCalendarEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshedCalendarEventImpl implements _RefreshedCalendarEvent {
  const _$RefreshedCalendarEventImpl();

  @override
  String toString() {
    return 'CalendarEvent.refreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshedCalendarEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime date) dateSelected,
    required TResult Function() refreshed,
  }) {
    return refreshed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime date)? dateSelected,
    TResult? Function()? refreshed,
  }) {
    return refreshed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateSelected,
    TResult Function()? refreshed,
    required TResult orElse(),
  }) {
    if (refreshed != null) {
      return refreshed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DateSelectedCalendarEvent value) dateSelected,
    required TResult Function(_RefreshedCalendarEvent value) refreshed,
  }) {
    return refreshed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult? Function(_RefreshedCalendarEvent value)? refreshed,
  }) {
    return refreshed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DateSelectedCalendarEvent value)? dateSelected,
    TResult Function(_RefreshedCalendarEvent value)? refreshed,
    required TResult orElse(),
  }) {
    if (refreshed != null) {
      return refreshed(this);
    }
    return orElse();
  }
}

abstract class _RefreshedCalendarEvent implements CalendarEvent {
  const factory _RefreshedCalendarEvent() = _$RefreshedCalendarEventImpl;
}

/// @nodoc
mixin _$CalendarStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks) success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks)? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarStatus value) initial,
    required TResult Function(_LoadingCalendarStatus value) loading,
    required TResult Function(_SuccessCalendarStatus value) success,
    required TResult Function(_FailureCalendarStatus value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarStatus value)? initial,
    TResult? Function(_LoadingCalendarStatus value)? loading,
    TResult? Function(_SuccessCalendarStatus value)? success,
    TResult? Function(_FailureCalendarStatus value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarStatus value)? initial,
    TResult Function(_LoadingCalendarStatus value)? loading,
    TResult Function(_SuccessCalendarStatus value)? success,
    TResult Function(_FailureCalendarStatus value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarStatusCopyWith<$Res> {
  factory $CalendarStatusCopyWith(
          CalendarStatus value, $Res Function(CalendarStatus) then) =
      _$CalendarStatusCopyWithImpl<$Res, CalendarStatus>;
}

/// @nodoc
class _$CalendarStatusCopyWithImpl<$Res, $Val extends CalendarStatus>
    implements $CalendarStatusCopyWith<$Res> {
  _$CalendarStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialCalendarStatusImplCopyWith<$Res> {
  factory _$$InitialCalendarStatusImplCopyWith(
          _$InitialCalendarStatusImpl value,
          $Res Function(_$InitialCalendarStatusImpl) then) =
      __$$InitialCalendarStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCalendarStatusImplCopyWithImpl<$Res>
    extends _$CalendarStatusCopyWithImpl<$Res, _$InitialCalendarStatusImpl>
    implements _$$InitialCalendarStatusImplCopyWith<$Res> {
  __$$InitialCalendarStatusImplCopyWithImpl(_$InitialCalendarStatusImpl _value,
      $Res Function(_$InitialCalendarStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialCalendarStatusImpl implements _InitialCalendarStatus {
  const _$InitialCalendarStatusImpl();

  @override
  String toString() {
    return 'CalendarStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialCalendarStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks) success,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks)? success,
    TResult Function(AppException exception)? failure,
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
    required TResult Function(_InitialCalendarStatus value) initial,
    required TResult Function(_LoadingCalendarStatus value) loading,
    required TResult Function(_SuccessCalendarStatus value) success,
    required TResult Function(_FailureCalendarStatus value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarStatus value)? initial,
    TResult? Function(_LoadingCalendarStatus value)? loading,
    TResult? Function(_SuccessCalendarStatus value)? success,
    TResult? Function(_FailureCalendarStatus value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarStatus value)? initial,
    TResult Function(_LoadingCalendarStatus value)? loading,
    TResult Function(_SuccessCalendarStatus value)? success,
    TResult Function(_FailureCalendarStatus value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialCalendarStatus implements CalendarStatus {
  const factory _InitialCalendarStatus() = _$InitialCalendarStatusImpl;
}

/// @nodoc
abstract class _$$LoadingCalendarStatusImplCopyWith<$Res> {
  factory _$$LoadingCalendarStatusImplCopyWith(
          _$LoadingCalendarStatusImpl value,
          $Res Function(_$LoadingCalendarStatusImpl) then) =
      __$$LoadingCalendarStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingCalendarStatusImplCopyWithImpl<$Res>
    extends _$CalendarStatusCopyWithImpl<$Res, _$LoadingCalendarStatusImpl>
    implements _$$LoadingCalendarStatusImplCopyWith<$Res> {
  __$$LoadingCalendarStatusImplCopyWithImpl(_$LoadingCalendarStatusImpl _value,
      $Res Function(_$LoadingCalendarStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingCalendarStatusImpl implements _LoadingCalendarStatus {
  const _$LoadingCalendarStatusImpl();

  @override
  String toString() {
    return 'CalendarStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingCalendarStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks) success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarStatus value) initial,
    required TResult Function(_LoadingCalendarStatus value) loading,
    required TResult Function(_SuccessCalendarStatus value) success,
    required TResult Function(_FailureCalendarStatus value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarStatus value)? initial,
    TResult? Function(_LoadingCalendarStatus value)? loading,
    TResult? Function(_SuccessCalendarStatus value)? success,
    TResult? Function(_FailureCalendarStatus value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarStatus value)? initial,
    TResult Function(_LoadingCalendarStatus value)? loading,
    TResult Function(_SuccessCalendarStatus value)? success,
    TResult Function(_FailureCalendarStatus value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingCalendarStatus implements CalendarStatus {
  const factory _LoadingCalendarStatus() = _$LoadingCalendarStatusImpl;
}

/// @nodoc
abstract class _$$SuccessCalendarStatusImplCopyWith<$Res> {
  factory _$$SuccessCalendarStatusImplCopyWith(
          _$SuccessCalendarStatusImpl value,
          $Res Function(_$SuccessCalendarStatusImpl) then) =
      __$$SuccessCalendarStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Task> tasks});
}

/// @nodoc
class __$$SuccessCalendarStatusImplCopyWithImpl<$Res>
    extends _$CalendarStatusCopyWithImpl<$Res, _$SuccessCalendarStatusImpl>
    implements _$$SuccessCalendarStatusImplCopyWith<$Res> {
  __$$SuccessCalendarStatusImplCopyWithImpl(_$SuccessCalendarStatusImpl _value,
      $Res Function(_$SuccessCalendarStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_$SuccessCalendarStatusImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$SuccessCalendarStatusImpl implements _SuccessCalendarStatus {
  const _$SuccessCalendarStatusImpl({required final List<Task> tasks})
      : _tasks = tasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'CalendarStatus.success(tasks: $tasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessCalendarStatusImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tasks));

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessCalendarStatusImplCopyWith<_$SuccessCalendarStatusImpl>
      get copyWith => __$$SuccessCalendarStatusImplCopyWithImpl<
          _$SuccessCalendarStatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks) success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(tasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(tasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(tasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarStatus value) initial,
    required TResult Function(_LoadingCalendarStatus value) loading,
    required TResult Function(_SuccessCalendarStatus value) success,
    required TResult Function(_FailureCalendarStatus value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarStatus value)? initial,
    TResult? Function(_LoadingCalendarStatus value)? loading,
    TResult? Function(_SuccessCalendarStatus value)? success,
    TResult? Function(_FailureCalendarStatus value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarStatus value)? initial,
    TResult Function(_LoadingCalendarStatus value)? loading,
    TResult Function(_SuccessCalendarStatus value)? success,
    TResult Function(_FailureCalendarStatus value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessCalendarStatus implements CalendarStatus {
  const factory _SuccessCalendarStatus({required final List<Task> tasks}) =
      _$SuccessCalendarStatusImpl;

  List<Task> get tasks;

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessCalendarStatusImplCopyWith<_$SuccessCalendarStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureCalendarStatusImplCopyWith<$Res> {
  factory _$$FailureCalendarStatusImplCopyWith(
          _$FailureCalendarStatusImpl value,
          $Res Function(_$FailureCalendarStatusImpl) then) =
      __$$FailureCalendarStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureCalendarStatusImplCopyWithImpl<$Res>
    extends _$CalendarStatusCopyWithImpl<$Res, _$FailureCalendarStatusImpl>
    implements _$$FailureCalendarStatusImplCopyWith<$Res> {
  __$$FailureCalendarStatusImplCopyWithImpl(_$FailureCalendarStatusImpl _value,
      $Res Function(_$FailureCalendarStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureCalendarStatusImpl(
      exception: null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureCalendarStatusImpl implements _FailureCalendarStatus {
  const _$FailureCalendarStatusImpl({required this.exception});

  @override
  final AppException exception;

  @override
  String toString() {
    return 'CalendarStatus.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureCalendarStatusImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureCalendarStatusImplCopyWith<_$FailureCalendarStatusImpl>
      get copyWith => __$$FailureCalendarStatusImplCopyWithImpl<
          _$FailureCalendarStatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Task> tasks) success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCalendarStatus value) initial,
    required TResult Function(_LoadingCalendarStatus value) loading,
    required TResult Function(_SuccessCalendarStatus value) success,
    required TResult Function(_FailureCalendarStatus value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCalendarStatus value)? initial,
    TResult? Function(_LoadingCalendarStatus value)? loading,
    TResult? Function(_SuccessCalendarStatus value)? success,
    TResult? Function(_FailureCalendarStatus value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCalendarStatus value)? initial,
    TResult Function(_LoadingCalendarStatus value)? loading,
    TResult Function(_SuccessCalendarStatus value)? success,
    TResult Function(_FailureCalendarStatus value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureCalendarStatus implements CalendarStatus {
  const factory _FailureCalendarStatus(
      {required final AppException exception}) = _$FailureCalendarStatusImpl;

  AppException get exception;

  /// Create a copy of CalendarStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureCalendarStatusImplCopyWith<_$FailureCalendarStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CalendarState {
  DateTime get selectedDate => throw _privateConstructorUsedError;
  CalendarStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarStateCopyWith<CalendarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
          CalendarState value, $Res Function(CalendarState) then) =
      _$CalendarStateCopyWithImpl<$Res, CalendarState>;
  @useResult
  $Res call({DateTime selectedDate, CalendarStatus status});

  $CalendarStatusCopyWith<$Res> get status;
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalendarStatus,
    ) as $Val);
  }

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalendarStatusCopyWith<$Res> get status {
    return $CalendarStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CalendarStateImplCopyWith<$Res>
    implements $CalendarStateCopyWith<$Res> {
  factory _$$CalendarStateImplCopyWith(
          _$CalendarStateImpl value, $Res Function(_$CalendarStateImpl) then) =
      __$$CalendarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, CalendarStatus status});

  @override
  $CalendarStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$CalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$CalendarStateImpl>
    implements _$$CalendarStateImplCopyWith<$Res> {
  __$$CalendarStateImplCopyWithImpl(
      _$CalendarStateImpl _value, $Res Function(_$CalendarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? status = null,
  }) {
    return _then(_$CalendarStateImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalendarStatus,
    ));
  }
}

/// @nodoc

class _$CalendarStateImpl extends _CalendarState {
  const _$CalendarStateImpl({required this.selectedDate, required this.status})
      : super._();

  @override
  final DateTime selectedDate;
  @override
  final CalendarStatus status;

  @override
  String toString() {
    return 'CalendarState(selectedDate: $selectedDate, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, status);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      __$$CalendarStateImplCopyWithImpl<_$CalendarStateImpl>(this, _$identity);
}

abstract class _CalendarState extends CalendarState {
  const factory _CalendarState(
      {required final DateTime selectedDate,
      required final CalendarStatus status}) = _$CalendarStateImpl;
  const _CalendarState._() : super._();

  @override
  DateTime get selectedDate;
  @override
  CalendarStatus get status;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
