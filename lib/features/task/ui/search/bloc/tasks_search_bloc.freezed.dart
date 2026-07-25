// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasksSearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksSearchEvent()';
}


}

/// @nodoc
class $TasksSearchEventCopyWith<$Res>  {
$TasksSearchEventCopyWith(TasksSearchEvent _, $Res Function(TasksSearchEvent) __);
}


/// Adds pattern-matching-related methods to [TasksSearchEvent].
extension TasksSearchEventPatterns on TasksSearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _QueryChangedTasksSearchEvent value)?  queryChanged,TResult Function( _QuerySubmittedTasksSearchEvent value)?  querySubmitted,TResult Function( _RefreshedTasksSearchEvent value)?  refreshed,TResult Function( _LoadMoreRequestedTasksSearchEvent value)?  loadMoreRequested,TResult Function( _RecentClearedTasksSearchEvent value)?  recentCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryChangedTasksSearchEvent() when queryChanged != null:
return queryChanged(_that);case _QuerySubmittedTasksSearchEvent() when querySubmitted != null:
return querySubmitted(_that);case _RefreshedTasksSearchEvent() when refreshed != null:
return refreshed(_that);case _LoadMoreRequestedTasksSearchEvent() when loadMoreRequested != null:
return loadMoreRequested(_that);case _RecentClearedTasksSearchEvent() when recentCleared != null:
return recentCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _QueryChangedTasksSearchEvent value)  queryChanged,required TResult Function( _QuerySubmittedTasksSearchEvent value)  querySubmitted,required TResult Function( _RefreshedTasksSearchEvent value)  refreshed,required TResult Function( _LoadMoreRequestedTasksSearchEvent value)  loadMoreRequested,required TResult Function( _RecentClearedTasksSearchEvent value)  recentCleared,}){
final _that = this;
switch (_that) {
case _QueryChangedTasksSearchEvent():
return queryChanged(_that);case _QuerySubmittedTasksSearchEvent():
return querySubmitted(_that);case _RefreshedTasksSearchEvent():
return refreshed(_that);case _LoadMoreRequestedTasksSearchEvent():
return loadMoreRequested(_that);case _RecentClearedTasksSearchEvent():
return recentCleared(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _QueryChangedTasksSearchEvent value)?  queryChanged,TResult? Function( _QuerySubmittedTasksSearchEvent value)?  querySubmitted,TResult? Function( _RefreshedTasksSearchEvent value)?  refreshed,TResult? Function( _LoadMoreRequestedTasksSearchEvent value)?  loadMoreRequested,TResult? Function( _RecentClearedTasksSearchEvent value)?  recentCleared,}){
final _that = this;
switch (_that) {
case _QueryChangedTasksSearchEvent() when queryChanged != null:
return queryChanged(_that);case _QuerySubmittedTasksSearchEvent() when querySubmitted != null:
return querySubmitted(_that);case _RefreshedTasksSearchEvent() when refreshed != null:
return refreshed(_that);case _LoadMoreRequestedTasksSearchEvent() when loadMoreRequested != null:
return loadMoreRequested(_that);case _RecentClearedTasksSearchEvent() when recentCleared != null:
return recentCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  queryChanged,TResult Function( String query)?  querySubmitted,TResult Function()?  refreshed,TResult Function()?  loadMoreRequested,TResult Function()?  recentCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryChangedTasksSearchEvent() when queryChanged != null:
return queryChanged(_that.query);case _QuerySubmittedTasksSearchEvent() when querySubmitted != null:
return querySubmitted(_that.query);case _RefreshedTasksSearchEvent() when refreshed != null:
return refreshed();case _LoadMoreRequestedTasksSearchEvent() when loadMoreRequested != null:
return loadMoreRequested();case _RecentClearedTasksSearchEvent() when recentCleared != null:
return recentCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  queryChanged,required TResult Function( String query)  querySubmitted,required TResult Function()  refreshed,required TResult Function()  loadMoreRequested,required TResult Function()  recentCleared,}) {final _that = this;
switch (_that) {
case _QueryChangedTasksSearchEvent():
return queryChanged(_that.query);case _QuerySubmittedTasksSearchEvent():
return querySubmitted(_that.query);case _RefreshedTasksSearchEvent():
return refreshed();case _LoadMoreRequestedTasksSearchEvent():
return loadMoreRequested();case _RecentClearedTasksSearchEvent():
return recentCleared();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  queryChanged,TResult? Function( String query)?  querySubmitted,TResult? Function()?  refreshed,TResult? Function()?  loadMoreRequested,TResult? Function()?  recentCleared,}) {final _that = this;
switch (_that) {
case _QueryChangedTasksSearchEvent() when queryChanged != null:
return queryChanged(_that.query);case _QuerySubmittedTasksSearchEvent() when querySubmitted != null:
return querySubmitted(_that.query);case _RefreshedTasksSearchEvent() when refreshed != null:
return refreshed();case _LoadMoreRequestedTasksSearchEvent() when loadMoreRequested != null:
return loadMoreRequested();case _RecentClearedTasksSearchEvent() when recentCleared != null:
return recentCleared();case _:
  return null;

}
}

}

