// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() logoutRequested,
    required TResult Function() loggedOut,
    required TResult Function() signedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? logoutRequested,
    TResult? Function()? loggedOut,
    TResult? Function()? signedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? logoutRequested,
    TResult Function()? loggedOut,
    TResult Function()? signedIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitializedAuthEvent value) initialized,
    required TResult Function(_LogoutRequestedAuthEvent value) logoutRequested,
    required TResult Function(_LoggedOutAuthEvent value) loggedOut,
    required TResult Function(_StatusChangedAuthEvent value) signedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitializedAuthEvent value)? initialized,
    TResult? Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult? Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult? Function(_StatusChangedAuthEvent value)? signedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitializedAuthEvent value)? initialized,
    TResult Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult Function(_StatusChangedAuthEvent value)? signedIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializedAuthEventImplCopyWith<$Res> {
  factory _$$InitializedAuthEventImplCopyWith(_$InitializedAuthEventImpl value,
          $Res Function(_$InitializedAuthEventImpl) then) =
      __$$InitializedAuthEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializedAuthEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$InitializedAuthEventImpl>
    implements _$$InitializedAuthEventImplCopyWith<$Res> {
  __$$InitializedAuthEventImplCopyWithImpl(_$InitializedAuthEventImpl _value,
      $Res Function(_$InitializedAuthEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializedAuthEventImpl implements _InitializedAuthEvent {
  const _$InitializedAuthEventImpl();

  @override
  String toString() {
    return 'AuthEvent.initialized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializedAuthEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() logoutRequested,
    required TResult Function() loggedOut,
    required TResult Function() signedIn,
  }) {
    return initialized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? logoutRequested,
    TResult? Function()? loggedOut,
    TResult? Function()? signedIn,
  }) {
    return initialized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? logoutRequested,
    TResult Function()? loggedOut,
    TResult Function()? signedIn,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitializedAuthEvent value) initialized,
    required TResult Function(_LogoutRequestedAuthEvent value) logoutRequested,
    required TResult Function(_LoggedOutAuthEvent value) loggedOut,
    required TResult Function(_StatusChangedAuthEvent value) signedIn,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitializedAuthEvent value)? initialized,
    TResult? Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult? Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult? Function(_StatusChangedAuthEvent value)? signedIn,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitializedAuthEvent value)? initialized,
    TResult Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult Function(_StatusChangedAuthEvent value)? signedIn,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class _InitializedAuthEvent implements AuthEvent {
  const factory _InitializedAuthEvent() = _$InitializedAuthEventImpl;
}

/// @nodoc
abstract class _$$LogoutRequestedAuthEventImplCopyWith<$Res> {
  factory _$$LogoutRequestedAuthEventImplCopyWith(
          _$LogoutRequestedAuthEventImpl value,
          $Res Function(_$LogoutRequestedAuthEventImpl) then) =
      __$$LogoutRequestedAuthEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutRequestedAuthEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LogoutRequestedAuthEventImpl>
    implements _$$LogoutRequestedAuthEventImplCopyWith<$Res> {
  __$$LogoutRequestedAuthEventImplCopyWithImpl(
      _$LogoutRequestedAuthEventImpl _value,
      $Res Function(_$LogoutRequestedAuthEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutRequestedAuthEventImpl implements _LogoutRequestedAuthEvent {
  const _$LogoutRequestedAuthEventImpl();

  @override
  String toString() {
    return 'AuthEvent.logoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogoutRequestedAuthEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() logoutRequested,
    required TResult Function() loggedOut,
    required TResult Function() signedIn,
  }) {
    return logoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? logoutRequested,
    TResult? Function()? loggedOut,
    TResult? Function()? signedIn,
  }) {
    return logoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? logoutRequested,
    TResult Function()? loggedOut,
    TResult Function()? signedIn,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitializedAuthEvent value) initialized,
    required TResult Function(_LogoutRequestedAuthEvent value) logoutRequested,
    required TResult Function(_LoggedOutAuthEvent value) loggedOut,
    required TResult Function(_StatusChangedAuthEvent value) signedIn,
  }) {
    return logoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitializedAuthEvent value)? initialized,
    TResult? Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult? Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult? Function(_StatusChangedAuthEvent value)? signedIn,
  }) {
    return logoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitializedAuthEvent value)? initialized,
    TResult Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult Function(_StatusChangedAuthEvent value)? signedIn,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested(this);
    }
    return orElse();
  }
}

