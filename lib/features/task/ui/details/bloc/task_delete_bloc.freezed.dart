// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_delete_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskDeleteEvent {
  String get taskId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String taskId) deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String taskId)? deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String taskId)? deleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeletedTaskDeleteEvent value) deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeletedTaskDeleteEvent value)? deleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeletedTaskDeleteEvent value)? deleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TaskDeleteEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskDeleteEventCopyWith<TaskDeleteEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDeleteEventCopyWith<$Res> {
  factory $TaskDeleteEventCopyWith(
          TaskDeleteEvent value, $Res Function(TaskDeleteEvent) then) =
      _$TaskDeleteEventCopyWithImpl<$Res, TaskDeleteEvent>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class _$TaskDeleteEventCopyWithImpl<$Res, $Val extends TaskDeleteEvent>
    implements $TaskDeleteEventCopyWith<$Res> {
  _$TaskDeleteEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskDeleteEvent
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
abstract class _$$DeletedTaskDeleteEventImplCopyWith<$Res>
    implements $TaskDeleteEventCopyWith<$Res> {
  factory _$$DeletedTaskDeleteEventImplCopyWith(
          _$DeletedTaskDeleteEventImpl value,
          $Res Function(_$DeletedTaskDeleteEventImpl) then) =
      __$$DeletedTaskDeleteEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$DeletedTaskDeleteEventImplCopyWithImpl<$Res>
    extends _$TaskDeleteEventCopyWithImpl<$Res, _$DeletedTaskDeleteEventImpl>
    implements _$$DeletedTaskDeleteEventImplCopyWith<$Res> {
  __$$DeletedTaskDeleteEventImplCopyWithImpl(
      _$DeletedTaskDeleteEventImpl _value,
      $Res Function(_$DeletedTaskDeleteEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDeleteEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$DeletedTaskDeleteEventImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletedTaskDeleteEventImpl implements _DeletedTaskDeleteEvent {
  const _$DeletedTaskDeleteEventImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'TaskDeleteEvent.deleted(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletedTaskDeleteEventImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of TaskDeleteEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletedTaskDeleteEventImplCopyWith<_$DeletedTaskDeleteEventImpl>
      get copyWith => __$$DeletedTaskDeleteEventImplCopyWithImpl<
          _$DeletedTaskDeleteEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String taskId) deleted,
  }) {
    return deleted(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String taskId)? deleted,
  }) {
    return deleted?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String taskId)? deleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeletedTaskDeleteEvent value) deleted,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeletedTaskDeleteEvent value)? deleted,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeletedTaskDeleteEvent value)? deleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class _DeletedTaskDeleteEvent implements TaskDeleteEvent {
  const factory _DeletedTaskDeleteEvent(final String taskId) =
      _$DeletedTaskDeleteEventImpl;

  @override
  String get taskId;

  /// Create a copy of TaskDeleteEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletedTaskDeleteEventImplCopyWith<_$DeletedTaskDeleteEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TaskDeleteState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialTaskDeleteState value) initial,
    required TResult Function(_LoadingTaskDeleteState value) loading,
    required TResult Function(_SuccessTaskDeleteState value) success,
    required TResult Function(_FailureTaskDeleteState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskDeleteState value)? initial,
    TResult? Function(_LoadingTaskDeleteState value)? loading,
    TResult? Function(_SuccessTaskDeleteState value)? success,
    TResult? Function(_FailureTaskDeleteState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskDeleteState value)? initial,
    TResult Function(_LoadingTaskDeleteState value)? loading,
    TResult Function(_SuccessTaskDeleteState value)? success,
    TResult Function(_FailureTaskDeleteState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDeleteStateCopyWith<$Res> {
  factory $TaskDeleteStateCopyWith(
          TaskDeleteState value, $Res Function(TaskDeleteState) then) =
      _$TaskDeleteStateCopyWithImpl<$Res, TaskDeleteState>;
}

/// @nodoc
class _$TaskDeleteStateCopyWithImpl<$Res, $Val extends TaskDeleteState>
    implements $TaskDeleteStateCopyWith<$Res> {
  _$TaskDeleteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialTaskDeleteStateImplCopyWith<$Res> {
  factory _$$InitialTaskDeleteStateImplCopyWith(
          _$InitialTaskDeleteStateImpl value,
          $Res Function(_$InitialTaskDeleteStateImpl) then) =
      __$$InitialTaskDeleteStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialTaskDeleteStateImplCopyWithImpl<$Res>
    extends _$TaskDeleteStateCopyWithImpl<$Res, _$InitialTaskDeleteStateImpl>
    implements _$$InitialTaskDeleteStateImplCopyWith<$Res> {
  __$$InitialTaskDeleteStateImplCopyWithImpl(
      _$InitialTaskDeleteStateImpl _value,
      $Res Function(_$InitialTaskDeleteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialTaskDeleteStateImpl extends _InitialTaskDeleteState {
  const _$InitialTaskDeleteStateImpl() : super._();

  @override
  String toString() {
    return 'TaskDeleteState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialTaskDeleteStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
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
    required TResult Function(_InitialTaskDeleteState value) initial,
    required TResult Function(_LoadingTaskDeleteState value) loading,
    required TResult Function(_SuccessTaskDeleteState value) success,
    required TResult Function(_FailureTaskDeleteState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskDeleteState value)? initial,
    TResult? Function(_LoadingTaskDeleteState value)? loading,
    TResult? Function(_SuccessTaskDeleteState value)? success,
    TResult? Function(_FailureTaskDeleteState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskDeleteState value)? initial,
    TResult Function(_LoadingTaskDeleteState value)? loading,
    TResult Function(_SuccessTaskDeleteState value)? success,
    TResult Function(_FailureTaskDeleteState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialTaskDeleteState extends TaskDeleteState {
  const factory _InitialTaskDeleteState() = _$InitialTaskDeleteStateImpl;
  const _InitialTaskDeleteState._() : super._();
}

/// @nodoc
abstract class _$$LoadingTaskDeleteStateImplCopyWith<$Res> {
  factory _$$LoadingTaskDeleteStateImplCopyWith(
          _$LoadingTaskDeleteStateImpl value,
          $Res Function(_$LoadingTaskDeleteStateImpl) then) =
      __$$LoadingTaskDeleteStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingTaskDeleteStateImplCopyWithImpl<$Res>
    extends _$TaskDeleteStateCopyWithImpl<$Res, _$LoadingTaskDeleteStateImpl>
    implements _$$LoadingTaskDeleteStateImplCopyWith<$Res> {
  __$$LoadingTaskDeleteStateImplCopyWithImpl(
      _$LoadingTaskDeleteStateImpl _value,
      $Res Function(_$LoadingTaskDeleteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingTaskDeleteStateImpl extends _LoadingTaskDeleteState {
  const _$LoadingTaskDeleteStateImpl() : super._();

  @override
  String toString() {
    return 'TaskDeleteState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingTaskDeleteStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
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
    required TResult Function(_InitialTaskDeleteState value) initial,
    required TResult Function(_LoadingTaskDeleteState value) loading,
    required TResult Function(_SuccessTaskDeleteState value) success,
    required TResult Function(_FailureTaskDeleteState value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskDeleteState value)? initial,
    TResult? Function(_LoadingTaskDeleteState value)? loading,
    TResult? Function(_SuccessTaskDeleteState value)? success,
    TResult? Function(_FailureTaskDeleteState value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskDeleteState value)? initial,
    TResult Function(_LoadingTaskDeleteState value)? loading,
    TResult Function(_SuccessTaskDeleteState value)? success,
    TResult Function(_FailureTaskDeleteState value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingTaskDeleteState extends TaskDeleteState {
  const factory _LoadingTaskDeleteState() = _$LoadingTaskDeleteStateImpl;
  const _LoadingTaskDeleteState._() : super._();
}

/// @nodoc
abstract class _$$SuccessTaskDeleteStateImplCopyWith<$Res> {
  factory _$$SuccessTaskDeleteStateImplCopyWith(
          _$SuccessTaskDeleteStateImpl value,
          $Res Function(_$SuccessTaskDeleteStateImpl) then) =
      __$$SuccessTaskDeleteStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessTaskDeleteStateImplCopyWithImpl<$Res>
    extends _$TaskDeleteStateCopyWithImpl<$Res, _$SuccessTaskDeleteStateImpl>
    implements _$$SuccessTaskDeleteStateImplCopyWith<$Res> {
  __$$SuccessTaskDeleteStateImplCopyWithImpl(
      _$SuccessTaskDeleteStateImpl _value,
      $Res Function(_$SuccessTaskDeleteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessTaskDeleteStateImpl extends _SuccessTaskDeleteState {
  const _$SuccessTaskDeleteStateImpl() : super._();

  @override
  String toString() {
    return 'TaskDeleteState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessTaskDeleteStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialTaskDeleteState value) initial,
    required TResult Function(_LoadingTaskDeleteState value) loading,
    required TResult Function(_SuccessTaskDeleteState value) success,
    required TResult Function(_FailureTaskDeleteState value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskDeleteState value)? initial,
    TResult? Function(_LoadingTaskDeleteState value)? loading,
    TResult? Function(_SuccessTaskDeleteState value)? success,
    TResult? Function(_FailureTaskDeleteState value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskDeleteState value)? initial,
    TResult Function(_LoadingTaskDeleteState value)? loading,
    TResult Function(_SuccessTaskDeleteState value)? success,
    TResult Function(_FailureTaskDeleteState value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessTaskDeleteState extends TaskDeleteState {
  const factory _SuccessTaskDeleteState() = _$SuccessTaskDeleteStateImpl;
  const _SuccessTaskDeleteState._() : super._();
}

/// @nodoc
abstract class _$$FailureTaskDeleteStateImplCopyWith<$Res> {
  factory _$$FailureTaskDeleteStateImplCopyWith(
          _$FailureTaskDeleteStateImpl value,
          $Res Function(_$FailureTaskDeleteStateImpl) then) =
      __$$FailureTaskDeleteStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});

  $AppExceptionCopyWith<$Res> get exception;
}

/// @nodoc
class __$$FailureTaskDeleteStateImplCopyWithImpl<$Res>
    extends _$TaskDeleteStateCopyWithImpl<$Res, _$FailureTaskDeleteStateImpl>
    implements _$$FailureTaskDeleteStateImplCopyWith<$Res> {
  __$$FailureTaskDeleteStateImplCopyWithImpl(
      _$FailureTaskDeleteStateImpl _value,
      $Res Function(_$FailureTaskDeleteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureTaskDeleteStateImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppExceptionCopyWith<$Res> get exception {
    return $AppExceptionCopyWith<$Res>(_value.exception, (value) {
      return _then(_value.copyWith(exception: value));
    });
  }
}

/// @nodoc

class _$FailureTaskDeleteStateImpl extends _FailureTaskDeleteState {
  const _$FailureTaskDeleteStateImpl(this.exception) : super._();

  @override
  final AppException exception;

  @override
  String toString() {
    return 'TaskDeleteState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureTaskDeleteStateImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureTaskDeleteStateImplCopyWith<_$FailureTaskDeleteStateImpl>
      get copyWith => __$$FailureTaskDeleteStateImplCopyWithImpl<
          _$FailureTaskDeleteStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
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
    required TResult Function(_InitialTaskDeleteState value) initial,
    required TResult Function(_LoadingTaskDeleteState value) loading,
    required TResult Function(_SuccessTaskDeleteState value) success,
    required TResult Function(_FailureTaskDeleteState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTaskDeleteState value)? initial,
    TResult? Function(_LoadingTaskDeleteState value)? loading,
    TResult? Function(_SuccessTaskDeleteState value)? success,
    TResult? Function(_FailureTaskDeleteState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTaskDeleteState value)? initial,
    TResult Function(_LoadingTaskDeleteState value)? loading,
    TResult Function(_SuccessTaskDeleteState value)? success,
    TResult Function(_FailureTaskDeleteState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureTaskDeleteState extends TaskDeleteState {
  const factory _FailureTaskDeleteState(final AppException exception) =
      _$FailureTaskDeleteStateImpl;
  const _FailureTaskDeleteState._() : super._();

  AppException get exception;

  /// Create a copy of TaskDeleteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureTaskDeleteStateImplCopyWith<_$FailureTaskDeleteStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
