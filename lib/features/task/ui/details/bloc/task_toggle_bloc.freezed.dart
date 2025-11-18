// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_toggle_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskToggleEvent {
  String get taskId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String taskId) toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String taskId)? toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String taskId)? toggled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggledTaskToggleEvent value) toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggledTaskToggleEvent value)? toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggledTaskToggleEvent value)? toggled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TaskToggleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskToggleEventCopyWith<TaskToggleEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskToggleEventCopyWith<$Res> {
  factory $TaskToggleEventCopyWith(
          TaskToggleEvent value, $Res Function(TaskToggleEvent) then) =
      _$TaskToggleEventCopyWithImpl<$Res, TaskToggleEvent>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class _$TaskToggleEventCopyWithImpl<$Res, $Val extends TaskToggleEvent>
    implements $TaskToggleEventCopyWith<$Res> {
  _$TaskToggleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskToggleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ToggledTaskToggleEventImplCopyWith<$Res>
    implements $TaskToggleEventCopyWith<$Res> {
  factory _$$ToggledTaskToggleEventImplCopyWith(
          _$ToggledTaskToggleEventImpl value,
          $Res Function(_$ToggledTaskToggleEventImpl) then) =
      __$$ToggledTaskToggleEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$ToggledTaskToggleEventImplCopyWithImpl<$Res>
    extends _$TaskToggleEventCopyWithImpl<$Res, _$ToggledTaskToggleEventImpl>
    implements _$$ToggledTaskToggleEventImplCopyWith<$Res> {
  __$$ToggledTaskToggleEventImplCopyWithImpl(
      _$ToggledTaskToggleEventImpl _value,
      $Res Function(_$ToggledTaskToggleEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskToggleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$ToggledTaskToggleEventImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToggledTaskToggleEventImpl implements _ToggledTaskToggleEvent {
  const _$ToggledTaskToggleEventImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'TaskToggleEvent.toggled(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggledTaskToggleEventImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of TaskToggleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggledTaskToggleEventImplCopyWith<_$ToggledTaskToggleEventImpl>
      get copyWith => __$$ToggledTaskToggleEventImplCopyWithImpl<
          _$ToggledTaskToggleEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String taskId) toggled,
  }) {
    return toggled(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String taskId)? toggled,
  }) {
    return toggled?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String taskId)? toggled,
    required TResult orElse(),
  }) {
    if (toggled != null) {
      return toggled(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggledTaskToggleEvent value) toggled,
  }) {
    return toggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggledTaskToggleEvent value)? toggled,
  }) {
    return toggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggledTaskToggleEvent value)? toggled,
    required TResult orElse(),
  }) {
    if (toggled != null) {
      return toggled(this);
    }
    return orElse();
  }
}

abstract class _ToggledTaskToggleEvent implements TaskToggleEvent {
  const factory _ToggledTaskToggleEvent(final String taskId) =
      _$ToggledTaskToggleEventImpl;

  @override
  String get taskId;