/// @nodoc


class _QueryChangedTasksSearchEvent implements TasksSearchEvent {
  const _QueryChangedTasksSearchEvent(this.query);
  

 final  String query;

/// Create a copy of TasksSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryChangedTasksSearchEventCopyWith<_QueryChangedTasksSearchEvent> get copyWith => __$QueryChangedTasksSearchEventCopyWithImpl<_QueryChangedTasksSearchEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryChangedTasksSearchEvent&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'TasksSearchEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$QueryChangedTasksSearchEventCopyWith<$Res> implements $TasksSearchEventCopyWith<$Res> {
  factory _$QueryChangedTasksSearchEventCopyWith(_QueryChangedTasksSearchEvent value, $Res Function(_QueryChangedTasksSearchEvent) _then) = __$QueryChangedTasksSearchEventCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$QueryChangedTasksSearchEventCopyWithImpl<$Res>
    implements _$QueryChangedTasksSearchEventCopyWith<$Res> {
  __$QueryChangedTasksSearchEventCopyWithImpl(this._self, this._then);

  final _QueryChangedTasksSearchEvent _self;
  final $Res Function(_QueryChangedTasksSearchEvent) _then;

/// Create a copy of TasksSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_QueryChangedTasksSearchEvent(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _QuerySubmittedTasksSearchEvent implements TasksSearchEvent {
  const _QuerySubmittedTasksSearchEvent(this.query);
  

 final  String query;

/// Create a copy of TasksSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuerySubmittedTasksSearchEventCopyWith<_QuerySubmittedTasksSearchEvent> get copyWith => __$QuerySubmittedTasksSearchEventCopyWithImpl<_QuerySubmittedTasksSearchEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuerySubmittedTasksSearchEvent&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'TasksSearchEvent.querySubmitted(query: $query)';
}


}

/// @nodoc
abstract mixin class _$QuerySubmittedTasksSearchEventCopyWith<$Res> implements $TasksSearchEventCopyWith<$Res> {
  factory _$QuerySubmittedTasksSearchEventCopyWith(_QuerySubmittedTasksSearchEvent value, $Res Function(_QuerySubmittedTasksSearchEvent) _then) = __$QuerySubmittedTasksSearchEventCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$QuerySubmittedTasksSearchEventCopyWithImpl<$Res>
    implements _$QuerySubmittedTasksSearchEventCopyWith<$Res> {
  __$QuerySubmittedTasksSearchEventCopyWithImpl(this._self, this._then);

  final _QuerySubmittedTasksSearchEvent _self;
  final $Res Function(_QuerySubmittedTasksSearchEvent) _then;

/// Create a copy of TasksSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_QuerySubmittedTasksSearchEvent(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RefreshedTasksSearchEvent implements TasksSearchEvent {
  const _RefreshedTasksSearchEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshedTasksSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksSearchEvent.refreshed()';
}


}

/// @nodoc
class _$RefreshedTasksSearchEventCopyWith<$Res> implements $TasksSearchEventCopyWith<$Res> {
_$RefreshedTasksSearchEventCopyWith(_RefreshedTasksSearchEvent _, $Res Function(_RefreshedTasksSearchEvent) __);
}
/// @nodoc
class __$RefreshedTasksSearchEventCopyWithImpl<$Res>
    implements _$RefreshedTasksSearchEventCopyWith<$Res> {
  __$RefreshedTasksSearchEventCopyWithImpl(this._self, this._then);

  final _RefreshedTasksSearchEvent _self;
  final $Res Function(_RefreshedTasksSearchEvent) _then;




}

