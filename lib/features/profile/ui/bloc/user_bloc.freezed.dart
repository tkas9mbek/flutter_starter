// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requested,
    required TResult Function(User user) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? requested,
    TResult? Function(User user)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requested,
    TResult Function(User user)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestedUserEvent value) requested,
    required TResult Function(_UpdatedUserEvent value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestedUserEvent value)? requested,
    TResult? Function(_UpdatedUserEvent value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestedUserEvent value)? requested,
    TResult Function(_UpdatedUserEvent value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCopyWith<$Res> {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) then) =
      _$UserEventCopyWithImpl<$Res, UserEvent>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res, $Val extends UserEvent>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RequestedUserEventImplCopyWith<$Res> {
  factory _$$RequestedUserEventImplCopyWith(_$RequestedUserEventImpl value,
          $Res Function(_$RequestedUserEventImpl) then) =
      __$$RequestedUserEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestedUserEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$RequestedUserEventImpl>
    implements _$$RequestedUserEventImplCopyWith<$Res> {
  __$$RequestedUserEventImplCopyWithImpl(_$RequestedUserEventImpl _value,
      $Res Function(_$RequestedUserEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestedUserEventImpl implements _RequestedUserEvent {
  const _$RequestedUserEventImpl();

  @override
  String toString() {
    return 'UserEvent.requested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RequestedUserEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requested,
    required TResult Function(User user) updated,
  }) {
    return requested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? requested,
    TResult? Function(User user)? updated,
  }) {
    return requested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requested,
    TResult Function(User user)? updated,
    required TResult orElse(),
  }) {
    if (requested != null) {
      return requested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestedUserEvent value) requested,
    required TResult Function(_UpdatedUserEvent value) updated,
  }) {
    return requested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestedUserEvent value)? requested,
    TResult? Function(_UpdatedUserEvent value)? updated,
  }) {
    return requested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestedUserEvent value)? requested,
    TResult Function(_UpdatedUserEvent value)? updated,
    required TResult orElse(),
  }) {
    if (requested != null) {
      return requested(this);
    }
    return orElse();
  }
}

abstract class _RequestedUserEvent implements UserEvent {
  const factory _RequestedUserEvent() = _$RequestedUserEventImpl;
}

