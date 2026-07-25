// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarEvent()';
}


}

/// @nodoc
class $CalendarEventCopyWith<$Res>  {
$CalendarEventCopyWith(CalendarEvent _, $Res Function(CalendarEvent) __);
}


/// Adds pattern-matching-related methods to [CalendarEvent].
extension CalendarEventPatterns on CalendarEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DateSelectedCalendarEvent value)?  dateSelected,TResult Function( _RefreshedCalendarEvent value)?  refreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DateSelectedCalendarEvent() when dateSelected != null:
return dateSelected(_that);case _RefreshedCalendarEvent() when refreshed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DateSelectedCalendarEvent value)  dateSelected,required TResult Function( _RefreshedCalendarEvent value)  refreshed,}){
final _that = this;
switch (_that) {
case _DateSelectedCalendarEvent():
return dateSelected(_that);case _RefreshedCalendarEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DateSelectedCalendarEvent value)?  dateSelected,TResult? Function( _RefreshedCalendarEvent value)?  refreshed,}){
final _that = this;
switch (_that) {
case _DateSelectedCalendarEvent() when dateSelected != null:
return dateSelected(_that);case _RefreshedCalendarEvent() when refreshed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateTime date)?  dateSelected,TResult Function()?  refreshed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DateSelectedCalendarEvent() when dateSelected != null:
return dateSelected(_that.date);case _RefreshedCalendarEvent() when refreshed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateTime date)  dateSelected,required TResult Function()  refreshed,}) {final _that = this;
switch (_that) {
case _DateSelectedCalendarEvent():
return dateSelected(_that.date);case _RefreshedCalendarEvent():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateTime date)?  dateSelected,TResult? Function()?  refreshed,}) {final _that = this;
switch (_that) {
case _DateSelectedCalendarEvent() when dateSelected != null:
return dateSelected(_that.date);case _RefreshedCalendarEvent() when refreshed != null:
return refreshed();case _:
  return null;

}
}

}

/// @nodoc


class _DateSelectedCalendarEvent implements CalendarEvent {
  const _DateSelectedCalendarEvent(this.date);
  

 final  DateTime date;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateSelectedCalendarEventCopyWith<_DateSelectedCalendarEvent> get copyWith => __$DateSelectedCalendarEventCopyWithImpl<_DateSelectedCalendarEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateSelectedCalendarEvent&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'CalendarEvent.dateSelected(date: $date)';
}


}

/// @nodoc
abstract mixin class _$DateSelectedCalendarEventCopyWith<$Res> implements $CalendarEventCopyWith<$Res> {
  factory _$DateSelectedCalendarEventCopyWith(_DateSelectedCalendarEvent value, $Res Function(_DateSelectedCalendarEvent) _then) = __$DateSelectedCalendarEventCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class __$DateSelectedCalendarEventCopyWithImpl<$Res>
    implements _$DateSelectedCalendarEventCopyWith<$Res> {
  __$DateSelectedCalendarEventCopyWithImpl(this._self, this._then);

  final _DateSelectedCalendarEvent _self;
  final $Res Function(_DateSelectedCalendarEvent) _then;

/// Create a copy of CalendarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(_DateSelectedCalendarEvent(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class _RefreshedCalendarEvent implements CalendarEvent {
  const _RefreshedCalendarEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshedCalendarEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarEvent.refreshed()';
}


}

/// @nodoc
class _$RefreshedCalendarEventCopyWith<$Res> implements $CalendarEventCopyWith<$Res> {
_$RefreshedCalendarEventCopyWith(_RefreshedCalendarEvent _, $Res Function(_RefreshedCalendarEvent) __);
}
/// @nodoc
class __$RefreshedCalendarEventCopyWithImpl<$Res>
    implements _$RefreshedCalendarEventCopyWith<$Res> {
  __$RefreshedCalendarEventCopyWithImpl(this._self, this._then);

  final _RefreshedCalendarEvent _self;
  final $Res Function(_RefreshedCalendarEvent) _then;




}

/// @nodoc
mixin _$CalendarStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarStatus()';
}


}

