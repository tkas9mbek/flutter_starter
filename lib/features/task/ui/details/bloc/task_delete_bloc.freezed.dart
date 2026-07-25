// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_delete_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskDeleteEvent {

 String get taskId;
/// Create a copy of TaskDeleteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDeleteEventCopyWith<TaskDeleteEvent> get copyWith => _$TaskDeleteEventCopyWithImpl<TaskDeleteEvent>(this as TaskDeleteEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDeleteEvent&&(identical(other.taskId, taskId) || other.taskId == taskId));
}


@override
int get hashCode => Object.hash(runtimeType,taskId);

@override
String toString() {
  return 'TaskDeleteEvent(taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class $TaskDeleteEventCopyWith<$Res>  {
  factory $TaskDeleteEventCopyWith(TaskDeleteEvent value, $Res Function(TaskDeleteEvent) _then) = _$TaskDeleteEventCopyWithImpl;
@useResult
$Res call({
 String taskId
});




}
/// @nodoc
class _$TaskDeleteEventCopyWithImpl<$Res>
    implements $TaskDeleteEventCopyWith<$Res> {
  _$TaskDeleteEventCopyWithImpl(this._self, this._then);

  final TaskDeleteEvent _self;
  final $Res Function(TaskDeleteEvent) _then;

/// Create a copy of TaskDeleteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskId = null,}) {
  return _then(_self.copyWith(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskDeleteEvent].
extension TaskDeleteEventPatterns on TaskDeleteEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DeletedTaskDeleteEvent value)?  deleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeletedTaskDeleteEvent() when deleted != null:
return deleted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DeletedTaskDeleteEvent value)  deleted,}){
final _that = this;
switch (_that) {
case _DeletedTaskDeleteEvent():
return deleted(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DeletedTaskDeleteEvent value)?  deleted,}){
final _that = this;
switch (_that) {
case _DeletedTaskDeleteEvent() when deleted != null:
return deleted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String taskId)?  deleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeletedTaskDeleteEvent() when deleted != null:
return deleted(_that.taskId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String taskId)  deleted,}) {final _that = this;
switch (_that) {
case _DeletedTaskDeleteEvent():
return deleted(_that.taskId);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String taskId)?  deleted,}) {final _that = this;
switch (_that) {
case _DeletedTaskDeleteEvent() when deleted != null:
return deleted(_that.taskId);case _:
  return null;

}
}

}

/// @nodoc


class _DeletedTaskDeleteEvent implements TaskDeleteEvent {
  const _DeletedTaskDeleteEvent(this.taskId);
  

@override final  String taskId;

/// Create a copy of TaskDeleteEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeletedTaskDeleteEventCopyWith<_DeletedTaskDeleteEvent> get copyWith => __$DeletedTaskDeleteEventCopyWithImpl<_DeletedTaskDeleteEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeletedTaskDeleteEvent&&(identical(other.taskId, taskId) || other.taskId == taskId));
}


@override
int get hashCode => Object.hash(runtimeType,taskId);