  /// Create a copy of TaskToggleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggledTaskToggleEventImplCopyWith<_$ToggledTaskToggleEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TaskToggleState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Task task) success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Task task)? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Task task)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialTaskToggleState value) initial,
    required TResult Function(_LoadingTaskToggleState value) loading,
    required TResult Function(_SuccessTaskToggleState value) success,
    required TResult Function(_FailureTaskToggleState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskToggleState value)? initial,
    TResult? Function(_LoadingTaskToggleState value)? loading,
    TResult? Function(_SuccessTaskToggleState value)? success,
    TResult? Function(_FailureTaskToggleState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskToggleState value)? initial,
    TResult Function(_LoadingTaskToggleState value)? loading,
    TResult Function(_SuccessTaskToggleState value)? success,
    TResult Function(_FailureTaskToggleState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskToggleStateCopyWith<$Res> {
  factory $TaskToggleStateCopyWith(
          TaskToggleState value, $Res Function(TaskToggleState) then) =
      _$TaskToggleStateCopyWithImpl<$Res, TaskToggleState>;
}

/// @nodoc
class _$TaskToggleStateCopyWithImpl<$Res, $Val extends TaskToggleState>
    implements $TaskToggleStateCopyWith<$Res> {
  _$TaskToggleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialTaskToggleStateImplCopyWith<$Res> {
  factory _$$InitialTaskToggleStateImplCopyWith(
          _$InitialTaskToggleStateImpl value,
          $Res Function(_$InitialTaskToggleStateImpl) then) =
      __$$InitialTaskToggleStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialTaskToggleStateImplCopyWithImpl<$Res>
    extends _$TaskToggleStateCopyWithImpl<$Res, _$InitialTaskToggleStateImpl>
    implements _$$InitialTaskToggleStateImplCopyWith<$Res> {
  __$$InitialTaskToggleStateImplCopyWithImpl(
      _$InitialTaskToggleStateImpl _value,
      $Res Function(_$InitialTaskToggleStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialTaskToggleStateImpl extends _InitialTaskToggleState {
  const _$InitialTaskToggleStateImpl() : super._();

  @override
  String toString() {
    return 'TaskToggleState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialTaskToggleStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Task task) success,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Task task)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Task task)? success,
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
    required TResult Function(_InitialTaskToggleState value) initial,
    required TResult Function(_LoadingTaskToggleState value) loading,
    required TResult Function(_SuccessTaskToggleState value) success,
    required TResult Function(_FailureTaskToggleState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskToggleState value)? initial,
    TResult? Function(_LoadingTaskToggleState value)? loading,
    TResult? Function(_SuccessTaskToggleState value)? success,
    TResult? Function(_FailureTaskToggleState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskToggleState value)? initial,
    TResult Function(_LoadingTaskToggleState value)? loading,
    TResult Function(_SuccessTaskToggleState value)? success,
    TResult Function(_FailureTaskToggleState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialTaskToggleState extends TaskToggleState {
  const factory _InitialTaskToggleState() = _$InitialTaskToggleStateImpl;
  const _InitialTaskToggleState._() : super._();
}

/// @nodoc
abstract class _$$LoadingTaskToggleStateImplCopyWith<$Res> {
  factory _$$LoadingTaskToggleStateImplCopyWith(
          _$LoadingTaskToggleStateImpl value,
          $Res Function(_$LoadingTaskToggleStateImpl) then) =
      __$$LoadingTaskToggleStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingTaskToggleStateImplCopyWithImpl<$Res>
    extends _$TaskToggleStateCopyWithImpl<$Res, _$LoadingTaskToggleStateImpl>
    implements _$$LoadingTaskToggleStateImplCopyWith<$Res> {
  __$$LoadingTaskToggleStateImplCopyWithImpl(
      _$LoadingTaskToggleStateImpl _value,
      $Res Function(_$LoadingTaskToggleStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingTaskToggleStateImpl extends _LoadingTaskToggleState {
  const _$LoadingTaskToggleStateImpl() : super._();

  @override
  String toString() {
    return 'TaskToggleState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingTaskToggleStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Task task) success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Task task)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Task task)? success,
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
    required TResult Function(_InitialTaskToggleState value) initial,
    required TResult Function(_LoadingTaskToggleState value) loading,
    required TResult Function(_SuccessTaskToggleState value) success,
    required TResult Function(_FailureTaskToggleState value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskToggleState value)? initial,
    TResult? Function(_LoadingTaskToggleState value)? loading,
    TResult? Function(_SuccessTaskToggleState value)? success,
    TResult? Function(_FailureTaskToggleState value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskToggleState value)? initial,
    TResult Function(_LoadingTaskToggleState value)? loading,
    TResult Function(_SuccessTaskToggleState value)? success,
    TResult Function(_FailureTaskToggleState value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingTaskToggleState extends TaskToggleState {
  const factory _LoadingTaskToggleState() = _$LoadingTaskToggleStateImpl;
  const _LoadingTaskToggleState._() : super._();
}

/// @nodoc
abstract class _$$SuccessTaskToggleStateImplCopyWith<$Res> {
  factory _$$SuccessTaskToggleStateImplCopyWith(
          _$SuccessTaskToggleStateImpl value,
          $Res Function(_$SuccessTaskToggleStateImpl) then) =
      __$$SuccessTaskToggleStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Task task});

  $TaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$SuccessTaskToggleStateImplCopyWithImpl<$Res>
    extends _$TaskToggleStateCopyWithImpl<$Res, _$SuccessTaskToggleStateImpl>
    implements _$$SuccessTaskToggleStateImplCopyWith<$Res> {
  __$$SuccessTaskToggleStateImplCopyWithImpl(
      _$SuccessTaskToggleStateImpl _value,
      $Res Function(_$SuccessTaskToggleStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$SuccessTaskToggleStateImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskCopyWith<$Res> get task {
    return $TaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$SuccessTaskToggleStateImpl extends _SuccessTaskToggleState {
  const _$SuccessTaskToggleStateImpl(this.task) : super._();

  @override
  final Task task;

  @override
  String toString() {
    return 'TaskToggleState.success(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessTaskToggleStateImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessTaskToggleStateImplCopyWith<_$SuccessTaskToggleStateImpl>
      get copyWith => __$$SuccessTaskToggleStateImplCopyWithImpl<
          _$SuccessTaskToggleStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Task task) success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Task task)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Task task)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialTaskToggleState value) initial,
    required TResult Function(_LoadingTaskToggleState value) loading,
    required TResult Function(_SuccessTaskToggleState value) success,
    required TResult Function(_FailureTaskToggleState value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskToggleState value)? initial,
    TResult? Function(_LoadingTaskToggleState value)? loading,
    TResult? Function(_SuccessTaskToggleState value)? success,
    TResult? Function(_FailureTaskToggleState value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskToggleState value)? initial,
    TResult Function(_LoadingTaskToggleState value)? loading,
    TResult Function(_SuccessTaskToggleState value)? success,
    TResult Function(_FailureTaskToggleState value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessTaskToggleState extends TaskToggleState {
  const factory _SuccessTaskToggleState(final Task task) =
      _$SuccessTaskToggleStateImpl;
  const _SuccessTaskToggleState._() : super._();

  Task get task;

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessTaskToggleStateImplCopyWith<_$SuccessTaskToggleStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureTaskToggleStateImplCopyWith<$Res> {
  factory _$$FailureTaskToggleStateImplCopyWith(
          _$FailureTaskToggleStateImpl value,
          $Res Function(_$FailureTaskToggleStateImpl) then) =
      __$$FailureTaskToggleStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureTaskToggleStateImplCopyWithImpl<$Res>
    extends _$TaskToggleStateCopyWithImpl<$Res, _$FailureTaskToggleStateImpl>
    implements _$$FailureTaskToggleStateImplCopyWith<$Res> {
  __$$FailureTaskToggleStateImplCopyWithImpl(
      _$FailureTaskToggleStateImpl _value,
      $Res Function(_$FailureTaskToggleStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureTaskToggleStateImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureTaskToggleStateImpl extends _FailureTaskToggleState {
  const _$FailureTaskToggleStateImpl(this.exception) : super._();

  @override
  final AppException exception;

  @override
  String toString() {
    return 'TaskToggleState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureTaskToggleStateImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureTaskToggleStateImplCopyWith<_$FailureTaskToggleStateImpl>
      get copyWith => __$$FailureTaskToggleStateImplCopyWithImpl<
          _$FailureTaskToggleStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Task task) success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Task task)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Task task)? success,
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
    required TResult Function(_InitialTaskToggleState value) initial,
    required TResult Function(_LoadingTaskToggleState value) loading,
    required TResult Function(_SuccessTaskToggleState value) success,
    required TResult Function(_FailureTaskToggleState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskToggleState value)? initial,
    TResult? Function(_LoadingTaskToggleState value)? loading,
    TResult? Function(_SuccessTaskToggleState value)? success,
    TResult? Function(_FailureTaskToggleState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskToggleState value)? initial,
    TResult Function(_LoadingTaskToggleState value)? loading,
    TResult Function(_SuccessTaskToggleState value)? success,
    TResult Function(_FailureTaskToggleState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureTaskToggleState extends TaskToggleState {
  const factory _FailureTaskToggleState(final AppException exception) =
      _$FailureTaskToggleStateImpl;
  const _FailureTaskToggleState._() : super._();

  AppException get exception;

  /// Create a copy of TaskToggleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureTaskToggleStateImplCopyWith<_$FailureTaskToggleStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