abstract class _LogoutRequestedAuthEvent implements AuthEvent {
  const factory _LogoutRequestedAuthEvent() = _$LogoutRequestedAuthEventImpl;
}

/// @nodoc
abstract class _$$LoggedOutAuthEventImplCopyWith<$Res> {
  factory _$$LoggedOutAuthEventImplCopyWith(_$LoggedOutAuthEventImpl value,
          $Res Function(_$LoggedOutAuthEventImpl) then) =
      __$$LoggedOutAuthEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggedOutAuthEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoggedOutAuthEventImpl>
    implements _$$LoggedOutAuthEventImplCopyWith<$Res> {
  __$$LoggedOutAuthEventImplCopyWithImpl(_$LoggedOutAuthEventImpl _value,
      $Res Function(_$LoggedOutAuthEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoggedOutAuthEventImpl implements _LoggedOutAuthEvent {
  const _$LoggedOutAuthEventImpl();

  @override
  String toString() {
    return 'AuthEvent.loggedOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggedOutAuthEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() logoutRequested,
    required TResult Function() loggedOut,
    required TResult Function() signedIn,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? logoutRequested,
    TResult? Function()? loggedOut,
    TResult? Function()? signedIn,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? logoutRequested,
    TResult Function()? loggedOut,
    TResult Function()? signedIn,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitializedAuthEvent value) initialized,
    required TResult Function(_LogoutRequestedAuthEvent value) logoutRequested,
    required TResult Function(_LoggedOutAuthEvent value) loggedOut,
    required TResult Function(_StatusChangedAuthEvent value) signedIn,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitializedAuthEvent value)? initialized,
    TResult? Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult? Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult? Function(_StatusChangedAuthEvent value)? signedIn,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitializedAuthEvent value)? initialized,
    TResult Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult Function(_StatusChangedAuthEvent value)? signedIn,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class _LoggedOutAuthEvent implements AuthEvent {
  const factory _LoggedOutAuthEvent() = _$LoggedOutAuthEventImpl;
}

/// @nodoc
abstract class _$$StatusChangedAuthEventImplCopyWith<$Res> {
  factory _$$StatusChangedAuthEventImplCopyWith(
          _$StatusChangedAuthEventImpl value,
          $Res Function(_$StatusChangedAuthEventImpl) then) =
      __$$StatusChangedAuthEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatusChangedAuthEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$StatusChangedAuthEventImpl>
    implements _$$StatusChangedAuthEventImplCopyWith<$Res> {
  __$$StatusChangedAuthEventImplCopyWithImpl(
      _$StatusChangedAuthEventImpl _value,
      $Res Function(_$StatusChangedAuthEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StatusChangedAuthEventImpl implements _StatusChangedAuthEvent {
  const _$StatusChangedAuthEventImpl();

  @override
  String toString() {
    return 'AuthEvent.signedIn()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusChangedAuthEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() logoutRequested,
    required TResult Function() loggedOut,
    required TResult Function() signedIn,
  }) {
    return signedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? logoutRequested,
    TResult? Function()? loggedOut,
    TResult? Function()? signedIn,
  }) {
    return signedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? logoutRequested,
    TResult Function()? loggedOut,
    TResult Function()? signedIn,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitializedAuthEvent value) initialized,
    required TResult Function(_LogoutRequestedAuthEvent value) logoutRequested,
    required TResult Function(_LoggedOutAuthEvent value) loggedOut,
    required TResult Function(_StatusChangedAuthEvent value) signedIn,
  }) {
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitializedAuthEvent value)? initialized,
    TResult? Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult? Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult? Function(_StatusChangedAuthEvent value)? signedIn,
  }) {
    return signedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitializedAuthEvent value)? initialized,
    TResult Function(_LogoutRequestedAuthEvent value)? logoutRequested,
    TResult Function(_LoggedOutAuthEvent value)? loggedOut,
    TResult Function(_StatusChangedAuthEvent value)? signedIn,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }
}

