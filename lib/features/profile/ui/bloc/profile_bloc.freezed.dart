// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() logoutRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? logoutRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadedProfileEvent value) loaded,
    required TResult Function(_LogoutRequestedProfileEvent value)
        logoutRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedProfileEvent value)? loaded,
    TResult? Function(_LogoutRequestedProfileEvent value)? logoutRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedProfileEvent value)? loaded,
    TResult Function(_LogoutRequestedProfileEvent value)? logoutRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEventCopyWith<$Res> {
  factory $ProfileEventCopyWith(
          ProfileEvent value, $Res Function(ProfileEvent) then) =
      _$ProfileEventCopyWithImpl<$Res, ProfileEvent>;
}

/// @nodoc
class _$ProfileEventCopyWithImpl<$Res, $Val extends ProfileEvent>
    implements $ProfileEventCopyWith<$Res> {
  _$ProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadedProfileEventImplCopyWith<$Res> {
  factory _$$LoadedProfileEventImplCopyWith(_$LoadedProfileEventImpl value,
          $Res Function(_$LoadedProfileEventImpl) then) =
      __$$LoadedProfileEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadedProfileEventImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$LoadedProfileEventImpl>
    implements _$$LoadedProfileEventImplCopyWith<$Res> {
  __$$LoadedProfileEventImplCopyWithImpl(_$LoadedProfileEventImpl _value,
      $Res Function(_$LoadedProfileEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadedProfileEventImpl implements _LoadedProfileEvent {
  const _$LoadedProfileEventImpl();

  @override
  String toString() {
    return 'ProfileEvent.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadedProfileEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() logoutRequested,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? logoutRequested,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? logoutRequested,
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
    required TResult Function(_LoadedProfileEvent value) loaded,
    required TResult Function(_LogoutRequestedProfileEvent value)
        logoutRequested,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedProfileEvent value)? loaded,
    TResult? Function(_LogoutRequestedProfileEvent value)? logoutRequested,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedProfileEvent value)? loaded,
    TResult Function(_LogoutRequestedProfileEvent value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _LoadedProfileEvent implements ProfileEvent {
  const factory _LoadedProfileEvent() = _$LoadedProfileEventImpl;
}

/// @nodoc
abstract class _$$LogoutRequestedProfileEventImplCopyWith<$Res> {
  factory _$$LogoutRequestedProfileEventImplCopyWith(
          _$LogoutRequestedProfileEventImpl value,
          $Res Function(_$LogoutRequestedProfileEventImpl) then) =
      __$$LogoutRequestedProfileEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutRequestedProfileEventImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$LogoutRequestedProfileEventImpl>
    implements _$$LogoutRequestedProfileEventImplCopyWith<$Res> {
  __$$LogoutRequestedProfileEventImplCopyWithImpl(
      _$LogoutRequestedProfileEventImpl _value,
      $Res Function(_$LogoutRequestedProfileEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutRequestedProfileEventImpl
    implements _LogoutRequestedProfileEvent {
  const _$LogoutRequestedProfileEventImpl();

  @override
  String toString() {
    return 'ProfileEvent.logoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogoutRequestedProfileEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() logoutRequested,
  }) {
    return logoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? logoutRequested,
  }) {
    return logoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? logoutRequested,
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
    required TResult Function(_LoadedProfileEvent value) loaded,
    required TResult Function(_LogoutRequestedProfileEvent value)
        logoutRequested,
  }) {
    return logoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedProfileEvent value)? loaded,
    TResult? Function(_LogoutRequestedProfileEvent value)? logoutRequested,
  }) {
    return logoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedProfileEvent value)? loaded,
    TResult Function(_LogoutRequestedProfileEvent value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested(this);
    }
    return orElse();
  }
}

abstract class _LogoutRequestedProfileEvent implements ProfileEvent {
  const factory _LogoutRequestedProfileEvent() =
      _$LogoutRequestedProfileEventImpl;
}

/// @nodoc
mixin _$ProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
    required TResult Function() loggingOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? success,
    TResult? Function(AppException exception)? failure,
    TResult? Function()? loggingOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? success,
    TResult Function(AppException exception)? failure,
    TResult Function()? loggingOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialProfileState value) initial,
    required TResult Function(_LoadingProfileState value) loading,
    required TResult Function(_SuccessProfileState value) success,
    required TResult Function(_FailureProfileState value) failure,
    required TResult Function(_LoggingOutProfileState value) loggingOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfileState value)? initial,
    TResult? Function(_LoadingProfileState value)? loading,
    TResult? Function(_SuccessProfileState value)? success,
    TResult? Function(_FailureProfileState value)? failure,
    TResult? Function(_LoggingOutProfileState value)? loggingOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfileState value)? initial,
    TResult Function(_LoadingProfileState value)? loading,
    TResult Function(_SuccessProfileState value)? success,
    TResult Function(_FailureProfileState value)? failure,
    TResult Function(_LoggingOutProfileState value)? loggingOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialProfileStateImplCopyWith<$Res> {
  factory _$$InitialProfileStateImplCopyWith(_$InitialProfileStateImpl value,
          $Res Function(_$InitialProfileStateImpl) then) =
      __$$InitialProfileStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$InitialProfileStateImpl>
    implements _$$InitialProfileStateImplCopyWith<$Res> {
  __$$InitialProfileStateImplCopyWithImpl(_$InitialProfileStateImpl _value,
      $Res Function(_$InitialProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialProfileStateImpl extends _InitialProfileState {
  const _$InitialProfileStateImpl() : super._();

  @override
  String toString() {
    return 'ProfileState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialProfileStateImpl);
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
    required TResult Function() loggingOut,
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
    TResult? Function()? loggingOut,
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
    TResult Function()? loggingOut,
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
    required TResult Function(_InitialProfileState value) initial,
    required TResult Function(_LoadingProfileState value) loading,
    required TResult Function(_SuccessProfileState value) success,
    required TResult Function(_FailureProfileState value) failure,
    required TResult Function(_LoggingOutProfileState value) loggingOut,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfileState value)? initial,
    TResult? Function(_LoadingProfileState value)? loading,
    TResult? Function(_SuccessProfileState value)? success,
    TResult? Function(_FailureProfileState value)? failure,
    TResult? Function(_LoggingOutProfileState value)? loggingOut,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfileState value)? initial,
    TResult Function(_LoadingProfileState value)? loading,
    TResult Function(_SuccessProfileState value)? success,
    TResult Function(_FailureProfileState value)? failure,
    TResult Function(_LoggingOutProfileState value)? loggingOut,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialProfileState extends ProfileState {
  const factory _InitialProfileState() = _$InitialProfileStateImpl;
  const _InitialProfileState._() : super._();
}

/// @nodoc
abstract class _$$LoadingProfileStateImplCopyWith<$Res> {
  factory _$$LoadingProfileStateImplCopyWith(_$LoadingProfileStateImpl value,
          $Res Function(_$LoadingProfileStateImpl) then) =
      __$$LoadingProfileStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$LoadingProfileStateImpl>
    implements _$$LoadingProfileStateImplCopyWith<$Res> {
  __$$LoadingProfileStateImplCopyWithImpl(_$LoadingProfileStateImpl _value,
      $Res Function(_$LoadingProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingProfileStateImpl extends _LoadingProfileState {
  const _$LoadingProfileStateImpl() : super._();

  @override
  String toString() {
    return 'ProfileState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingProfileStateImpl);
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
    required TResult Function() loggingOut,
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
    TResult? Function()? loggingOut,
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
    TResult Function()? loggingOut,
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
    required TResult Function(_InitialProfileState value) initial,
    required TResult Function(_LoadingProfileState value) loading,
    required TResult Function(_SuccessProfileState value) success,
    required TResult Function(_FailureProfileState value) failure,
    required TResult Function(_LoggingOutProfileState value) loggingOut,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfileState value)? initial,
    TResult? Function(_LoadingProfileState value)? loading,
    TResult? Function(_SuccessProfileState value)? success,
    TResult? Function(_FailureProfileState value)? failure,
    TResult? Function(_LoggingOutProfileState value)? loggingOut,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfileState value)? initial,
    TResult Function(_LoadingProfileState value)? loading,
    TResult Function(_SuccessProfileState value)? success,
    TResult Function(_FailureProfileState value)? failure,
    TResult Function(_LoggingOutProfileState value)? loggingOut,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingProfileState extends ProfileState {
  const factory _LoadingProfileState() = _$LoadingProfileStateImpl;
  const _LoadingProfileState._() : super._();
}

/// @nodoc
abstract class _$$SuccessProfileStateImplCopyWith<$Res> {
  factory _$$SuccessProfileStateImplCopyWith(_$SuccessProfileStateImpl value,
          $Res Function(_$SuccessProfileStateImpl) then) =
      __$$SuccessProfileStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$SuccessProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$SuccessProfileStateImpl>
    implements _$$SuccessProfileStateImplCopyWith<$Res> {
  __$$SuccessProfileStateImplCopyWithImpl(_$SuccessProfileStateImpl _value,
      $Res Function(_$SuccessProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SuccessProfileStateImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of ProfileState
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

class _$SuccessProfileStateImpl extends _SuccessProfileState {
  const _$SuccessProfileStateImpl(this.user) : super._();

  @override
  final User user;

  @override
  String toString() {
    return 'ProfileState.success(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessProfileStateImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessProfileStateImplCopyWith<_$SuccessProfileStateImpl> get copyWith =>
      __$$SuccessProfileStateImplCopyWithImpl<_$SuccessProfileStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
    required TResult Function() loggingOut,
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
    TResult? Function()? loggingOut,
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
    TResult Function()? loggingOut,
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
    required TResult Function(_InitialProfileState value) initial,
    required TResult Function(_LoadingProfileState value) loading,
    required TResult Function(_SuccessProfileState value) success,
    required TResult Function(_FailureProfileState value) failure,
    required TResult Function(_LoggingOutProfileState value) loggingOut,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfileState value)? initial,
    TResult? Function(_LoadingProfileState value)? loading,
    TResult? Function(_SuccessProfileState value)? success,
    TResult? Function(_FailureProfileState value)? failure,
    TResult? Function(_LoggingOutProfileState value)? loggingOut,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfileState value)? initial,
    TResult Function(_LoadingProfileState value)? loading,
    TResult Function(_SuccessProfileState value)? success,
    TResult Function(_FailureProfileState value)? failure,
    TResult Function(_LoggingOutProfileState value)? loggingOut,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessProfileState extends ProfileState {
  const factory _SuccessProfileState(final User user) =
      _$SuccessProfileStateImpl;
  const _SuccessProfileState._() : super._();

  User get user;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessProfileStateImplCopyWith<_$SuccessProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureProfileStateImplCopyWith<$Res> {
  factory _$$FailureProfileStateImplCopyWith(_$FailureProfileStateImpl value,
          $Res Function(_$FailureProfileStateImpl) then) =
      __$$FailureProfileStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$FailureProfileStateImpl>
    implements _$$FailureProfileStateImplCopyWith<$Res> {
  __$$FailureProfileStateImplCopyWithImpl(_$FailureProfileStateImpl _value,
      $Res Function(_$FailureProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureProfileStateImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureProfileStateImpl extends _FailureProfileState {
  const _$FailureProfileStateImpl(this.exception) : super._();

  @override
  final AppException exception;

  @override
  String toString() {
    return 'ProfileState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureProfileStateImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureProfileStateImplCopyWith<_$FailureProfileStateImpl> get copyWith =>
      __$$FailureProfileStateImplCopyWithImpl<_$FailureProfileStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) success,
    required TResult Function(AppException exception) failure,
    required TResult Function() loggingOut,
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
    TResult? Function()? loggingOut,
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
    TResult Function()? loggingOut,
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
    required TResult Function(_InitialProfileState value) initial,
    required TResult Function(_LoadingProfileState value) loading,
    required TResult Function(_SuccessProfileState value) success,
    required TResult Function(_FailureProfileState value) failure,
    required TResult Function(_LoggingOutProfileState value) loggingOut,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfileState value)? initial,
    TResult? Function(_LoadingProfileState value)? loading,
    TResult? Function(_SuccessProfileState value)? success,
    TResult? Function(_FailureProfileState value)? failure,
    TResult? Function(_LoggingOutProfileState value)? loggingOut,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfileState value)? initial,
    TResult Function(_LoadingProfileState value)? loading,
    TResult Function(_SuccessProfileState value)? success,
    TResult Function(_FailureProfileState value)? failure,
    TResult Function(_LoggingOutProfileState value)? loggingOut,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureProfileState extends ProfileState {
  const factory _FailureProfileState(final AppException exception) =
      _$FailureProfileStateImpl;
  const _FailureProfileState._() : super._();

  AppException get exception;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureProfileStateImplCopyWith<_$FailureProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoggingOutProfileStateImplCopyWith<$Res> {
  factory _$$LoggingOutProfileStateImplCopyWith(
          _$LoggingOutProfileStateImpl value,
          $Res Function(_$LoggingOutProfileStateImpl) then) =
      __$$LoggingOutProfileStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggingOutProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$LoggingOutProfileStateImpl>
    implements _$$LoggingOutProfileStateImplCopyWith<$Res> {
  __$$LoggingOutProfileStateImplCopyWithImpl(
      _$LoggingOutProfileStateImpl _value,
      $Res Function(_$LoggingOutProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoggingOutProfileStateImpl extends _LoggingOutProfileState {
  const _$LoggingOutProfileStateImpl() : super._();

  @override
  String toString() {
    return 'ProfileState.loggingOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggingOutProfileStateImpl);
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
    required TResult Function() loggingOut,
  }) {
    return loggingOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? success,
    TResult? Function(AppException exception)? failure,
    TResult? Function()? loggingOut,
  }) {
    return loggingOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? success,
    TResult Function(AppException exception)? failure,
    TResult Function()? loggingOut,
    required TResult orElse(),
  }) {
    if (loggingOut != null) {
      return loggingOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialProfileState value) initial,
    required TResult Function(_LoadingProfileState value) loading,
    required TResult Function(_SuccessProfileState value) success,
    required TResult Function(_FailureProfileState value) failure,
    required TResult Function(_LoggingOutProfileState value) loggingOut,
  }) {
    return loggingOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfileState value)? initial,
    TResult? Function(_LoadingProfileState value)? loading,
    TResult? Function(_SuccessProfileState value)? success,
    TResult? Function(_FailureProfileState value)? failure,
    TResult? Function(_LoggingOutProfileState value)? loggingOut,
  }) {
    return loggingOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfileState value)? initial,
    TResult Function(_LoadingProfileState value)? loading,
    TResult Function(_SuccessProfileState value)? success,
    TResult Function(_FailureProfileState value)? failure,
    TResult Function(_LoggingOutProfileState value)? loggingOut,
    required TResult orElse(),
  }) {
    if (loggingOut != null) {
      return loggingOut(this);
    }
    return orElse();
  }
}

abstract class _LoggingOutProfileState extends ProfileState {
  const factory _LoggingOutProfileState() = _$LoggingOutProfileStateImpl;
  const _LoggingOutProfileState._() : super._();
}
