// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TasksListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function(String taskId) taskToggled,
    required TResult Function(String taskId) taskDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function(String taskId)? taskToggled,
    TResult? Function(String taskId)? taskDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String taskId)? taskToggled,
    TResult Function(String taskId)? taskDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadedTasksListEvent value) loaded,
    required TResult Function(_TaskToggledTasksListEvent value) taskToggled,
    required TResult Function(_TaskDeletedTasksListEvent value) taskDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedTasksListEvent value)? loaded,
    TResult? Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult? Function(_TaskDeletedTasksListEvent value)? taskDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedTasksListEvent value)? loaded,
    TResult Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult Function(_TaskDeletedTasksListEvent value)? taskDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksListEventCopyWith<$Res> {
  factory $TasksListEventCopyWith(
          TasksListEvent value, $Res Function(TasksListEvent) then) =
      _$TasksListEventCopyWithImpl<$Res, TasksListEvent>;
}

/// @nodoc
class _$TasksListEventCopyWithImpl<$Res, $Val extends TasksListEvent>
    implements $TasksListEventCopyWith<$Res> {
  _$TasksListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadedTasksListEventImplCopyWith<$Res> {
  factory _$$LoadedTasksListEventImplCopyWith(_$LoadedTasksListEventImpl value,
          $Res Function(_$LoadedTasksListEventImpl) then) =
      __$$LoadedTasksListEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadedTasksListEventImplCopyWithImpl<$Res>
    extends _$TasksListEventCopyWithImpl<$Res, _$LoadedTasksListEventImpl>
    implements _$$LoadedTasksListEventImplCopyWith<$Res> {
  __$$LoadedTasksListEventImplCopyWithImpl(_$LoadedTasksListEventImpl _value,
      $Res Function(_$LoadedTasksListEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadedTasksListEventImpl implements _LoadedTasksListEvent {
  const _$LoadedTasksListEventImpl();

  @override
  String toString() {
    return 'TasksListEvent.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedTasksListEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function(String taskId) taskToggled,
    required TResult Function(String taskId) taskDeleted,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function(String taskId)? taskToggled,
    TResult? Function(String taskId)? taskDeleted,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String taskId)? taskToggled,
    TResult Function(String taskId)? taskDeleted,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadedTasksListEvent value) loaded,
    required TResult Function(_TaskToggledTasksListEvent value) taskToggled,
    required TResult Function(_TaskDeletedTasksListEvent value) taskDeleted,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedTasksListEvent value)? loaded,
    TResult? Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult? Function(_TaskDeletedTasksListEvent value)? taskDeleted,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedTasksListEvent value)? loaded,
    TResult Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult Function(_TaskDeletedTasksListEvent value)? taskDeleted,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _LoadedTasksListEvent implements TasksListEvent {
  const factory _LoadedTasksListEvent() = _$LoadedTasksListEventImpl;
}

/// @nodoc
abstract class _$$TaskToggledTasksListEventImplCopyWith<$Res> {
  factory _$$TaskToggledTasksListEventImplCopyWith(
          _$TaskToggledTasksListEventImpl value,
          $Res Function(_$TaskToggledTasksListEventImpl) then) =
      __$$TaskToggledTasksListEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$TaskToggledTasksListEventImplCopyWithImpl<$Res>
    extends _$TasksListEventCopyWithImpl<$Res, _$TaskToggledTasksListEventImpl>
    implements _$$TaskToggledTasksListEventImplCopyWith<$Res> {
  __$$TaskToggledTasksListEventImplCopyWithImpl(
      _$TaskToggledTasksListEventImpl _value,
      $Res Function(_$TaskToggledTasksListEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$TaskToggledTasksListEventImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskToggledTasksListEventImpl implements _TaskToggledTasksListEvent {
  const _$TaskToggledTasksListEventImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'TasksListEvent.taskToggled(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskToggledTasksListEventImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskToggledTasksListEventImplCopyWith<_$TaskToggledTasksListEventImpl>
      get copyWith => __$$TaskToggledTasksListEventImplCopyWithImpl<
          _$TaskToggledTasksListEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function(String taskId) taskToggled,
    required TResult Function(String taskId) taskDeleted,
  }) {
    return taskToggled(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function(String taskId)? taskToggled,
    TResult? Function(String taskId)? taskDeleted,
  }) {
    return taskToggled?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String taskId)? taskToggled,
    TResult Function(String taskId)? taskDeleted,
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
    required TResult Function(_LoadedTasksListEvent value) loaded,
    required TResult Function(_TaskToggledTasksListEvent value) taskToggled,
    required TResult Function(_TaskDeletedTasksListEvent value) taskDeleted,
  }) {
    return taskToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedTasksListEvent value)? loaded,
    TResult? Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult? Function(_TaskDeletedTasksListEvent value)? taskDeleted,
  }) {
    return taskToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedTasksListEvent value)? loaded,
    TResult Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult Function(_TaskDeletedTasksListEvent value)? taskDeleted,
    required TResult orElse(),
  }) {
    if (taskToggled != null) {
      return taskToggled(this);
    }
    return orElse();
  }
}