/// @nodoc
abstract class _$$UpdatedUserEventImplCopyWith<$Res> {
  factory _$$UpdatedUserEventImplCopyWith(_$UpdatedUserEventImpl value,
          $Res Function(_$UpdatedUserEventImpl) then) =
      __$$UpdatedUserEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$UpdatedUserEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UpdatedUserEventImpl>
    implements _$$UpdatedUserEventImplCopyWith<$Res> {
  __$$UpdatedUserEventImplCopyWithImpl(_$UpdatedUserEventImpl _value,
      $Res Function(_$UpdatedUserEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$UpdatedUserEventImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$UpdatedUserEventImpl implements _UpdatedUserEvent {
  const _$UpdatedUserEventImpl(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'UserEvent.updated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedUserEventImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedUserEventImplCopyWith<_$UpdatedUserEventImpl> get copyWith =>
      __$$UpdatedUserEventImplCopyWithImpl<_$UpdatedUserEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requested,
    required TResult Function(User user) updated,
  }) {
    return updated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? requested,
    TResult? Function(User user)? updated,
  }) {
    return updated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requested,
    TResult Function(User user)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestedUserEvent value) requested,
    required TResult Function(_UpdatedUserEvent value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestedUserEvent value)? requested,
    TResult? Function(_UpdatedUserEvent value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestedUserEvent value)? requested,
    TResult Function(_UpdatedUserEvent value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _UpdatedUserEvent implements UserEvent {
  const factory _UpdatedUserEvent(final User user) = _$UpdatedUserEventImpl;

  User get user;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatedUserEventImplCopyWith<_$UpdatedUserEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialUserState value) initial,
    required TResult Function(_LoadingUserState value) loading,
    required TResult Function(_SuccessUserState value) success,
    required TResult Function(_FailureUserState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialUserState value)? initial,
    TResult? Function(_LoadingUserState value)? loading,
    TResult? Function(_SuccessUserState value)? success,
    TResult? Function(_FailureUserState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialUserState value)? initial,
    TResult Function(_LoadingUserState value)? loading,
    TResult Function(_SuccessUserState value)? success,
    TResult Function(_FailureUserState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialUserStateImplCopyWith<$Res> {
  factory _$$InitialUserStateImplCopyWith(_$InitialUserStateImpl value,
          $Res Function(_$InitialUserStateImpl) then) =
      __$$InitialUserStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialUserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$InitialUserStateImpl>
    implements _$$InitialUserStateImplCopyWith<$Res> {
  __$$InitialUserStateImplCopyWithImpl(_$InitialUserStateImpl _value,
      $Res Function(_$InitialUserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialUserStateImpl extends _InitialUserState {
  const _$InitialUserStateImpl() : super._();

  @override
  String toString() {
    return 'UserState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialUserStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? success,
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
    required TResult Function(_InitialUserState value) initial,
    required TResult Function(_LoadingUserState value) loading,
    required TResult Function(_SuccessUserState value) success,
    required TResult Function(_FailureUserState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialUserState value)? initial,
    TResult? Function(_LoadingUserState value)? loading,
    TResult? Function(_SuccessUserState value)? success,
    TResult? Function(_FailureUserState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialUserState value)? initial,
    TResult Function(_LoadingUserState value)? loading,
    TResult Function(_SuccessUserState value)? success,
    TResult Function(_FailureUserState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialUserState extends UserState {
  const factory _InitialUserState() = _$InitialUserStateImpl;
  const _InitialUserState._() : super._();
}

/// @nodoc
abstract class _$$LoadingUserStateImplCopyWith<$Res> {
  factory _$$LoadingUserStateImplCopyWith(_$LoadingUserStateImpl value,
          $Res Function(_$LoadingUserStateImpl) then) =
      __$$LoadingUserStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingUserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$LoadingUserStateImpl>
    implements _$$LoadingUserStateImplCopyWith<$Res> {
  __$$LoadingUserStateImplCopyWithImpl(_$LoadingUserStateImpl _value,
      $Res Function(_$LoadingUserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingUserStateImpl extends _LoadingUserState {
  const _$LoadingUserStateImpl() : super._();

  @override
  String toString() {
    return 'UserState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingUserStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? success,
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
    required TResult Function(_InitialUserState value) initial,
    required TResult Function(_LoadingUserState value) loading,
    required TResult Function(_SuccessUserState value) success,
    required TResult Function(_FailureUserState value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialUserState value)? initial,
    TResult? Function(_LoadingUserState value)? loading,
    TResult? Function(_SuccessUserState value)? success,
    TResult? Function(_FailureUserState value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialUserState value)? initial,
    TResult Function(_LoadingUserState value)? loading,
    TResult Function(_SuccessUserState value)? success,
    TResult Function(_FailureUserState value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingUserState extends UserState {
  const factory _LoadingUserState() = _$LoadingUserStateImpl;
  const _LoadingUserState._() : super._();
}

/// @nodoc
abstract class _$$SuccessUserStateImplCopyWith<$Res> {
  factory _$$SuccessUserStateImplCopyWith(_$SuccessUserStateImpl value,
          $Res Function(_$SuccessUserStateImpl) then) =
      __$$SuccessUserStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$SuccessUserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$SuccessUserStateImpl>
    implements _$$SuccessUserStateImplCopyWith<$Res> {
  __$$SuccessUserStateImplCopyWithImpl(_$SuccessUserStateImpl _value,
      $Res Function(_$SuccessUserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SuccessUserStateImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$SuccessUserStateImpl extends _SuccessUserState {
  const _$SuccessUserStateImpl(this.user) : super._();

  @override
  final User user;

  @override
  String toString() {
    return 'UserState.success(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessUserStateImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessUserStateImplCopyWith<_$SuccessUserStateImpl> get copyWith =>
      __$$SuccessUserStateImplCopyWithImpl<_$SuccessUserStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialUserState value) initial,
    required TResult Function(_LoadingUserState value) loading,
    required TResult Function(_SuccessUserState value) success,
    required TResult Function(_FailureUserState value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialUserState value)? initial,
    TResult? Function(_LoadingUserState value)? loading,
    TResult? Function(_SuccessUserState value)? success,
    TResult? Function(_FailureUserState value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialUserState value)? initial,
    TResult Function(_LoadingUserState value)? loading,
    TResult Function(_SuccessUserState value)? success,
    TResult Function(_FailureUserState value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessUserState extends UserState {
  const factory _SuccessUserState(final User user) = _$SuccessUserStateImpl;
  const _SuccessUserState._() : super._();

  User get user;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessUserStateImplCopyWith<_$SuccessUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureUserStateImplCopyWith<$Res> {
  factory _$$FailureUserStateImplCopyWith(_$FailureUserStateImpl value,
          $Res Function(_$FailureUserStateImpl) then) =
      __$$FailureUserStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureUserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$FailureUserStateImpl>
    implements _$$FailureUserStateImplCopyWith<$Res> {
  __$$FailureUserStateImplCopyWithImpl(_$FailureUserStateImpl _value,
      $Res Function(_$FailureUserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureUserStateImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureUserStateImpl extends _FailureUserState {
  const _$FailureUserStateImpl(this.exception) : super._();

  @override
  final AppException exception;

  @override
  String toString() {
    return 'UserState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureUserStateImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureUserStateImplCopyWith<_$FailureUserStateImpl> get copyWith =>
      __$$FailureUserStateImplCopyWithImpl<_$FailureUserStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? success,
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
    required TResult Function(_InitialUserState value) initial,
    required TResult Function(_LoadingUserState value) loading,
    required TResult Function(_SuccessUserState value) success,
    required TResult Function(_FailureUserState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialUserState value)? initial,
    TResult? Function(_LoadingUserState value)? loading,
    TResult? Function(_SuccessUserState value)? success,
    TResult? Function(_FailureUserState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialUserState value)? initial,
    TResult Function(_LoadingUserState value)? loading,
    TResult Function(_SuccessUserState value)? success,
    TResult Function(_FailureUserState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureUserState extends UserState {
  const factory _FailureUserState(final AppException exception) =
      _$FailureUserStateImpl;
  const _FailureUserState._() : super._();

  AppException get exception;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureUserStateImplCopyWith<_$FailureUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