/// @nodoc


class _LoadMoreRequestedTasksSearchEvent implements TasksSearchEvent {
  const _LoadMoreRequestedTasksSearchEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreRequestedTasksSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksSearchEvent.loadMoreRequested()';
}


}

/// @nodoc
class _$LoadMoreRequestedTasksSearchEventCopyWith<$Res> implements $TasksSearchEventCopyWith<$Res> {
_$LoadMoreRequestedTasksSearchEventCopyWith(_LoadMoreRequestedTasksSearchEvent _, $Res Function(_LoadMoreRequestedTasksSearchEvent) __);
}
/// @nodoc
class __$LoadMoreRequestedTasksSearchEventCopyWithImpl<$Res>
    implements _$LoadMoreRequestedTasksSearchEventCopyWith<$Res> {
  __$LoadMoreRequestedTasksSearchEventCopyWithImpl(this._self, this._then);

  final _LoadMoreRequestedTasksSearchEvent _self;
  final $Res Function(_LoadMoreRequestedTasksSearchEvent) _then;




}

/// @nodoc


class _RecentClearedTasksSearchEvent implements TasksSearchEvent {
  const _RecentClearedTasksSearchEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentClearedTasksSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksSearchEvent.recentCleared()';
}


}

/// @nodoc
class _$RecentClearedTasksSearchEventCopyWith<$Res> implements $TasksSearchEventCopyWith<$Res> {
_$RecentClearedTasksSearchEventCopyWith(_RecentClearedTasksSearchEvent _, $Res Function(_RecentClearedTasksSearchEvent) __);
}
/// @nodoc
class __$RecentClearedTasksSearchEventCopyWithImpl<$Res>
    implements _$RecentClearedTasksSearchEventCopyWith<$Res> {
  __$RecentClearedTasksSearchEventCopyWithImpl(this._self, this._then);

  final _RecentClearedTasksSearchEvent _self;
  final $Res Function(_RecentClearedTasksSearchEvent) _then;




}

/// @nodoc
mixin _$TasksSearchStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksSearchStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksSearchStatus()';
}


}

/// @nodoc
class $TasksSearchStatusCopyWith<$Res>  {
$TasksSearchStatusCopyWith(TasksSearchStatus _, $Res Function(TasksSearchStatus) __);
}


