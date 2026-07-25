// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_creation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskCreationEvent {

 TaskCreateForm get form;
/// Create a copy of TaskCreationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCreationEventCopyWith<TaskCreationEvent> get copyWith => _$TaskCreationEventCopyWithImpl<TaskCreationEvent>(this as TaskCreationEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskCreationEvent&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'TaskCreationEvent(form: $form)';
}


}

/// @nodoc
abstract mixin class $TaskCreationEventCopyWith<$Res>  {
  factory $TaskCreationEventCopyWith(TaskCreationEvent value, $Res Function(TaskCreationEvent) _then) = _$TaskCreationEventCopyWithImpl;
@useResult
$Res call({
 TaskCreateForm form
});




}
/// @nodoc
class _$TaskCreationEventCopyWithImpl<$Res>
    implements $TaskCreationEventCopyWith<$Res> {
  _$TaskCreationEventCopyWithImpl(this._self, this._then);

  final TaskCreationEvent _self;
  final $Res Function(TaskCreationEvent) _then;

/// Create a copy of TaskCreationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? form = null,}) {
  return _then(_self.copyWith(
form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as TaskCreateForm,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskCreationEvent].
extension TaskCreationEventPatterns on TaskCreationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SubmittedTaskCreationEvent value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmittedTaskCreationEvent() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SubmittedTaskCreationEvent value)  submitted,}){
final _that = this;
switch (_that) {
case _SubmittedTaskCreationEvent():
return submitted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SubmittedTaskCreationEvent value)?  submitted,}){
final _that = this;
switch (_that) {
case _SubmittedTaskCreationEvent() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( TaskCreateForm form)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmittedTaskCreationEvent() when submitted != null:
return submitted(_that.form);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( TaskCreateForm form)  submitted,}) {final _that = this;
switch (_that) {
case _SubmittedTaskCreationEvent():
return submitted(_that.form);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( TaskCreateForm form)?  submitted,}) {final _that = this;
switch (_that) {
case _SubmittedTaskCreationEvent() when submitted != null:
return submitted(_that.form);case _:
  return null;

}
}

}

/// @nodoc


class _SubmittedTaskCreationEvent implements TaskCreationEvent {
  const _SubmittedTaskCreationEvent(this.form);
  

@override final  TaskCreateForm form;

/// Create a copy of TaskCreationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedTaskCreationEventCopyWith<_SubmittedTaskCreationEvent> get copyWith => __$SubmittedTaskCreationEventCopyWithImpl<_SubmittedTaskCreationEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmittedTaskCreationEvent&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'TaskCreationEvent.submitted(form: $form)';
}


}

/// @nodoc
abstract mixin class _$SubmittedTaskCreationEventCopyWith<$Res> implements $TaskCreationEventCopyWith<$Res> {
  factory _$SubmittedTaskCreationEventCopyWith(_SubmittedTaskCreationEvent value, $Res Function(_SubmittedTaskCreationEvent) _then) = __$SubmittedTaskCreationEventCopyWithImpl;
@override @useResult
$Res call({
 TaskCreateForm form
});




}
/// @nodoc
class __$SubmittedTaskCreationEventCopyWithImpl<$Res>
    implements _$SubmittedTaskCreationEventCopyWith<$Res> {
  __$SubmittedTaskCreationEventCopyWithImpl(this._self, this._then);

  final _SubmittedTaskCreationEvent _self;
  final $Res Function(_SubmittedTaskCreationEvent) _then;

/// Create a copy of TaskCreationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? form = null,}) {
  return _then(_SubmittedTaskCreationEvent(
null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as TaskCreateForm,
  ));
}


}

/// @nodoc
mixin _$TaskCreationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskCreationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskCreationState()';
}


}

/// @nodoc
class $TaskCreationStateCopyWith<$Res>  {
$TaskCreationStateCopyWith(TaskCreationState _, $Res Function(TaskCreationState) __);
}


/// Adds pattern-matching-related methods to [TaskCreationState].
extension TaskCreationStatePatterns on TaskCreationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialTaskCreationState value)?  initial,TResult Function( LoadingTaskCreationState value)?  loading,TResult Function( SuccessTaskCreationState value)?  success,TResult Function( FailureTaskCreationState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialTaskCreationState() when initial != null:
return initial(_that);case LoadingTaskCreationState() when loading != null:
return loading(_that);case SuccessTaskCreationState() when success != null:
return success(_that);case FailureTaskCreationState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialTaskCreationState value)  initial,required TResult Function( LoadingTaskCreationState value)  loading,required TResult Function( SuccessTaskCreationState value)  success,required TResult Function( FailureTaskCreationState value)  failure,}){
final _that = this;
switch (_that) {
case InitialTaskCreationState():
return initial(_that);case LoadingTaskCreationState():
return loading(_that);case SuccessTaskCreationState():
return success(_that);case FailureTaskCreationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialTaskCreationState value)?  initial,TResult? Function( LoadingTaskCreationState value)?  loading,TResult? Function( SuccessTaskCreationState value)?  success,TResult? Function( FailureTaskCreationState value)?  failure,}){
final _that = this;
switch (_that) {
case InitialTaskCreationState() when initial != null:
return initial(_that);case LoadingTaskCreationState() when loading != null:
return loading(_that);case SuccessTaskCreationState() when success != null:
return success(_that);case FailureTaskCreationState() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Task task)?  success,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialTaskCreationState() when initial != null:
return initial();case LoadingTaskCreationState() when loading != null:
return loading();case SuccessTaskCreationState() when success != null:
return success(_that.task);case FailureTaskCreationState() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Task task)  success,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case InitialTaskCreationState():
return initial();case LoadingTaskCreationState():
return loading();case SuccessTaskCreationState():
return success(_that.task);case FailureTaskCreationState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Task task)?  success,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case InitialTaskCreationState() when initial != null:
return initial();case LoadingTaskCreationState() when loading != null:
return loading();case SuccessTaskCreationState() when success != null:
return success(_that.task);case FailureTaskCreationState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialTaskCreationState extends TaskCreationState {
  const InitialTaskCreationState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTaskCreationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskCreationState.initial()';
}


}