@override
String toString() {
  return 'TaskDeleteEvent.deleted(taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class _$DeletedTaskDeleteEventCopyWith<$Res> implements $TaskDeleteEventCopyWith<$Res> {
  factory _$DeletedTaskDeleteEventCopyWith(_DeletedTaskDeleteEvent value, $Res Function(_DeletedTaskDeleteEvent) _then) = __$DeletedTaskDeleteEventCopyWithImpl;
@override @useResult
$Res call({
 String taskId
});




}
/// @nodoc
class __$DeletedTaskDeleteEventCopyWithImpl<$Res>
    implements _$DeletedTaskDeleteEventCopyWith<$Res> {
  __$DeletedTaskDeleteEventCopyWithImpl(this._self, this._then);

  final _DeletedTaskDeleteEvent _self;
  final $Res Function(_DeletedTaskDeleteEvent) _then;

/// Create a copy of TaskDeleteEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskId = null,}) {
  return _then(_DeletedTaskDeleteEvent(
null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TaskDeleteState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDeleteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskDeleteState()';
}


}

/// @nodoc
class $TaskDeleteStateCopyWith<$Res>  {
$TaskDeleteStateCopyWith(TaskDeleteState _, $Res Function(TaskDeleteState) __);
}


/// Adds pattern-matching-related methods to [TaskDeleteState].
extension TaskDeleteStatePatterns on TaskDeleteState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialTaskDeleteState value)?  initial,TResult Function( LoadingTaskDeleteState value)?  loading,TResult Function( SuccessTaskDeleteState value)?  success,TResult Function( FailureTaskDeleteState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialTaskDeleteState() when initial != null:
return initial(_that);case LoadingTaskDeleteState() when loading != null:
return loading(_that);case SuccessTaskDeleteState() when success != null:
return success(_that);case FailureTaskDeleteState() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialTaskDeleteState value)  initial,required TResult Function( LoadingTaskDeleteState value)  loading,required TResult Function( SuccessTaskDeleteState value)  success,required TResult Function( FailureTaskDeleteState value)  failure,}){
final _that = this;
switch (_that) {
case InitialTaskDeleteState():
return initial(_that);case LoadingTaskDeleteState():
return loading(_that);case SuccessTaskDeleteState():
return success(_that);case FailureTaskDeleteState():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialTaskDeleteState value)?  initial,TResult? Function( LoadingTaskDeleteState value)?  loading,TResult? Function( SuccessTaskDeleteState value)?  success,TResult? Function( FailureTaskDeleteState value)?  failure,}){
final _that = this;
switch (_that) {
case InitialTaskDeleteState() when initial != null:
return initial(_that);case LoadingTaskDeleteState() when loading != null:
return loading(_that);case SuccessTaskDeleteState() when success != null:
return success(_that);case FailureTaskDeleteState() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialTaskDeleteState() when initial != null:
return initial();case LoadingTaskDeleteState() when loading != null:
return loading();case SuccessTaskDeleteState() when success != null:
return success();case FailureTaskDeleteState() when failure != null:
return failure(_that.exception);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case InitialTaskDeleteState():
return initial();case LoadingTaskDeleteState():
return loading();case SuccessTaskDeleteState():
return success();case FailureTaskDeleteState():
return failure(_that.exception);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case InitialTaskDeleteState() when initial != null:
return initial();case LoadingTaskDeleteState() when loading != null:
return loading();case SuccessTaskDeleteState() when success != null:
return success();case FailureTaskDeleteState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialTaskDeleteState extends TaskDeleteState {
  const InitialTaskDeleteState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTaskDeleteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskDeleteState.initial()';
}


}

/// @nodoc
class $InitialTaskDeleteStateCopyWith<$Res> implements $TaskDeleteStateCopyWith<$Res> {
$InitialTaskDeleteStateCopyWith(InitialTaskDeleteState _, $Res Function(InitialTaskDeleteState) __);
}
/// @nodoc
class _$InitialTaskDeleteStateCopyWithImpl<$Res>
    implements $InitialTaskDeleteStateCopyWith<$Res> {
  _$InitialTaskDeleteStateCopyWithImpl(this._self, this._then);

  final InitialTaskDeleteState _self;
  final $Res Function(InitialTaskDeleteState) _then;




}

/// @nodoc


class LoadingTaskDeleteState extends TaskDeleteState {
  const LoadingTaskDeleteState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTaskDeleteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskDeleteState.loading()';
}


}

/// @nodoc
class $LoadingTaskDeleteStateCopyWith<$Res> implements $TaskDeleteStateCopyWith<$Res> {
$LoadingTaskDeleteStateCopyWith(LoadingTaskDeleteState _, $Res Function(LoadingTaskDeleteState) __);
}
/// @nodoc
class _$LoadingTaskDeleteStateCopyWithImpl<$Res>
    implements $LoadingTaskDeleteStateCopyWith<$Res> {
  _$LoadingTaskDeleteStateCopyWithImpl(this._self, this._then);

  final LoadingTaskDeleteState _self;
  final $Res Function(LoadingTaskDeleteState) _then;




}

/// @nodoc


class SuccessTaskDeleteState extends TaskDeleteState {
  const SuccessTaskDeleteState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessTaskDeleteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskDeleteState.success()';
}


}

/// @nodoc
class $SuccessTaskDeleteStateCopyWith<$Res> implements $TaskDeleteStateCopyWith<$Res> {
$SuccessTaskDeleteStateCopyWith(SuccessTaskDeleteState _, $Res Function(SuccessTaskDeleteState) __);
}
/// @nodoc
class _$SuccessTaskDeleteStateCopyWithImpl<$Res>
    implements $SuccessTaskDeleteStateCopyWith<$Res> {
  _$SuccessTaskDeleteStateCopyWithImpl(this._self, this._then);

  final SuccessTaskDeleteState _self;
  final $Res Function(SuccessTaskDeleteState) _then;




}

/// @nodoc


class FailureTaskDeleteState extends TaskDeleteState {
  const FailureTaskDeleteState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of TaskDeleteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureTaskDeleteStateCopyWith<FailureTaskDeleteState> get copyWith => _$FailureTaskDeleteStateCopyWithImpl<FailureTaskDeleteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureTaskDeleteState&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'TaskDeleteState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureTaskDeleteStateCopyWith<$Res> implements $TaskDeleteStateCopyWith<$Res> {
  factory $FailureTaskDeleteStateCopyWith(FailureTaskDeleteState value, $Res Function(FailureTaskDeleteState) _then) = _$FailureTaskDeleteStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureTaskDeleteStateCopyWithImpl<$Res>
    implements $FailureTaskDeleteStateCopyWith<$Res> {
  _$FailureTaskDeleteStateCopyWithImpl(this._self, this._then);

  final FailureTaskDeleteState _self;
  final $Res Function(FailureTaskDeleteState) _then;

/// Create a copy of TaskDeleteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureTaskDeleteState(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