/// @nodoc
class $CalendarStatusCopyWith<$Res>  {
$CalendarStatusCopyWith(CalendarStatus _, $Res Function(CalendarStatus) __);
}


/// Adds pattern-matching-related methods to [CalendarStatus].
extension CalendarStatusPatterns on CalendarStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialCalendarStatus value)?  initial,TResult Function( LoadingCalendarStatus value)?  loading,TResult Function( SuccessCalendarStatus value)?  success,TResult Function( FailureCalendarStatus value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialCalendarStatus() when initial != null:
return initial(_that);case LoadingCalendarStatus() when loading != null:
return loading(_that);case SuccessCalendarStatus() when success != null:
return success(_that);case FailureCalendarStatus() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialCalendarStatus value)  initial,required TResult Function( LoadingCalendarStatus value)  loading,required TResult Function( SuccessCalendarStatus value)  success,required TResult Function( FailureCalendarStatus value)  failure,}){
final _that = this;
switch (_that) {
case InitialCalendarStatus():
return initial(_that);case LoadingCalendarStatus():
return loading(_that);case SuccessCalendarStatus():
return success(_that);case FailureCalendarStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialCalendarStatus value)?  initial,TResult? Function( LoadingCalendarStatus value)?  loading,TResult? Function( SuccessCalendarStatus value)?  success,TResult? Function( FailureCalendarStatus value)?  failure,}){
final _that = this;
switch (_that) {
case InitialCalendarStatus() when initial != null:
return initial(_that);case LoadingCalendarStatus() when loading != null:
return loading(_that);case SuccessCalendarStatus() when success != null:
return success(_that);case FailureCalendarStatus() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Task> tasks)?  success,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialCalendarStatus() when initial != null:
return initial();case LoadingCalendarStatus() when loading != null:
return loading();case SuccessCalendarStatus() when success != null:
return success(_that.tasks);case FailureCalendarStatus() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Task> tasks)  success,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case InitialCalendarStatus():
return initial();case LoadingCalendarStatus():
return loading();case SuccessCalendarStatus():
return success(_that.tasks);case FailureCalendarStatus():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Task> tasks)?  success,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case InitialCalendarStatus() when initial != null:
return initial();case LoadingCalendarStatus() when loading != null:
return loading();case SuccessCalendarStatus() when success != null:
return success(_that.tasks);case FailureCalendarStatus() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialCalendarStatus implements CalendarStatus {
  const InitialCalendarStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialCalendarStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarStatus.initial()';
}


}

/// @nodoc
class $InitialCalendarStatusCopyWith<$Res> implements $CalendarStatusCopyWith<$Res> {
$InitialCalendarStatusCopyWith(InitialCalendarStatus _, $Res Function(InitialCalendarStatus) __);
}
/// @nodoc
class _$InitialCalendarStatusCopyWithImpl<$Res>
    implements $InitialCalendarStatusCopyWith<$Res> {
  _$InitialCalendarStatusCopyWithImpl(this._self, this._then);

  final InitialCalendarStatus _self;
  final $Res Function(InitialCalendarStatus) _then;




}

/// @nodoc


class LoadingCalendarStatus implements CalendarStatus {
  const LoadingCalendarStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingCalendarStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CalendarStatus.loading()';
}


}

/// @nodoc
class $LoadingCalendarStatusCopyWith<$Res> implements $CalendarStatusCopyWith<$Res> {
$LoadingCalendarStatusCopyWith(LoadingCalendarStatus _, $Res Function(LoadingCalendarStatus) __);
}
/// @nodoc
class _$LoadingCalendarStatusCopyWithImpl<$Res>
    implements $LoadingCalendarStatusCopyWith<$Res> {
  _$LoadingCalendarStatusCopyWithImpl(this._self, this._then);

  final LoadingCalendarStatus _self;
  final $Res Function(LoadingCalendarStatus) _then;




}

/// @nodoc


class SuccessCalendarStatus implements CalendarStatus {
  const SuccessCalendarStatus({required this.tasks});
  