/// Adds pattern-matching-related methods to [TasksSearchStatus].
extension TasksSearchStatusPatterns on TasksSearchStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IdleTasksSearchStatus value)?  idle,TResult Function( LoadingTasksSearchStatus value)?  loading,TResult Function( SuggestionsTasksSearchStatus value)?  suggestions,TResult Function( ResultsTasksSearchStatus value)?  results,TResult Function( FailureTasksSearchStatus value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IdleTasksSearchStatus() when idle != null:
return idle(_that);case LoadingTasksSearchStatus() when loading != null:
return loading(_that);case SuggestionsTasksSearchStatus() when suggestions != null:
return suggestions(_that);case ResultsTasksSearchStatus() when results != null:
return results(_that);case FailureTasksSearchStatus() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IdleTasksSearchStatus value)  idle,required TResult Function( LoadingTasksSearchStatus value)  loading,required TResult Function( SuggestionsTasksSearchStatus value)  suggestions,required TResult Function( ResultsTasksSearchStatus value)  results,required TResult Function( FailureTasksSearchStatus value)  failure,}){
final _that = this;
switch (_that) {
case IdleTasksSearchStatus():
return idle(_that);case LoadingTasksSearchStatus():
return loading(_that);case SuggestionsTasksSearchStatus():
return suggestions(_that);case ResultsTasksSearchStatus():
return results(_that);case FailureTasksSearchStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IdleTasksSearchStatus value)?  idle,TResult? Function( LoadingTasksSearchStatus value)?  loading,TResult? Function( SuggestionsTasksSearchStatus value)?  suggestions,TResult? Function( ResultsTasksSearchStatus value)?  results,TResult? Function( FailureTasksSearchStatus value)?  failure,}){
final _that = this;
switch (_that) {
case IdleTasksSearchStatus() when idle != null:
return idle(_that);case LoadingTasksSearchStatus() when loading != null:
return loading(_that);case SuggestionsTasksSearchStatus() when suggestions != null:
return suggestions(_that);case ResultsTasksSearchStatus() when results != null:
return results(_that);case FailureTasksSearchStatus() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function( List<Task> tasks,  String query)?  suggestions,TResult Function( PaginatedData<Task> data,  String query,  BlocLoadState loadMoreState)?  results,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IdleTasksSearchStatus() when idle != null:
return idle();case LoadingTasksSearchStatus() when loading != null:
return loading();case SuggestionsTasksSearchStatus() when suggestions != null:
return suggestions(_that.tasks,_that.query);case ResultsTasksSearchStatus() when results != null:
return results(_that.data,_that.query,_that.loadMoreState);case FailureTasksSearchStatus() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function( List<Task> tasks,  String query)  suggestions,required TResult Function( PaginatedData<Task> data,  String query,  BlocLoadState loadMoreState)  results,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case IdleTasksSearchStatus():
return idle();case LoadingTasksSearchStatus():
return loading();case SuggestionsTasksSearchStatus():
return suggestions(_that.tasks,_that.query);case ResultsTasksSearchStatus():
return results(_that.data,_that.query,_that.loadMoreState);case FailureTasksSearchStatus():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function( List<Task> tasks,  String query)?  suggestions,TResult? Function( PaginatedData<Task> data,  String query,  BlocLoadState loadMoreState)?  results,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case IdleTasksSearchStatus() when idle != null:
return idle();case LoadingTasksSearchStatus() when loading != null:
return loading();case SuggestionsTasksSearchStatus() when suggestions != null:
return suggestions(_that.tasks,_that.query);case ResultsTasksSearchStatus() when results != null:
return results(_that.data,_that.query,_that.loadMoreState);case FailureTasksSearchStatus() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class IdleTasksSearchStatus implements TasksSearchStatus {
  const IdleTasksSearchStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IdleTasksSearchStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksSearchStatus.idle()';
}


}

/// @nodoc
class $IdleTasksSearchStatusCopyWith<$Res> implements $TasksSearchStatusCopyWith<$Res> {
$IdleTasksSearchStatusCopyWith(IdleTasksSearchStatus _, $Res Function(IdleTasksSearchStatus) __);
}
/// @nodoc
class _$IdleTasksSearchStatusCopyWithImpl<$Res>
    implements $IdleTasksSearchStatusCopyWith<$Res> {
  _$IdleTasksSearchStatusCopyWithImpl(this._self, this._then);

  final IdleTasksSearchStatus _self;
  final $Res Function(IdleTasksSearchStatus) _then;




}

/// @nodoc


class LoadingTasksSearchStatus implements TasksSearchStatus {
  const LoadingTasksSearchStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTasksSearchStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksSearchStatus.loading()';
}


}

/// @nodoc
class $LoadingTasksSearchStatusCopyWith<$Res> implements $TasksSearchStatusCopyWith<$Res> {
$LoadingTasksSearchStatusCopyWith(LoadingTasksSearchStatus _, $Res Function(LoadingTasksSearchStatus) __);
}
/// @nodoc
class _$LoadingTasksSearchStatusCopyWithImpl<$Res>
    implements $LoadingTasksSearchStatusCopyWith<$Res> {
  _$LoadingTasksSearchStatusCopyWithImpl(this._self, this._then);

  final LoadingTasksSearchStatus _self;
  final $Res Function(LoadingTasksSearchStatus) _then;




}

/// @nodoc


class SuggestionsTasksSearchStatus implements TasksSearchStatus {
  const SuggestionsTasksSearchStatus({required this.tasks, required this.query});
  

 final  List<Task> tasks;
 final  String query;

/// Create a copy of TasksSearchStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuggestionsTasksSearchStatusCopyWith<SuggestionsTasksSearchStatus> get copyWith => _$SuggestionsTasksSearchStatusCopyWithImpl<SuggestionsTasksSearchStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuggestionsTasksSearchStatus&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tasks),query);

@override
String toString() {
  return 'TasksSearchStatus.suggestions(tasks: $tasks, query: $query)';
}


}