/// @nodoc
class $InitialTaskCreationStateCopyWith<$Res> implements $TaskCreationStateCopyWith<$Res> {
$InitialTaskCreationStateCopyWith(InitialTaskCreationState _, $Res Function(InitialTaskCreationState) __);
}
/// @nodoc
class _$InitialTaskCreationStateCopyWithImpl<$Res>
    implements $InitialTaskCreationStateCopyWith<$Res> {
  _$InitialTaskCreationStateCopyWithImpl(this._self, this._then);

  final InitialTaskCreationState _self;
  final $Res Function(InitialTaskCreationState) _then;




}

/// @nodoc


class LoadingTaskCreationState extends TaskCreationState {
  const LoadingTaskCreationState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTaskCreationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskCreationState.loading()';
}


}

/// @nodoc
class $LoadingTaskCreationStateCopyWith<$Res> implements $TaskCreationStateCopyWith<$Res> {
$LoadingTaskCreationStateCopyWith(LoadingTaskCreationState _, $Res Function(LoadingTaskCreationState) __);
}
/// @nodoc
class _$LoadingTaskCreationStateCopyWithImpl<$Res>
    implements $LoadingTaskCreationStateCopyWith<$Res> {
  _$LoadingTaskCreationStateCopyWithImpl(this._self, this._then);

  final LoadingTaskCreationState _self;
  final $Res Function(LoadingTaskCreationState) _then;




}

/// @nodoc


class SuccessTaskCreationState extends TaskCreationState {
  const SuccessTaskCreationState(this.task): super._();
  

 final  Task task;

/// Create a copy of TaskCreationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessTaskCreationStateCopyWith<SuccessTaskCreationState> get copyWith => _$SuccessTaskCreationStateCopyWithImpl<SuccessTaskCreationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessTaskCreationState&&(identical(other.task, task) || other.task == task));
}


@override
int get hashCode => Object.hash(runtimeType,task);

@override
String toString() {
  return 'TaskCreationState.success(task: $task)';
}


}

/// @nodoc
abstract mixin class $SuccessTaskCreationStateCopyWith<$Res> implements $TaskCreationStateCopyWith<$Res> {
  factory $SuccessTaskCreationStateCopyWith(SuccessTaskCreationState value, $Res Function(SuccessTaskCreationState) _then) = _$SuccessTaskCreationStateCopyWithImpl;
@useResult
$Res call({
 Task task
});


$TaskCopyWith<$Res> get task;

}
/// @nodoc
class _$SuccessTaskCreationStateCopyWithImpl<$Res>
    implements $SuccessTaskCreationStateCopyWith<$Res> {
  _$SuccessTaskCreationStateCopyWithImpl(this._self, this._then);

  final SuccessTaskCreationState _self;
  final $Res Function(SuccessTaskCreationState) _then;

/// Create a copy of TaskCreationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? task = null,}) {
  return _then(SuccessTaskCreationState(
null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as Task,
  ));
}

/// Create a copy of TaskCreationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res> get task {
  
  return $TaskCopyWith<$Res>(_self.task, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}

/// @nodoc


class FailureTaskCreationState extends TaskCreationState {
  const FailureTaskCreationState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of TaskCreationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureTaskCreationStateCopyWith<FailureTaskCreationState> get copyWith => _$FailureTaskCreationStateCopyWithImpl<FailureTaskCreationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureTaskCreationState&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'TaskCreationState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureTaskCreationStateCopyWith<$Res> implements $TaskCreationStateCopyWith<$Res> {
  factory $FailureTaskCreationStateCopyWith(FailureTaskCreationState value, $Res Function(FailureTaskCreationState) _then) = _$FailureTaskCreationStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureTaskCreationStateCopyWithImpl<$Res>
    implements $FailureTaskCreationStateCopyWith<$Res> {
  _$FailureTaskCreationStateCopyWithImpl(this._self, this._then);

  final FailureTaskCreationState _self;
  final $Res Function(FailureTaskCreationState) _then;

/// Create a copy of TaskCreationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureTaskCreationState(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