 final  List<Task> tasks;

/// Create a copy of CalendarStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCalendarStatusCopyWith<SuccessCalendarStatus> get copyWith => _$SuccessCalendarStatusCopyWithImpl<SuccessCalendarStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessCalendarStatus&&const DeepCollectionEquality().equals(other.tasks, tasks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'CalendarStatus.success(tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $SuccessCalendarStatusCopyWith<$Res> implements $CalendarStatusCopyWith<$Res> {
  factory $SuccessCalendarStatusCopyWith(SuccessCalendarStatus value, $Res Function(SuccessCalendarStatus) _then) = _$SuccessCalendarStatusCopyWithImpl;
@useResult
$Res call({
 List<Task> tasks
});




}
/// @nodoc
class _$SuccessCalendarStatusCopyWithImpl<$Res>
    implements $SuccessCalendarStatusCopyWith<$Res> {
  _$SuccessCalendarStatusCopyWithImpl(this._self, this._then);

  final SuccessCalendarStatus _self;
  final $Res Function(SuccessCalendarStatus) _then;

/// Create a copy of CalendarStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tasks = null,}) {
  return _then(SuccessCalendarStatus(
tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,
  ));
}


}

/// @nodoc


class FailureCalendarStatus implements CalendarStatus {
  const FailureCalendarStatus({required this.exception});
  

 final  AppException exception;

/// Create a copy of CalendarStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCalendarStatusCopyWith<FailureCalendarStatus> get copyWith => _$FailureCalendarStatusCopyWithImpl<FailureCalendarStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureCalendarStatus&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'CalendarStatus.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureCalendarStatusCopyWith<$Res> implements $CalendarStatusCopyWith<$Res> {
  factory $FailureCalendarStatusCopyWith(FailureCalendarStatus value, $Res Function(FailureCalendarStatus) _then) = _$FailureCalendarStatusCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureCalendarStatusCopyWithImpl<$Res>
    implements $FailureCalendarStatusCopyWith<$Res> {
  _$FailureCalendarStatusCopyWithImpl(this._self, this._then);

  final FailureCalendarStatus _self;
  final $Res Function(FailureCalendarStatus) _then;

/// Create a copy of CalendarStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureCalendarStatus(
exception: null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

/// @nodoc
mixin _$CalendarState {

 DateTime get selectedDate; CalendarStatus get status;
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateCopyWith<CalendarState> get copyWith => _$CalendarStateCopyWithImpl<CalendarState>(this as CalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate,status);

@override
String toString() {
  return 'CalendarState(selectedDate: $selectedDate, status: $status)';
}


}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res>  {
  factory $CalendarStateCopyWith(CalendarState value, $Res Function(CalendarState) _then) = _$CalendarStateCopyWithImpl;
@useResult
$Res call({
 DateTime selectedDate, CalendarStatus status
});


$CalendarStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedDate = null,Object? status = null,}) {
  return _then(_self.copyWith(
selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CalendarStatus,
  ));
}
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarStatusCopyWith<$Res> get status {
  
  return $CalendarStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalendarState].
extension CalendarStatePatterns on CalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarState value)  $default,){
final _that = this;
switch (_that) {
case _CalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime selectedDate,  CalendarStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.selectedDate,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime selectedDate,  CalendarStatus status)  $default,) {final _that = this;
switch (_that) {
case _CalendarState():
return $default(_that.selectedDate,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime selectedDate,  CalendarStatus status)?  $default,) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.selectedDate,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarState extends CalendarState {
  const _CalendarState({required this.selectedDate, required this.status}): super._();
  

@override final  DateTime selectedDate;
@override final  CalendarStatus status;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarStateCopyWith<_CalendarState> get copyWith => __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate,status);

@override
String toString() {
  return 'CalendarState(selectedDate: $selectedDate, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(_CalendarState value, $Res Function(_CalendarState) _then) = __$CalendarStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime selectedDate, CalendarStatus status
});


@override $CalendarStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedDate = null,Object? status = null,}) {
  return _then(_CalendarState(
selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CalendarStatus,
  ));
}

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarStatusCopyWith<$Res> get status {
  
  return $CalendarStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
