// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasksListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksListEvent()';
}


}

/// @nodoc
class $TasksListEventCopyWith<$Res>  {
$TasksListEventCopyWith(TasksListEvent _, $Res Function(TasksListEvent) __);
}


/// Adds pattern-matching-related methods to [TasksListEvent].
extension TasksListEventPatterns on TasksListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RequestedTasksListEvent value)?  requested,TResult Function( _RefreshedTasksListEvent value)?  refreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestedTasksListEvent() when requested != null:
return requested(_that);case _RefreshedTasksListEvent() when refreshed != null:
return refreshed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RequestedTasksListEvent value)  requested,required TResult Function( _RefreshedTasksListEvent value)  refreshed,}){
final _that = this;
switch (_that) {
case _RequestedTasksListEvent():
return requested(_that);case _RefreshedTasksListEvent():
return refreshed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RequestedTasksListEvent value)?  requested,TResult? Function( _RefreshedTasksListEvent value)?  refreshed,}){
final _that = this;
switch (_that) {
case _RequestedTasksListEvent() when requested != null:
return requested(_that);case _RefreshedTasksListEvent() when refreshed != null:
return refreshed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  requested,TResult Function()?  refreshed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestedTasksListEvent() when requested != null:
return requested();case _RefreshedTasksListEvent() when refreshed != null:
return refreshed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  requested,required TResult Function()  refreshed,}) {final _that = this;
switch (_that) {
case _RequestedTasksListEvent():
return requested();case _RefreshedTasksListEvent():
return refreshed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  requested,TResult? Function()?  refreshed,}) {final _that = this;
switch (_that) {
case _RequestedTasksListEvent() when requested != null:
return requested();case _RefreshedTasksListEvent() when refreshed != null:
return refreshed();case _:
  return null;

}
}

}

/// @nodoc


class _RequestedTasksListEvent implements TasksListEvent {
  const _RequestedTasksListEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestedTasksListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksListEvent.requested()';
}


}

/// @nodoc
class _$RequestedTasksListEventCopyWith<$Res> implements $TasksListEventCopyWith<$Res> {
_$RequestedTasksListEventCopyWith(_RequestedTasksListEvent _, $Res Function(_RequestedTasksListEvent) __);
}
/// @nodoc
class __$RequestedTasksListEventCopyWithImpl<$Res>
    implements _$RequestedTasksListEventCopyWith<$Res> {
  __$RequestedTasksListEventCopyWithImpl(this._self, this._then);

  final _RequestedTasksListEvent _self;
  final $Res Function(_RequestedTasksListEvent) _then;




}

/// @nodoc


class _RefreshedTasksListEvent implements TasksListEvent {
  const _RefreshedTasksListEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshedTasksListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksListEvent.refreshed()';
}


}

/// @nodoc
class _$RefreshedTasksListEventCopyWith<$Res> implements $TasksListEventCopyWith<$Res> {
_$RefreshedTasksListEventCopyWith(_RefreshedTasksListEvent _, $Res Function(_RefreshedTasksListEvent) __);
}
/// @nodoc
class __$RefreshedTasksListEventCopyWithImpl<$Res>
    implements _$RefreshedTasksListEventCopyWith<$Res> {
  __$RefreshedTasksListEventCopyWithImpl(this._self, this._then);

  final _RefreshedTasksListEvent _self;
  final $Res Function(_RefreshedTasksListEvent) _then;




}

/// @nodoc
mixin _$TasksListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksListState()';
}


}

/// @nodoc
class $TasksListStateCopyWith<$Res>  {
$TasksListStateCopyWith(TasksListState _, $Res Function(TasksListState) __);
}


/// Adds pattern-matching-related methods to [TasksListState].
extension TasksListStatePatterns on TasksListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialTasksListState value)?  initial,TResult Function( LoadingTasksListState value)?  loading,TResult Function( SuccessTasksListState value)?  success,TResult Function( FailureTasksListState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialTasksListState() when initial != null:
return initial(_that);case LoadingTasksListState() when loading != null:
return loading(_that);case SuccessTasksListState() when success != null:
return success(_that);case FailureTasksListState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialTasksListState value)  initial,required TResult Function( LoadingTasksListState value)  loading,required TResult Function( SuccessTasksListState value)  success,required TResult Function( FailureTasksListState value)  failure,}){
final _that = this;
switch (_that) {
case InitialTasksListState():
return initial(_that);case LoadingTasksListState():
return loading(_that);case SuccessTasksListState():
return success(_that);case FailureTasksListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialTasksListState value)?  initial,TResult? Function( LoadingTasksListState value)?  loading,TResult? Function( SuccessTasksListState value)?  success,TResult? Function( FailureTasksListState value)?  failure,}){
final _that = this;
switch (_that) {
case InitialTasksListState() when initial != null:
return initial(_that);case LoadingTasksListState() when loading != null:
return loading(_that);case SuccessTasksListState() when success != null:
return success(_that);case FailureTasksListState() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Task> tasks,  Map<DateTime, List<Task>> groupedTasks)?  success,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialTasksListState() when initial != null:
return initial();case LoadingTasksListState() when loading != null:
return loading();case SuccessTasksListState() when success != null:
return success(_that.tasks,_that.groupedTasks);case FailureTasksListState() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Task> tasks,  Map<DateTime, List<Task>> groupedTasks)  success,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case InitialTasksListState():
return initial();case LoadingTasksListState():
return loading();case SuccessTasksListState():
return success(_that.tasks,_that.groupedTasks);case FailureTasksListState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Task> tasks,  Map<DateTime, List<Task>> groupedTasks)?  success,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case InitialTasksListState() when initial != null:
return initial();case LoadingTasksListState() when loading != null:
return loading();case SuccessTasksListState() when success != null:
return success(_that.tasks,_that.groupedTasks);case FailureTasksListState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialTasksListState extends TasksListState {
  const InitialTasksListState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTasksListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksListState.initial()';
}


}

