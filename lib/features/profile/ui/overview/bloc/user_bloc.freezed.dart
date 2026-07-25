// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent()';
}


}

/// @nodoc
class $UserEventCopyWith<$Res>  {
$UserEventCopyWith(UserEvent _, $Res Function(UserEvent) __);
}


/// Adds pattern-matching-related methods to [UserEvent].
extension UserEventPatterns on UserEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RequestedUserEvent value)?  requested,TResult Function( _UpdatedUserEvent value)?  updated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestedUserEvent() when requested != null:
return requested(_that);case _UpdatedUserEvent() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RequestedUserEvent value)  requested,required TResult Function( _UpdatedUserEvent value)  updated,}){
final _that = this;
switch (_that) {
case _RequestedUserEvent():
return requested(_that);case _UpdatedUserEvent():
return updated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RequestedUserEvent value)?  requested,TResult? Function( _UpdatedUserEvent value)?  updated,}){
final _that = this;
switch (_that) {
case _RequestedUserEvent() when requested != null:
return requested(_that);case _UpdatedUserEvent() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  requested,TResult Function( User user)?  updated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestedUserEvent() when requested != null:
return requested();case _UpdatedUserEvent() when updated != null:
return updated(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  requested,required TResult Function( User user)  updated,}) {final _that = this;
switch (_that) {
case _RequestedUserEvent():
return requested();case _UpdatedUserEvent():
return updated(_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  requested,TResult? Function( User user)?  updated,}) {final _that = this;
switch (_that) {
case _RequestedUserEvent() when requested != null:
return requested();case _UpdatedUserEvent() when updated != null:
return updated(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _RequestedUserEvent implements UserEvent {
  const _RequestedUserEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestedUserEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent.requested()';
}


}

/// @nodoc
class _$RequestedUserEventCopyWith<$Res> implements $UserEventCopyWith<$Res> {
_$RequestedUserEventCopyWith(_RequestedUserEvent _, $Res Function(_RequestedUserEvent) __);
}
/// @nodoc
class __$RequestedUserEventCopyWithImpl<$Res>
    implements _$RequestedUserEventCopyWith<$Res> {
  __$RequestedUserEventCopyWithImpl(this._self, this._then);

  final _RequestedUserEvent _self;
  final $Res Function(_RequestedUserEvent) _then;




}

/// @nodoc


class _UpdatedUserEvent implements UserEvent {
  const _UpdatedUserEvent(this.user);
  

 final  User user;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatedUserEventCopyWith<_UpdatedUserEvent> get copyWith => __$UpdatedUserEventCopyWithImpl<_UpdatedUserEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatedUserEvent&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'UserEvent.updated(user: $user)';
}


}

/// @nodoc
abstract mixin class _$UpdatedUserEventCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory _$UpdatedUserEventCopyWith(_UpdatedUserEvent value, $Res Function(_UpdatedUserEvent) _then) = __$UpdatedUserEventCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class __$UpdatedUserEventCopyWithImpl<$Res>
    implements _$UpdatedUserEventCopyWith<$Res> {
  __$UpdatedUserEventCopyWithImpl(this._self, this._then);

  final _UpdatedUserEvent _self;
  final $Res Function(_UpdatedUserEvent) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_UpdatedUserEvent(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc
mixin _$UserState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState()';
}


}

/// @nodoc
class $UserStateCopyWith<$Res>  {
$UserStateCopyWith(UserState _, $Res Function(UserState) __);
}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialUserState value)?  initial,TResult Function( LoadingUserState value)?  loading,TResult Function( SuccessUserState value)?  success,TResult Function( FailureUserState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialUserState() when initial != null:
return initial(_that);case LoadingUserState() when loading != null:
return loading(_that);case SuccessUserState() when success != null:
return success(_that);case FailureUserState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialUserState value)  initial,required TResult Function( LoadingUserState value)  loading,required TResult Function( SuccessUserState value)  success,required TResult Function( FailureUserState value)  failure,}){
final _that = this;
switch (_that) {
case InitialUserState():
return initial(_that);case LoadingUserState():
return loading(_that);case SuccessUserState():
return success(_that);case FailureUserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialUserState value)?  initial,TResult? Function( LoadingUserState value)?  loading,TResult? Function( SuccessUserState value)?  success,TResult? Function( FailureUserState value)?  failure,}){
final _that = this;
switch (_that) {
case InitialUserState() when initial != null:
return initial(_that);case LoadingUserState() when loading != null:
return loading(_that);case SuccessUserState() when success != null:
return success(_that);case FailureUserState() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( User user)?  success,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialUserState() when initial != null:
return initial();case LoadingUserState() when loading != null:
return loading();case SuccessUserState() when success != null:
return success(_that.user);case FailureUserState() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( User user)  success,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case InitialUserState():
return initial();case LoadingUserState():
return loading();case SuccessUserState():
return success(_that.user);case FailureUserState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( User user)?  success,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case InitialUserState() when initial != null:
return initial();case LoadingUserState() when loading != null:
return loading();case SuccessUserState() when success != null:
return success(_that.user);case FailureUserState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialUserState extends UserState {
  const InitialUserState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialUserState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.initial()';
}


}

/// @nodoc
class $InitialUserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
$InitialUserStateCopyWith(InitialUserState _, $Res Function(InitialUserState) __);
}
/// @nodoc
class _$InitialUserStateCopyWithImpl<$Res>
    implements $InitialUserStateCopyWith<$Res> {
  _$InitialUserStateCopyWithImpl(this._self, this._then);

  final InitialUserState _self;
  final $Res Function(InitialUserState) _then;




}

/// @nodoc


class LoadingUserState extends UserState {
  const LoadingUserState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingUserState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.loading()';
}


}

/// @nodoc
class $LoadingUserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
$LoadingUserStateCopyWith(LoadingUserState _, $Res Function(LoadingUserState) __);
}
/// @nodoc
class _$LoadingUserStateCopyWithImpl<$Res>
    implements $LoadingUserStateCopyWith<$Res> {
  _$LoadingUserStateCopyWithImpl(this._self, this._then);

  final LoadingUserState _self;
  final $Res Function(LoadingUserState) _then;




}

/// @nodoc


class SuccessUserState extends UserState {
  const SuccessUserState(this.user): super._();
  

 final  User user;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessUserStateCopyWith<SuccessUserState> get copyWith => _$SuccessUserStateCopyWithImpl<SuccessUserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessUserState&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'UserState.success(user: $user)';
}


}

/// @nodoc
abstract mixin class $SuccessUserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $SuccessUserStateCopyWith(SuccessUserState value, $Res Function(SuccessUserState) _then) = _$SuccessUserStateCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$SuccessUserStateCopyWithImpl<$Res>
    implements $SuccessUserStateCopyWith<$Res> {
  _$SuccessUserStateCopyWithImpl(this._self, this._then);

  final SuccessUserState _self;
  final $Res Function(SuccessUserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(SuccessUserState(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class FailureUserState extends UserState {
  const FailureUserState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureUserStateCopyWith<FailureUserState> get copyWith => _$FailureUserStateCopyWithImpl<FailureUserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureUserState&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'UserState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureUserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $FailureUserStateCopyWith(FailureUserState value, $Res Function(FailureUserState) _then) = _$FailureUserStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureUserStateCopyWithImpl<$Res>
    implements $FailureUserStateCopyWith<$Res> {
  _$FailureUserStateCopyWithImpl(this._self, this._then);

  final FailureUserState _self;
  final $Res Function(FailureUserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureUserState(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