abstract class _StatusChangedAuthEvent implements AuthEvent {
  const factory _StatusChangedAuthEvent() = _$StatusChangedAuthEventImpl;
}

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnknownAuthState value) unknown,
    required TResult Function(_UnauthenticatedAuthState value) unauthenticated,
    required TResult Function(_AuthenticatedAuthState value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnknownAuthState value)? unknown,
    TResult? Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult? Function(_AuthenticatedAuthState value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnknownAuthState value)? unknown,
    TResult Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult Function(_AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UnknownAuthStateImplCopyWith<$Res> {
  factory _$$UnknownAuthStateImplCopyWith(_$UnknownAuthStateImpl value,
          $Res Function(_$UnknownAuthStateImpl) then) =
      __$$UnknownAuthStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnknownAuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnknownAuthStateImpl>
    implements _$$UnknownAuthStateImplCopyWith<$Res> {
  __$$UnknownAuthStateImplCopyWithImpl(_$UnknownAuthStateImpl _value,
      $Res Function(_$UnknownAuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnknownAuthStateImpl extends _UnknownAuthState {
  const _$UnknownAuthStateImpl() : super._();

  @override
  String toString() {
    return 'AuthState.unknown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnknownAuthStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnknownAuthState value) unknown,
    required TResult Function(_UnauthenticatedAuthState value) unauthenticated,
    required TResult Function(_AuthenticatedAuthState value) authenticated,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnknownAuthState value)? unknown,
    TResult? Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult? Function(_AuthenticatedAuthState value)? authenticated,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnknownAuthState value)? unknown,
    TResult Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult Function(_AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownAuthState extends AuthState {
  const factory _UnknownAuthState() = _$UnknownAuthStateImpl;
  const _UnknownAuthState._() : super._();
}

/// @nodoc
abstract class _$$UnauthenticatedAuthStateImplCopyWith<$Res> {
  factory _$$UnauthenticatedAuthStateImplCopyWith(
          _$UnauthenticatedAuthStateImpl value,
          $Res Function(_$UnauthenticatedAuthStateImpl) then) =
      __$$UnauthenticatedAuthStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedAuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedAuthStateImpl>
    implements _$$UnauthenticatedAuthStateImplCopyWith<$Res> {
  __$$UnauthenticatedAuthStateImplCopyWithImpl(
      _$UnauthenticatedAuthStateImpl _value,
      $Res Function(_$UnauthenticatedAuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedAuthStateImpl extends _UnauthenticatedAuthState {
  const _$UnauthenticatedAuthStateImpl() : super._();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthenticatedAuthStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnknownAuthState value) unknown,
    required TResult Function(_UnauthenticatedAuthState value) unauthenticated,
    required TResult Function(_AuthenticatedAuthState value) authenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnknownAuthState value)? unknown,
    TResult? Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult? Function(_AuthenticatedAuthState value)? authenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnknownAuthState value)? unknown,
    TResult Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult Function(_AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _UnauthenticatedAuthState extends AuthState {
  const factory _UnauthenticatedAuthState() = _$UnauthenticatedAuthStateImpl;
  const _UnauthenticatedAuthState._() : super._();
}

/// @nodoc
abstract class _$$AuthenticatedAuthStateImplCopyWith<$Res> {
  factory _$$AuthenticatedAuthStateImplCopyWith(
          _$AuthenticatedAuthStateImpl value,
          $Res Function(_$AuthenticatedAuthStateImpl) then) =
      __$$AuthenticatedAuthStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedAuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedAuthStateImpl>
    implements _$$AuthenticatedAuthStateImplCopyWith<$Res> {
  __$$AuthenticatedAuthStateImplCopyWithImpl(
      _$AuthenticatedAuthStateImpl _value,
      $Res Function(_$AuthenticatedAuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticatedAuthStateImpl extends _AuthenticatedAuthState {
  const _$AuthenticatedAuthStateImpl() : super._();

  @override
  String toString() {
    return 'AuthState.authenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedAuthStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UnknownAuthState value) unknown,
    required TResult Function(_UnauthenticatedAuthState value) unauthenticated,
    required TResult Function(_AuthenticatedAuthState value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnknownAuthState value)? unknown,
    TResult? Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult? Function(_AuthenticatedAuthState value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UnknownAuthState value)? unknown,
    TResult Function(_UnauthenticatedAuthState value)? unauthenticated,
    TResult Function(_AuthenticatedAuthState value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _AuthenticatedAuthState extends AuthState {
  const factory _AuthenticatedAuthState() = _$AuthenticatedAuthStateImpl;
  const _AuthenticatedAuthState._() : super._();
}