/// @nodoc
abstract mixin class $SuggestionsTasksSearchStatusCopyWith<$Res> implements $TasksSearchStatusCopyWith<$Res> {
  factory $SuggestionsTasksSearchStatusCopyWith(SuggestionsTasksSearchStatus value, $Res Function(SuggestionsTasksSearchStatus) _then) = _$SuggestionsTasksSearchStatusCopyWithImpl;
@useResult
$Res call({
 List<Task> tasks, String query
});




}
/// @nodoc
class _$SuggestionsTasksSearchStatusCopyWithImpl<$Res>
    implements $SuggestionsTasksSearchStatusCopyWith<$Res> {
  _$SuggestionsTasksSearchStatusCopyWithImpl(this._self, this._then);

  final SuggestionsTasksSearchStatus _self;
  final $Res Function(SuggestionsTasksSearchStatus) _then;

/// Create a copy of TasksSearchStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tasks = null,Object? query = null,}) {
  return _then(SuggestionsTasksSearchStatus(
tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResultsTasksSearchStatus implements TasksSearchStatus {
  const ResultsTasksSearchStatus({required this.data, required this.query, this.loadMoreState = BlocLoadState.loaded});
  

 final  PaginatedData<Task> data;
 final  String query;
@JsonKey() final  BlocLoadState loadMoreState;

/// Create a copy of TasksSearchStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultsTasksSearchStatusCopyWith<ResultsTasksSearchStatus> get copyWith => _$ResultsTasksSearchStatusCopyWithImpl<ResultsTasksSearchStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultsTasksSearchStatus&&(identical(other.data, data) || other.data == data)&&(identical(other.query, query) || other.query == query)&&(identical(other.loadMoreState, loadMoreState) || other.loadMoreState == loadMoreState));
}


@override
int get hashCode => Object.hash(runtimeType,data,query,loadMoreState);

@override
String toString() {
  return 'TasksSearchStatus.results(data: $data, query: $query, loadMoreState: $loadMoreState)';
}


}

/// @nodoc
abstract mixin class $ResultsTasksSearchStatusCopyWith<$Res> implements $TasksSearchStatusCopyWith<$Res> {
  factory $ResultsTasksSearchStatusCopyWith(ResultsTasksSearchStatus value, $Res Function(ResultsTasksSearchStatus) _then) = _$ResultsTasksSearchStatusCopyWithImpl;
@useResult
$Res call({
 PaginatedData<Task> data, String query, BlocLoadState loadMoreState
});




}
/// @nodoc
class _$ResultsTasksSearchStatusCopyWithImpl<$Res>
    implements $ResultsTasksSearchStatusCopyWith<$Res> {
  _$ResultsTasksSearchStatusCopyWithImpl(this._self, this._then);

  final ResultsTasksSearchStatus _self;
  final $Res Function(ResultsTasksSearchStatus) _then;

/// Create a copy of TasksSearchStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? query = null,Object? loadMoreState = null,}) {
  return _then(ResultsTasksSearchStatus(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaginatedData<Task>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,loadMoreState: null == loadMoreState ? _self.loadMoreState : loadMoreState // ignore: cast_nullable_to_non_nullable
as BlocLoadState,
  ));
}


}

/// @nodoc


class FailureTasksSearchStatus implements TasksSearchStatus {
  const FailureTasksSearchStatus(this.exception);
  

 final  AppException exception;

/// Create a copy of TasksSearchStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureTasksSearchStatusCopyWith<FailureTasksSearchStatus> get copyWith => _$FailureTasksSearchStatusCopyWithImpl<FailureTasksSearchStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureTasksSearchStatus&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'TasksSearchStatus.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureTasksSearchStatusCopyWith<$Res> implements $TasksSearchStatusCopyWith<$Res> {
  factory $FailureTasksSearchStatusCopyWith(FailureTasksSearchStatus value, $Res Function(FailureTasksSearchStatus) _then) = _$FailureTasksSearchStatusCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureTasksSearchStatusCopyWithImpl<$Res>
    implements $FailureTasksSearchStatusCopyWith<$Res> {
  _$FailureTasksSearchStatusCopyWithImpl(this._self, this._then);

  final FailureTasksSearchStatus _self;
  final $Res Function(FailureTasksSearchStatus) _then;

/// Create a copy of TasksSearchStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureTasksSearchStatus(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

/// @nodoc
mixin _$TasksSearchState {

 TasksSearchStatus get status; String get query; List<String> get recentQueries;
/// Create a copy of TasksSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasksSearchStateCopyWith<TasksSearchState> get copyWith => _$TasksSearchStateCopyWithImpl<TasksSearchState>(this as TasksSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksSearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.recentQueries, recentQueries));
}


@override
int get hashCode => Object.hash(runtimeType,status,query,const DeepCollectionEquality().hash(recentQueries));

@override
String toString() {
  return 'TasksSearchState(status: $status, query: $query, recentQueries: $recentQueries)';
}


}

/// @nodoc
abstract mixin class $TasksSearchStateCopyWith<$Res>  {
  factory $TasksSearchStateCopyWith(TasksSearchState value, $Res Function(TasksSearchState) _then) = _$TasksSearchStateCopyWithImpl;
@useResult
$Res call({
 TasksSearchStatus status, String query, List<String> recentQueries
});


$TasksSearchStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$TasksSearchStateCopyWithImpl<$Res>
    implements $TasksSearchStateCopyWith<$Res> {
  _$TasksSearchStateCopyWithImpl(this._self, this._then);

  final TasksSearchState _self;
  final $Res Function(TasksSearchState) _then;

/// Create a copy of TasksSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? query = null,Object? recentQueries = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TasksSearchStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,recentQueries: null == recentQueries ? _self.recentQueries : recentQueries // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of TasksSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasksSearchStatusCopyWith<$Res> get status {
  
  return $TasksSearchStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [TasksSearchState].
extension TasksSearchStatePatterns on TasksSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TasksSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TasksSearchState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TasksSearchState value)  $default,){
final _that = this;
switch (_that) {
case _TasksSearchState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TasksSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _TasksSearchState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TasksSearchStatus status,  String query,  List<String> recentQueries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TasksSearchState() when $default != null:
return $default(_that.status,_that.query,_that.recentQueries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TasksSearchStatus status,  String query,  List<String> recentQueries)  $default,) {final _that = this;
switch (_that) {
case _TasksSearchState():
return $default(_that.status,_that.query,_that.recentQueries);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TasksSearchStatus status,  String query,  List<String> recentQueries)?  $default,) {final _that = this;
switch (_that) {
case _TasksSearchState() when $default != null:
return $default(_that.status,_that.query,_that.recentQueries);case _:
  return null;

}
}

}

/// @nodoc


class _TasksSearchState extends TasksSearchState {
  const _TasksSearchState({this.status = const TasksSearchStatus.idle(), this.query = '', this.recentQueries = const <String>[]}): super._();
  

@override@JsonKey() final  TasksSearchStatus status;
@override@JsonKey() final  String query;
@override@JsonKey() final  List<String> recentQueries;

/// Create a copy of TasksSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasksSearchStateCopyWith<_TasksSearchState> get copyWith => __$TasksSearchStateCopyWithImpl<_TasksSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasksSearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.recentQueries, recentQueries));
}


@override
int get hashCode => Object.hash(runtimeType,status,query,const DeepCollectionEquality().hash(recentQueries));

@override
String toString() {
  return 'TasksSearchState(status: $status, query: $query, recentQueries: $recentQueries)';
}


}

/// @nodoc
abstract mixin class _$TasksSearchStateCopyWith<$Res> implements $TasksSearchStateCopyWith<$Res> {
  factory _$TasksSearchStateCopyWith(_TasksSearchState value, $Res Function(_TasksSearchState) _then) = __$TasksSearchStateCopyWithImpl;
@override @useResult
$Res call({
 TasksSearchStatus status, String query, List<String> recentQueries
});


@override $TasksSearchStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$TasksSearchStateCopyWithImpl<$Res>
    implements _$TasksSearchStateCopyWith<$Res> {
  __$TasksSearchStateCopyWithImpl(this._self, this._then);

  final _TasksSearchState _self;
  final $Res Function(_TasksSearchState) _then;

/// Create a copy of TasksSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? query = null,Object? recentQueries = null,}) {
  return _then(_TasksSearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TasksSearchStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,recentQueries: null == recentQueries ? _self.recentQueries : recentQueries // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of TasksSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasksSearchStatusCopyWith<$Res> get status {
  
  return $TasksSearchStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
