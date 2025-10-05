// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginEvent {
  LoginForm get form => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginForm form) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LoginForm form)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginForm form)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubmittedLoginEvent value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmittedLoginEvent value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmittedLoginEvent value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginEventCopyWith<LoginEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
  @useResult
  $Res call({LoginForm form});
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
  }) {
    return _then(_value.copyWith(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as LoginForm,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmittedLoginEventImplCopyWith<$Res>
    implements $LoginEventCopyWith<$Res> {
  factory _$$SubmittedLoginEventImplCopyWith(_$SubmittedLoginEventImpl value,
          $Res Function(_$SubmittedLoginEventImpl) then) =
      __$$SubmittedLoginEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LoginForm form});
}

/// @nodoc
class __$$SubmittedLoginEventImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$SubmittedLoginEventImpl>
    implements _$$SubmittedLoginEventImplCopyWith<$Res> {
  __$$SubmittedLoginEventImplCopyWithImpl(_$SubmittedLoginEventImpl _value,
      $Res Function(_$SubmittedLoginEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
  }) {
    return _then(_$SubmittedLoginEventImpl(
      null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as LoginForm,
    ));
  }
}

/// @nodoc

class _$SubmittedLoginEventImpl implements _SubmittedLoginEvent {
  const _$SubmittedLoginEventImpl(this.form);

  @override
  final LoginForm form;

  @override
  String toString() {
    return 'LoginEvent.submitted(form: $form)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmittedLoginEventImpl &&
            (identical(other.form, form) || other.form == form));
  }

  @override
  int get hashCode => Object.hash(runtimeType, form);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmittedLoginEventImplCopyWith<_$SubmittedLoginEventImpl> get copyWith =>
      __$$SubmittedLoginEventImplCopyWithImpl<_$SubmittedLoginEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginForm form) submitted,
  }) {
    return submitted(form);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LoginForm form)? submitted,
  }) {
    return submitted?.call(form);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginForm form)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(form);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubmittedLoginEvent value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmittedLoginEvent value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmittedLoginEvent value)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class _SubmittedLoginEvent implements LoginEvent {
  const factory _SubmittedLoginEvent(final LoginForm form) =
      _$SubmittedLoginEventImpl;

  @override
  LoginForm get form;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmittedLoginEventImplCopyWith<_$SubmittedLoginEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialLoginState value) initial,
    required TResult Function(_LoadingLoginState value) loading,
    required TResult Function(_SuccessLoginState value) success,
    required TResult Function(_FailureLoginState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialLoginState value)? initial,
    TResult? Function(_LoadingLoginState value)? loading,
    TResult? Function(_SuccessLoginState value)? success,
    TResult? Function(_FailureLoginState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialLoginState value)? initial,
    TResult Function(_LoadingLoginState value)? loading,
    TResult Function(_SuccessLoginState value)? success,
    TResult Function(_FailureLoginState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialLoginStateImplCopyWith<$Res> {
  factory _$$InitialLoginStateImplCopyWith(_$InitialLoginStateImpl value,
          $Res Function(_$InitialLoginStateImpl) then) =
      __$$InitialLoginStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialLoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$InitialLoginStateImpl>
    implements _$$InitialLoginStateImplCopyWith<$Res> {
  __$$InitialLoginStateImplCopyWithImpl(_$InitialLoginStateImpl _value,
      $Res Function(_$InitialLoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialLoginStateImpl extends _InitialLoginState {
  const _$InitialLoginStateImpl() : super._();

  @override
  String toString() {
    return 'LoginState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialLoginStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
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
    required TResult Function(_InitialLoginState value) initial,
    required TResult Function(_LoadingLoginState value) loading,
    required TResult Function(_SuccessLoginState value) success,
    required TResult Function(_FailureLoginState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialLoginState value)? initial,
    TResult? Function(_LoadingLoginState value)? loading,
    TResult? Function(_SuccessLoginState value)? success,
    TResult? Function(_FailureLoginState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialLoginState value)? initial,
    TResult Function(_LoadingLoginState value)? loading,
    TResult Function(_SuccessLoginState value)? success,
    TResult Function(_FailureLoginState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialLoginState extends LoginState {
  const factory _InitialLoginState() = _$InitialLoginStateImpl;
  const _InitialLoginState._() : super._();
}

/// @nodoc
abstract class _$$LoadingLoginStateImplCopyWith<$Res> {
  factory _$$LoadingLoginStateImplCopyWith(_$LoadingLoginStateImpl value,
          $Res Function(_$LoadingLoginStateImpl) then) =
      __$$LoadingLoginStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingLoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoadingLoginStateImpl>
    implements _$$LoadingLoginStateImplCopyWith<$Res> {
  __$$LoadingLoginStateImplCopyWithImpl(_$LoadingLoginStateImpl _value,
      $Res Function(_$LoadingLoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingLoginStateImpl extends _LoadingLoginState {
  const _$LoadingLoginStateImpl() : super._();

  @override
  String toString() {
    return 'LoginState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingLoginStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
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
    required TResult Function(_InitialLoginState value) initial,
    required TResult Function(_LoadingLoginState value) loading,
    required TResult Function(_SuccessLoginState value) success,
    required TResult Function(_FailureLoginState value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialLoginState value)? initial,
    TResult? Function(_LoadingLoginState value)? loading,
    TResult? Function(_SuccessLoginState value)? success,
    TResult? Function(_FailureLoginState value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialLoginState value)? initial,
    TResult Function(_LoadingLoginState value)? loading,
    TResult Function(_SuccessLoginState value)? success,
    TResult Function(_FailureLoginState value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingLoginState extends LoginState {
  const factory _LoadingLoginState() = _$LoadingLoginStateImpl;
  const _LoadingLoginState._() : super._();
}

/// @nodoc
abstract class _$$SuccessLoginStateImplCopyWith<$Res> {
  factory _$$SuccessLoginStateImplCopyWith(_$SuccessLoginStateImpl value,
          $Res Function(_$SuccessLoginStateImpl) then) =
      __$$SuccessLoginStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessLoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$SuccessLoginStateImpl>
    implements _$$SuccessLoginStateImplCopyWith<$Res> {
  __$$SuccessLoginStateImplCopyWithImpl(_$SuccessLoginStateImpl _value,
      $Res Function(_$SuccessLoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessLoginStateImpl extends _SuccessLoginState {
  const _$SuccessLoginStateImpl() : super._();

  @override
  String toString() {
    return 'LoginState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessLoginStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialLoginState value) initial,
    required TResult Function(_LoadingLoginState value) loading,
    required TResult Function(_SuccessLoginState value) success,
    required TResult Function(_FailureLoginState value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialLoginState value)? initial,
    TResult? Function(_LoadingLoginState value)? loading,
    TResult? Function(_SuccessLoginState value)? success,
    TResult? Function(_FailureLoginState value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialLoginState value)? initial,
    TResult Function(_LoadingLoginState value)? loading,
    TResult Function(_SuccessLoginState value)? success,
    TResult Function(_FailureLoginState value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessLoginState extends LoginState {
  const factory _SuccessLoginState() = _$SuccessLoginStateImpl;
  const _SuccessLoginState._() : super._();
}

/// @nodoc
abstract class _$$FailureLoginStateImplCopyWith<$Res> {
  factory _$$FailureLoginStateImplCopyWith(_$FailureLoginStateImpl value,
          $Res Function(_$FailureLoginStateImpl) then) =
      __$$FailureLoginStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureLoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$FailureLoginStateImpl>
    implements _$$FailureLoginStateImplCopyWith<$Res> {
  __$$FailureLoginStateImplCopyWithImpl(_$FailureLoginStateImpl _value,
      $Res Function(_$FailureLoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureLoginStateImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureLoginStateImpl extends _FailureLoginState {
  const _$FailureLoginStateImpl(this.exception) : super._();

  @override
  final AppException exception;

  @override
  String toString() {
    return 'LoginState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureLoginStateImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureLoginStateImplCopyWith<_$FailureLoginStateImpl> get copyWith =>
      __$$FailureLoginStateImplCopyWithImpl<_$FailureLoginStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
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
    required TResult Function(_InitialLoginState value) initial,
    required TResult Function(_LoadingLoginState value) loading,
    required TResult Function(_SuccessLoginState value) success,
    required TResult Function(_FailureLoginState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialLoginState value)? initial,
    TResult? Function(_LoadingLoginState value)? loading,
    TResult? Function(_SuccessLoginState value)? success,
    TResult? Function(_FailureLoginState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialLoginState value)? initial,
    TResult Function(_LoadingLoginState value)? loading,
    TResult Function(_SuccessLoginState value)? success,
    TResult Function(_FailureLoginState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureLoginState extends LoginState {
  const factory _FailureLoginState(final AppException exception) =
      _$FailureLoginStateImpl;
  const _FailureLoginState._() : super._();

  AppException get exception;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureLoginStateImplCopyWith<_$FailureLoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