/// @nodoc
class $InitialTasksListStateCopyWith<$Res> implements $TasksListStateCopyWith<$Res> {
$InitialTasksListStateCopyWith(InitialTasksListState _, $Res Function(InitialTasksListState) __);
}
/// @nodoc
class _$InitialTasksListStateCopyWithImpl<$Res>
    implements $InitialTasksListStateCopyWith<$Res> {
  _$InitialTasksListStateCopyWithImpl(this._self, this._then);

  final InitialTasksListState _self;
  final $Res Function(InitialTasksListState) _then;




}

/// @nodoc


class LoadingTasksListState extends TasksListState {
  const LoadingTasksListState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTasksListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksListState.loading()';
}


}

/// @nodoc
class $LoadingTasksListStateCopyWith<$Res> implements $TasksListStateCopyWith<$Res> {
$LoadingTasksListStateCopyWith(LoadingTasksListState _, $Res Function(LoadingTasksListState) __);
}
/// @nodoc
class _$LoadingTasksListStateCopyWithImpl<$Res>
    implements $LoadingTasksListStateCopyWith<$Res> {
  _$LoadingTasksListStateCopyWithImpl(this._self, this._then);

  final LoadingTasksListState _self;
  final $Res Function(LoadingTasksListState) _then;




}

/// @nodoc


class SuccessTasksListState extends TasksListState {
  const SuccessTasksListState({required this.tasks, required this.groupedTasks}): super._();
  

 final  List<Task> tasks;
 final  Map<DateTime, List<Task>> groupedTasks;

/// Create a copy of TasksListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessTasksListStateCopyWith<SuccessTasksListState> get copyWith => _$SuccessTasksListStateCopyWithImpl<SuccessTasksListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessTasksListState&&const DeepCollectionEquality().equals(other.tasks, tasks)&&const DeepCollectionEquality().equals(other.groupedTasks, groupedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tasks),const DeepCollectionEquality().hash(groupedTasks));

@override
String toString() {
  return 'TasksListState.success(tasks: $tasks, groupedTasks: $groupedTasks)';
}


}

/// @nodoc
abstract mixin class $SuccessTasksListStateCopyWith<$Res> implements $TasksListStateCopyWith<$Res> {
  factory $SuccessTasksListStateCopyWith(SuccessTasksListState value, $Res Function(SuccessTasksListState) _then) = _$SuccessTasksListStateCopyWithImpl;
@useResult
$Res call({
 List<Task> tasks, Map<DateTime, List<Task>> groupedTasks
});




}
/// @nodoc
class _$SuccessTasksListStateCopyWithImpl<$Res>
    implements $SuccessTasksListStateCopyWith<$Res> {
  _$SuccessTasksListStateCopyWithImpl(this._self, this._then);

  final SuccessTasksListState _self;
  final $Res Function(SuccessTasksListState) _then;

/// Create a copy of TasksListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tasks = null,Object? groupedTasks = null,}) {
  return _then(SuccessTasksListState(
tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,groupedTasks: null == groupedTasks ? _self.groupedTasks : groupedTasks // ignore: cast_nullable_to_non_nullable
as Map<DateTime, List<Task>>,
  ));
}


}

/// @nodoc


class FailureTasksListState extends TasksListState {
  const FailureTasksListState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of TasksListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureTasksListStateCopyWith<FailureTasksListState> get copyWith => _$FailureTasksListStateCopyWithImpl<FailureTasksListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureTasksListState&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'TasksListState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureTasksListStateCopyWith<$Res> implements $TasksListStateCopyWith<$Res> {
  factory $FailureTasksListStateCopyWith(FailureTasksListState value, $Res Function(FailureTasksListState) _then) = _$FailureTasksListStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureTasksListStateCopyWithImpl<$Res>
    implements $FailureTasksListStateCopyWith<$Res> {
  _$FailureTasksListStateCopyWithImpl(this._self, this._then);

  final FailureTasksListState _self;
  final $Res Function(FailureTasksListState) _then;

/// Create a copy of TasksListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureTasksListState(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