abstract class _TaskToggledTasksListEvent implements TasksListEvent {
  const factory _TaskToggledTasksListEvent(final String taskId) =
      _$TaskToggledTasksListEventImpl;

  String get taskId;

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskToggledTasksListEventImplCopyWith<_$TaskToggledTasksListEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskDeletedTasksListEventImplCopyWith<$Res> {
  factory _$$TaskDeletedTasksListEventImplCopyWith(
          _$TaskDeletedTasksListEventImpl value,
          $Res Function(_$TaskDeletedTasksListEventImpl) then) =
      __$$TaskDeletedTasksListEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$TaskDeletedTasksListEventImplCopyWithImpl<$Res>
    extends _$TasksListEventCopyWithImpl<$Res, _$TaskDeletedTasksListEventImpl>
    implements _$$TaskDeletedTasksListEventImplCopyWith<$Res> {
  __$$TaskDeletedTasksListEventImplCopyWithImpl(
      _$TaskDeletedTasksListEventImpl _value,
      $Res Function(_$TaskDeletedTasksListEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$TaskDeletedTasksListEventImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskDeletedTasksListEventImpl implements _TaskDeletedTasksListEvent {
  const _$TaskDeletedTasksListEventImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'TasksListEvent.taskDeleted(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDeletedTasksListEventImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDeletedTasksListEventImplCopyWith<_$TaskDeletedTasksListEventImpl>
      get copyWith => __$$TaskDeletedTasksListEventImplCopyWithImpl<
          _$TaskDeletedTasksListEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function(String taskId) taskToggled,
    required TResult Function(String taskId) taskDeleted,
  }) {
    return taskDeleted(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function(String taskId)? taskToggled,
    TResult? Function(String taskId)? taskDeleted,
  }) {
    return taskDeleted?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function(String taskId)? taskToggled,
    TResult Function(String taskId)? taskDeleted,
    required TResult orElse(),
  }) {
    if (taskDeleted != null) {
      return taskDeleted(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadedTasksListEvent value) loaded,
    required TResult Function(_TaskToggledTasksListEvent value) taskToggled,
    required TResult Function(_TaskDeletedTasksListEvent value) taskDeleted,
  }) {
    return taskDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedTasksListEvent value)? loaded,
    TResult? Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult? Function(_TaskDeletedTasksListEvent value)? taskDeleted,
  }) {
    return taskDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedTasksListEvent value)? loaded,
    TResult Function(_TaskToggledTasksListEvent value)? taskToggled,
    TResult Function(_TaskDeletedTasksListEvent value)? taskDeleted,
    required TResult orElse(),
  }) {
    if (taskDeleted != null) {
      return taskDeleted(this);
    }
    return orElse();
  }
}

abstract class _TaskDeletedTasksListEvent implements TasksListEvent {
  const factory _TaskDeletedTasksListEvent(final String taskId) =
      _$TaskDeletedTasksListEventImpl;

  String get taskId;

