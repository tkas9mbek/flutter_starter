// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InitializedAuthEvent value)?  initialized,TResult Function( _LogoutRequestedAuthEvent value)?  logoutRequested,TResult Function( _LoggedOutAuthEvent value)?  loggedOut,TResult Function( _SignedInAuthEvent value)?  signedIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitializedAuthEvent() when initialized != null:
return initialized(_that);case _LogoutRequestedAuthEvent() when logoutRequested != null:
return logoutRequested(_that);case _LoggedOutAuthEvent() when loggedOut != null:
return loggedOut(_that);case _SignedInAuthEvent() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InitializedAuthEvent value)  initialized,required TResult Function( _LogoutRequestedAuthEvent value)  logoutRequested,required TResult Function( _LoggedOutAuthEvent value)  loggedOut,required TResult Function( _SignedInAuthEvent value)  signedIn,}){
final _that = this;
switch (_that) {
case _InitializedAuthEvent():
return initialized(_that);case _LogoutRequestedAuthEvent():
return logoutRequested(_that);case _LoggedOutAuthEvent():
return loggedOut(_that);case _SignedInAuthEvent():
return signedIn(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InitializedAuthEvent value)?  initialized,TResult? Function( _LogoutRequestedAuthEvent value)?  logoutRequested,TResult? Function( _LoggedOutAuthEvent value)?  loggedOut,TResult? Function( _SignedInAuthEvent value)?  signedIn,}){
final _that = this;
switch (_that) {
case _InitializedAuthEvent() when initialized != null:
return initialized(_that);case _LogoutRequestedAuthEvent() when logoutRequested != null:
return logoutRequested(_that);case _LoggedOutAuthEvent() when loggedOut != null:
return loggedOut(_that);case _SignedInAuthEvent() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialized,TResult Function()?  logoutRequested,TResult Function()?  loggedOut,TResult Function()?  signedIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitializedAuthEvent() when initialized != null:
return initialized();case _LogoutRequestedAuthEvent() when logoutRequested != null:
return logoutRequested();case _LoggedOutAuthEvent() when loggedOut != null:
return loggedOut();case _SignedInAuthEvent() when signedIn != null:
return signedIn();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialized,required TResult Function()  logoutRequested,required TResult Function()  loggedOut,required TResult Function()  signedIn,}) {final _that = this;
switch (_that) {
case _InitializedAuthEvent():
return initialized();case _LogoutRequestedAuthEvent():
return logoutRequested();case _LoggedOutAuthEvent():
return loggedOut();case _SignedInAuthEvent():
return signedIn();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialized,TResult? Function()?  logoutRequested,TResult? Function()?  loggedOut,TResult? Function()?  signedIn,}) {final _that = this;
switch (_that) {
case _InitializedAuthEvent() when initialized != null:
return initialized();case _LogoutRequestedAuthEvent() when logoutRequested != null:
return logoutRequested();case _LoggedOutAuthEvent() when loggedOut != null:
return loggedOut();case _SignedInAuthEvent() when signedIn != null:
return signedIn();case _:
  return null;

}
}

}

/// @nodoc


class _InitializedAuthEvent implements AuthEvent {
  const _InitializedAuthEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitializedAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.initialized()';
}


}

/// @nodoc
class _$InitializedAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
_$InitializedAuthEventCopyWith(_InitializedAuthEvent _, $Res Function(_InitializedAuthEvent) __);
}
/// @nodoc
class __$InitializedAuthEventCopyWithImpl<$Res>
    implements _$InitializedAuthEventCopyWith<$Res> {
  __$InitializedAuthEventCopyWithImpl(this._self, this._then);

  final _InitializedAuthEvent _self;
  final $Res Function(_InitializedAuthEvent) _then;




}

/// @nodoc


class _LogoutRequestedAuthEvent implements AuthEvent {
  const _LogoutRequestedAuthEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogoutRequestedAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}

/// @nodoc
class _$LogoutRequestedAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
_$LogoutRequestedAuthEventCopyWith(_LogoutRequestedAuthEvent _, $Res Function(_LogoutRequestedAuthEvent) __);
}
/// @nodoc
class __$LogoutRequestedAuthEventCopyWithImpl<$Res>
    implements _$LogoutRequestedAuthEventCopyWith<$Res> {
  __$LogoutRequestedAuthEventCopyWithImpl(this._self, this._then);

  final _LogoutRequestedAuthEvent _self;
  final $Res Function(_LogoutRequestedAuthEvent) _then;




}

/// @nodoc


class _LoggedOutAuthEvent implements AuthEvent {
  const _LoggedOutAuthEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedOutAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loggedOut()';
}


}

/// @nodoc
class _$LoggedOutAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
_$LoggedOutAuthEventCopyWith(_LoggedOutAuthEvent _, $Res Function(_LoggedOutAuthEvent) __);
}
/// @nodoc
class __$LoggedOutAuthEventCopyWithImpl<$Res>
    implements _$LoggedOutAuthEventCopyWith<$Res> {
  __$LoggedOutAuthEventCopyWithImpl(this._self, this._then);

  final _LoggedOutAuthEvent _self;
  final $Res Function(_LoggedOutAuthEvent) _then;




}

/// @nodoc


class _SignedInAuthEvent implements AuthEvent {
  const _SignedInAuthEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignedInAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signedIn()';
}


}