  /// Create a copy of TasksListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDeletedTasksListEventImplCopyWith<_$TaskDeletedTasksListEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TasksListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)
        success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialTasksListState value) initial,
    required TResult Function(_LoadingTasksListState value) loading,
    required TResult Function(_SuccessTasksListState value) success,
    required TResult Function(_FailureTasksListState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTasksListState value)? initial,
    TResult? Function(_LoadingTasksListState value)? loading,
    TResult? Function(_SuccessTasksListState value)? success,
    TResult? Function(_FailureTasksListState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTasksListState value)? initial,
    TResult Function(_LoadingTasksListState value)? loading,
    TResult Function(_SuccessTasksListState value)? success,
    TResult Function(_FailureTasksListState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksListStateCopyWith<$Res> {
  factory $TasksListStateCopyWith(
          TasksListState value, $Res Function(TasksListState) then) =
      _$TasksListStateCopyWithImpl<$Res, TasksListState>;
}

/// @nodoc
class _$TasksListStateCopyWithImpl<$Res, $Val extends TasksListState>
    implements $TasksListStateCopyWith<$Res> {
  _$TasksListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialTasksListStateImplCopyWith<$Res> {
  factory _$$InitialTasksListStateImplCopyWith(
          _$InitialTasksListStateImpl value,
          $Res Function(_$InitialTasksListStateImpl) then) =
      __$$InitialTasksListStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialTasksListStateImplCopyWithImpl<$Res>
    extends _$TasksListStateCopyWithImpl<$Res, _$InitialTasksListStateImpl>
    implements _$$InitialTasksListStateImplCopyWith<$Res> {
  __$$InitialTasksListStateImplCopyWithImpl(_$InitialTasksListStateImpl _value,
      $Res Function(_$InitialTasksListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialTasksListStateImpl extends _InitialTasksListState {
  const _$InitialTasksListStateImpl() : super._();

  @override
  String toString() {
    return 'TasksListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialTasksListStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
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
    required TResult Function(_InitialTasksListState value) initial,
    required TResult Function(_LoadingTasksListState value) loading,
    required TResult Function(_SuccessTasksListState value) success,
    required TResult Function(_FailureTasksListState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTasksListState value)? initial,
    TResult? Function(_LoadingTasksListState value)? loading,
    TResult? Function(_SuccessTasksListState value)? success,
    TResult? Function(_FailureTasksListState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTasksListState value)? initial,
    TResult Function(_LoadingTasksListState value)? loading,
    TResult Function(_SuccessTasksListState value)? success,
    TResult Function(_FailureTasksListState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialTasksListState extends TasksListState {
  const factory _InitialTasksListState() = _$InitialTasksListStateImpl;
  const _InitialTasksListState._() : super._();
}

/// @nodoc
abstract class _$$LoadingTasksListStateImplCopyWith<$Res> {
  factory _$$LoadingTasksListStateImplCopyWith(
          _$LoadingTasksListStateImpl value,
          $Res Function(_$LoadingTasksListStateImpl) then) =
      __$$LoadingTasksListStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingTasksListStateImplCopyWithImpl<$Res>
    extends _$TasksListStateCopyWithImpl<$Res, _$LoadingTasksListStateImpl>
    implements _$$LoadingTasksListStateImplCopyWith<$Res> {
  __$$LoadingTasksListStateImplCopyWithImpl(_$LoadingTasksListStateImpl _value,
      $Res Function(_$LoadingTasksListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingTasksListStateImpl extends _LoadingTasksListState {
  const _$LoadingTasksListStateImpl() : super._();

  @override
  String toString() {
    return 'TasksListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingTasksListStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
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
    required TResult Function(_InitialTasksListState value) initial,
    required TResult Function(_LoadingTasksListState value) loading,
    required TResult Function(_SuccessTasksListState value) success,
    required TResult Function(_FailureTasksListState value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTasksListState value)? initial,
    TResult? Function(_LoadingTasksListState value)? loading,
    TResult? Function(_SuccessTasksListState value)? success,
    TResult? Function(_FailureTasksListState value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTasksListState value)? initial,
    TResult Function(_LoadingTasksListState value)? loading,
    TResult Function(_SuccessTasksListState value)? success,
    TResult Function(_FailureTasksListState value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingTasksListState extends TasksListState {
  const factory _LoadingTasksListState() = _$LoadingTasksListStateImpl;
  const _LoadingTasksListState._() : super._();
}

/// @nodoc
abstract class _$$SuccessTasksListStateImplCopyWith<$Res> {
  factory _$$SuccessTasksListStateImplCopyWith(
          _$SuccessTasksListStateImpl value,
          $Res Function(_$SuccessTasksListStateImpl) then) =
      __$$SuccessTasksListStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Task> tasks, Map<DateTime, List<Task>> groupedTasks});
}

/// @nodoc
class __$$SuccessTasksListStateImplCopyWithImpl<$Res>
    extends _$TasksListStateCopyWithImpl<$Res, _$SuccessTasksListStateImpl>
    implements _$$SuccessTasksListStateImplCopyWith<$Res> {
  __$$SuccessTasksListStateImplCopyWithImpl(_$SuccessTasksListStateImpl _value,
      $Res Function(_$SuccessTasksListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? groupedTasks = null,
  }) {
    return _then(_$SuccessTasksListStateImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      groupedTasks: null == groupedTasks
          ? _value._groupedTasks
          : groupedTasks // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<Task>>,
    ));
  }
}

/// @nodoc

class _$SuccessTasksListStateImpl extends _SuccessTasksListState {
  const _$SuccessTasksListStateImpl(
      {required final List<Task> tasks,
      required final Map<DateTime, List<Task>> groupedTasks})
      : _tasks = tasks,
        _groupedTasks = groupedTasks,
        super._();

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final Map<DateTime, List<Task>> _groupedTasks;
  @override
  Map<DateTime, List<Task>> get groupedTasks {
    if (_groupedTasks is EqualUnmodifiableMapView) return _groupedTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_groupedTasks);
  }

  @override
  String toString() {
    return 'TasksListState.success(tasks: $tasks, groupedTasks: $groupedTasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessTasksListStateImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._groupedTasks, _groupedTasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_groupedTasks));

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessTasksListStateImplCopyWith<_$SuccessTasksListStateImpl>
      get copyWith => __$$SuccessTasksListStateImplCopyWithImpl<
          _$SuccessTasksListStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(tasks, groupedTasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(tasks, groupedTasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(tasks, groupedTasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialTasksListState value) initial,
    required TResult Function(_LoadingTasksListState value) loading,
    required TResult Function(_SuccessTasksListState value) success,
    required TResult Function(_FailureTasksListState value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTasksListState value)? initial,
    TResult? Function(_LoadingTasksListState value)? loading,
    TResult? Function(_SuccessTasksListState value)? success,
    TResult? Function(_FailureTasksListState value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTasksListState value)? initial,
    TResult Function(_LoadingTasksListState value)? loading,
    TResult Function(_SuccessTasksListState value)? success,
    TResult Function(_FailureTasksListState value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessTasksListState extends TasksListState {
  const factory _SuccessTasksListState(
          {required final List<Task> tasks,
          required final Map<DateTime, List<Task>> groupedTasks}) =
      _$SuccessTasksListStateImpl;
  const _SuccessTasksListState._() : super._();

  List<Task> get tasks;
  Map<DateTime, List<Task>> get groupedTasks;

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessTasksListStateImplCopyWith<_$SuccessTasksListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureTasksListStateImplCopyWith<$Res> {
  factory _$$FailureTasksListStateImplCopyWith(
          _$FailureTasksListStateImpl value,
          $Res Function(_$FailureTasksListStateImpl) then) =
      __$$FailureTasksListStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureTasksListStateImplCopyWithImpl<$Res>
    extends _$TasksListStateCopyWithImpl<$Res, _$FailureTasksListStateImpl>
    implements _$$FailureTasksListStateImplCopyWith<$Res> {
  __$$FailureTasksListStateImplCopyWithImpl(_$FailureTasksListStateImpl _value,
      $Res Function(_$FailureTasksListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureTasksListStateImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureTasksListStateImpl extends _FailureTasksListState {
  const _$FailureTasksListStateImpl(this.exception) : super._();

  @override
  final AppException exception;

  @override
  String toString() {
    return 'TasksListState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureTasksListStateImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureTasksListStateImplCopyWith<_$FailureTasksListStateImpl>
      get copyWith => __$$FailureTasksListStateImplCopyWithImpl<
          _$FailureTasksListStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)
        success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Task> tasks, Map<DateTime, List<Task>> groupedTasks)?
        success,
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
    required TResult Function(_InitialTasksListState value) initial,
    required TResult Function(_LoadingTasksListState value) loading,
    required TResult Function(_SuccessTasksListState value) success,
    required TResult Function(_FailureTasksListState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialTasksListState value)? initial,
    TResult? Function(_LoadingTasksListState value)? loading,
    TResult? Function(_SuccessTasksListState value)? success,
    TResult? Function(_FailureTasksListState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialTasksListState value)? initial,
    TResult Function(_LoadingTasksListState value)? loading,
    TResult Function(_SuccessTasksListState value)? success,
    TResult Function(_FailureTasksListState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureTasksListState extends TasksListState {
  const factory _FailureTasksListState(final AppException exception) =
      _$FailureTasksListStateImpl;
  const _FailureTasksListState._() : super._();

  AppException get exception;

  /// Create a copy of TasksListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureTasksListStateImplCopyWith<_$FailureTasksListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