/// @nodoc
class _$SignedInAuthEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
_$SignedInAuthEventCopyWith(_SignedInAuthEvent _, $Res Function(_SignedInAuthEvent) __);
}
/// @nodoc
class __$SignedInAuthEventCopyWithImpl<$Res>
    implements _$SignedInAuthEventCopyWith<$Res> {
  __$SignedInAuthEventCopyWithImpl(this._self, this._then);

  final _SignedInAuthEvent _self;
  final $Res Function(_SignedInAuthEvent) _then;




}

/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UnknownAuthState value)?  unknown,TResult Function( NewUserAuthState value)?  newUser,TResult Function( UnauthenticatedAuthState value)?  unauthenticated,TResult Function( AuthenticatedAuthState value)?  authenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UnknownAuthState() when unknown != null:
return unknown(_that);case NewUserAuthState() when newUser != null:
return newUser(_that);case UnauthenticatedAuthState() when unauthenticated != null:
return unauthenticated(_that);case AuthenticatedAuthState() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UnknownAuthState value)  unknown,required TResult Function( NewUserAuthState value)  newUser,required TResult Function( UnauthenticatedAuthState value)  unauthenticated,required TResult Function( AuthenticatedAuthState value)  authenticated,}){
final _that = this;
switch (_that) {
case UnknownAuthState():
return unknown(_that);case NewUserAuthState():
return newUser(_that);case UnauthenticatedAuthState():
return unauthenticated(_that);case AuthenticatedAuthState():
return authenticated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UnknownAuthState value)?  unknown,TResult? Function( NewUserAuthState value)?  newUser,TResult? Function( UnauthenticatedAuthState value)?  unauthenticated,TResult? Function( AuthenticatedAuthState value)?  authenticated,}){
final _that = this;
switch (_that) {
case UnknownAuthState() when unknown != null:
return unknown(_that);case NewUserAuthState() when newUser != null:
return newUser(_that);case UnauthenticatedAuthState() when unauthenticated != null:
return unauthenticated(_that);case AuthenticatedAuthState() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unknown,TResult Function()?  newUser,TResult Function()?  unauthenticated,TResult Function()?  authenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UnknownAuthState() when unknown != null:
return unknown();case NewUserAuthState() when newUser != null:
return newUser();case UnauthenticatedAuthState() when unauthenticated != null:
return unauthenticated();case AuthenticatedAuthState() when authenticated != null:
return authenticated();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unknown,required TResult Function()  newUser,required TResult Function()  unauthenticated,required TResult Function()  authenticated,}) {final _that = this;
switch (_that) {
case UnknownAuthState():
return unknown();case NewUserAuthState():
return newUser();case UnauthenticatedAuthState():
return unauthenticated();case AuthenticatedAuthState():
return authenticated();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unknown,TResult? Function()?  newUser,TResult? Function()?  unauthenticated,TResult? Function()?  authenticated,}) {final _that = this;
switch (_that) {
case UnknownAuthState() when unknown != null:
return unknown();case NewUserAuthState() when newUser != null:
return newUser();case UnauthenticatedAuthState() when unauthenticated != null:
return unauthenticated();case AuthenticatedAuthState() when authenticated != null:
return authenticated();case _:
  return null;

}
}

}

/// @nodoc


class UnknownAuthState extends AuthState {
  const UnknownAuthState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownAuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unknown()';
}


}

/// @nodoc
class $UnknownAuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
$UnknownAuthStateCopyWith(UnknownAuthState _, $Res Function(UnknownAuthState) __);
}
/// @nodoc
class _$UnknownAuthStateCopyWithImpl<$Res>
    implements $UnknownAuthStateCopyWith<$Res> {
  _$UnknownAuthStateCopyWithImpl(this._self, this._then);

  final UnknownAuthState _self;
  final $Res Function(UnknownAuthState) _then;




}

/// @nodoc


class NewUserAuthState extends AuthState {
  const NewUserAuthState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewUserAuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.newUser()';
}


}

/// @nodoc
class $NewUserAuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
$NewUserAuthStateCopyWith(NewUserAuthState _, $Res Function(NewUserAuthState) __);
}
/// @nodoc
class _$NewUserAuthStateCopyWithImpl<$Res>
    implements $NewUserAuthStateCopyWith<$Res> {
  _$NewUserAuthStateCopyWithImpl(this._self, this._then);

  final NewUserAuthState _self;
  final $Res Function(NewUserAuthState) _then;




}

/// @nodoc


class UnauthenticatedAuthState extends AuthState {
  const UnauthenticatedAuthState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthenticatedAuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}

/// @nodoc
class $UnauthenticatedAuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
$UnauthenticatedAuthStateCopyWith(UnauthenticatedAuthState _, $Res Function(UnauthenticatedAuthState) __);
}
/// @nodoc
class _$UnauthenticatedAuthStateCopyWithImpl<$Res>
    implements $UnauthenticatedAuthStateCopyWith<$Res> {
  _$UnauthenticatedAuthStateCopyWithImpl(this._self, this._then);

  final UnauthenticatedAuthState _self;
  final $Res Function(UnauthenticatedAuthState) _then;




}

/// @nodoc


class AuthenticatedAuthState extends AuthState {
  const AuthenticatedAuthState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticatedAuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticated()';
}


}

/// @nodoc
class $AuthenticatedAuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
$AuthenticatedAuthStateCopyWith(AuthenticatedAuthState _, $Res Function(AuthenticatedAuthState) __);
}
/// @nodoc
class _$AuthenticatedAuthStateCopyWithImpl<$Res>
    implements $AuthenticatedAuthStateCopyWith<$Res> {
  _$AuthenticatedAuthStateCopyWithImpl(this._self, this._then);

  final AuthenticatedAuthState _self;
  final $Res Function(AuthenticatedAuthState) _then;




}

// dart format on
