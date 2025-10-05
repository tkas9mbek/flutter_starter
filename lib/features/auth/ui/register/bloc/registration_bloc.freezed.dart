// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegistrationEvent {
  RegistrationForm get form => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RegistrationForm form) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RegistrationForm form)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RegistrationForm form)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubmittedRegistrationEvent value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmittedRegistrationEvent value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmittedRegistrationEvent value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegistrationEventCopyWith<RegistrationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationEventCopyWith<$Res> {
  factory $RegistrationEventCopyWith(
          RegistrationEvent value, $Res Function(RegistrationEvent) then) =
      _$RegistrationEventCopyWithImpl<$Res, RegistrationEvent>;
  @useResult
  $Res call({RegistrationForm form});
}

/// @nodoc
class _$RegistrationEventCopyWithImpl<$Res, $Val extends RegistrationEvent>
    implements $RegistrationEventCopyWith<$Res> {
  _$RegistrationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationEvent
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
              as RegistrationForm,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmittedRegistrationEventImplCopyWith<$Res>
    implements $RegistrationEventCopyWith<$Res> {
  factory _$$SubmittedRegistrationEventImplCopyWith(
          _$SubmittedRegistrationEventImpl value,
          $Res Function(_$SubmittedRegistrationEventImpl) then) =
      __$$SubmittedRegistrationEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RegistrationForm form});
}

/// @nodoc
class __$$SubmittedRegistrationEventImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res,
        _$SubmittedRegistrationEventImpl>
    implements _$$SubmittedRegistrationEventImplCopyWith<$Res> {
  __$$SubmittedRegistrationEventImplCopyWithImpl(
      _$SubmittedRegistrationEventImpl _value,
      $Res Function(_$SubmittedRegistrationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
  }) {
    return _then(_$SubmittedRegistrationEventImpl(
      null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as RegistrationForm,
    ));
  }
}

/// @nodoc

class _$SubmittedRegistrationEventImpl implements _SubmittedRegistrationEvent {
  const _$SubmittedRegistrationEventImpl(this.form);

  @override
  final RegistrationForm form;

  @override
  String toString() {
    return 'RegistrationEvent.submitted(form: $form)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmittedRegistrationEventImpl &&
            (identical(other.form, form) || other.form == form));
  }

  @override
  int get hashCode => Object.hash(runtimeType, form);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmittedRegistrationEventImplCopyWith<_$SubmittedRegistrationEventImpl>
      get copyWith => __$$SubmittedRegistrationEventImplCopyWithImpl<
          _$SubmittedRegistrationEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RegistrationForm form) submitted,
  }) {
    return submitted(form);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RegistrationForm form)? submitted,
  }) {
    return submitted?.call(form);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RegistrationForm form)? submitted,
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
    required TResult Function(_SubmittedRegistrationEvent value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmittedRegistrationEvent value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmittedRegistrationEvent value)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class _SubmittedRegistrationEvent implements RegistrationEvent {
  const factory _SubmittedRegistrationEvent(final RegistrationForm form) =
      _$SubmittedRegistrationEventImpl;

  @override
  RegistrationForm get form;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmittedRegistrationEventImplCopyWith<_$SubmittedRegistrationEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegistrationState {
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
    required TResult Function(_InitialRegistrationState value) initial,
    required TResult Function(_LoadingRegistrationState value) loading,
    required TResult Function(_SuccessRegistrationState value) success,
    required TResult Function(_FailureRegistrationState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialRegistrationState value)? initial,
    TResult? Function(_LoadingRegistrationState value)? loading,
    TResult? Function(_SuccessRegistrationState value)? success,
    TResult? Function(_FailureRegistrationState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialRegistrationState value)? initial,
    TResult Function(_LoadingRegistrationState value)? loading,
    TResult Function(_SuccessRegistrationState value)? success,
    TResult Function(_FailureRegistrationState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationStateCopyWith<$Res> {
  factory $RegistrationStateCopyWith(
          RegistrationState value, $Res Function(RegistrationState) then) =
      _$RegistrationStateCopyWithImpl<$Res, RegistrationState>;
}

/// @nodoc
class _$RegistrationStateCopyWithImpl<$Res, $Val extends RegistrationState>
    implements $RegistrationStateCopyWith<$Res> {
  _$RegistrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialRegistrationStateImplCopyWith<$Res> {
  factory _$$InitialRegistrationStateImplCopyWith(
          _$InitialRegistrationStateImpl value,
          $Res Function(_$InitialRegistrationStateImpl) then) =
      __$$InitialRegistrationStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialRegistrationStateImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res,
        _$InitialRegistrationStateImpl>
    implements _$$InitialRegistrationStateImplCopyWith<$Res> {
  __$$InitialRegistrationStateImplCopyWithImpl(
      _$InitialRegistrationStateImpl _value,
      $Res Function(_$InitialRegistrationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialRegistrationStateImpl extends _InitialRegistrationState {
  const _$InitialRegistrationStateImpl() : super._();

  @override
  String toString() {
    return 'RegistrationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialRegistrationStateImpl);
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
    required TResult Function(_InitialRegistrationState value) initial,
    required TResult Function(_LoadingRegistrationState value) loading,
    required TResult Function(_SuccessRegistrationState value) success,
    required TResult Function(_FailureRegistrationState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialRegistrationState value)? initial,
    TResult? Function(_LoadingRegistrationState value)? loading,
    TResult? Function(_SuccessRegistrationState value)? success,
    TResult? Function(_FailureRegistrationState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialRegistrationState value)? initial,
    TResult Function(_LoadingRegistrationState value)? loading,
    TResult Function(_SuccessRegistrationState value)? success,
    TResult Function(_FailureRegistrationState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialRegistrationState extends RegistrationState {
  const factory _InitialRegistrationState() = _$InitialRegistrationStateImpl;
  const _InitialRegistrationState._() : super._();
}

/// @nodoc
abstract class _$$LoadingRegistrationStateImplCopyWith<$Res> {
  factory _$$LoadingRegistrationStateImplCopyWith(
          _$LoadingRegistrationStateImpl value,
          $Res Function(_$LoadingRegistrationStateImpl) then) =
      __$$LoadingRegistrationStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingRegistrationStateImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res,
        _$LoadingRegistrationStateImpl>
    implements _$$LoadingRegistrationStateImplCopyWith<$Res> {
  __$$LoadingRegistrationStateImplCopyWithImpl(
      _$LoadingRegistrationStateImpl _value,
      $Res Function(_$LoadingRegistrationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingRegistrationStateImpl extends _LoadingRegistrationState {
  const _$LoadingRegistrationStateImpl() : super._();

  @override
  String toString() {
    return 'RegistrationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingRegistrationStateImpl);
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
    required TResult Function(_InitialRegistrationState value) initial,
    required TResult Function(_LoadingRegistrationState value) loading,
    required TResult Function(_SuccessRegistrationState value) success,
    required TResult Function(_FailureRegistrationState value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialRegistrationState value)? initial,
    TResult? Function(_LoadingRegistrationState value)? loading,
    TResult? Function(_SuccessRegistrationState value)? success,
    TResult? Function(_FailureRegistrationState value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialRegistrationState value)? initial,
    TResult Function(_LoadingRegistrationState value)? loading,
    TResult Function(_SuccessRegistrationState value)? success,
    TResult Function(_FailureRegistrationState value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingRegistrationState extends RegistrationState {
  const factory _LoadingRegistrationState() = _$LoadingRegistrationStateImpl;
  const _LoadingRegistrationState._() : super._();
}

/// @nodoc
abstract class _$$SuccessRegistrationStateImplCopyWith<$Res> {
  factory _$$SuccessRegistrationStateImplCopyWith(
          _$SuccessRegistrationStateImpl value,
          $Res Function(_$SuccessRegistrationStateImpl) then) =
      __$$SuccessRegistrationStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessRegistrationStateImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res,
        _$SuccessRegistrationStateImpl>
    implements _$$SuccessRegistrationStateImplCopyWith<$Res> {
  __$$SuccessRegistrationStateImplCopyWithImpl(
      _$SuccessRegistrationStateImpl _value,
      $Res Function(_$SuccessRegistrationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessRegistrationStateImpl extends _SuccessRegistrationState {
  const _$SuccessRegistrationStateImpl() : super._();

  @override
  String toString() {
    return 'RegistrationState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessRegistrationStateImpl);
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
    required TResult Function(_InitialRegistrationState value) initial,
    required TResult Function(_LoadingRegistrationState value) loading,
    required TResult Function(_SuccessRegistrationState value) success,
    required TResult Function(_FailureRegistrationState value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialRegistrationState value)? initial,
    TResult? Function(_LoadingRegistrationState value)? loading,
    TResult? Function(_SuccessRegistrationState value)? success,
    TResult? Function(_FailureRegistrationState value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialRegistrationState value)? initial,
    TResult Function(_LoadingRegistrationState value)? loading,
    TResult Function(_SuccessRegistrationState value)? success,
    TResult Function(_FailureRegistrationState value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessRegistrationState extends RegistrationState {
  const factory _SuccessRegistrationState() = _$SuccessRegistrationStateImpl;
  const _SuccessRegistrationState._() : super._();
}

/// @nodoc
abstract class _$$FailureRegistrationStateImplCopyWith<$Res> {
  factory _$$FailureRegistrationStateImplCopyWith(
          _$FailureRegistrationStateImpl value,
          $Res Function(_$FailureRegistrationStateImpl) then) =
      __$$FailureRegistrationStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureRegistrationStateImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res,
        _$FailureRegistrationStateImpl>
    implements _$$FailureRegistrationStateImplCopyWith<$Res> {
  __$$FailureRegistrationStateImplCopyWithImpl(
      _$FailureRegistrationStateImpl _value,
      $Res Function(_$FailureRegistrationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureRegistrationStateImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureRegistrationStateImpl extends _FailureRegistrationState {
  const _$FailureRegistrationStateImpl(this.exception) : super._();

  @override
  final AppException exception;

  @override
  String toString() {
    return 'RegistrationState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureRegistrationStateImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureRegistrationStateImplCopyWith<_$FailureRegistrationStateImpl>
      get copyWith => __$$FailureRegistrationStateImplCopyWithImpl<
          _$FailureRegistrationStateImpl>(this, _$identity);

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
    required TResult Function(_InitialRegistrationState value) initial,
    required TResult Function(_LoadingRegistrationState value) loading,
    required TResult Function(_SuccessRegistrationState value) success,
    required TResult Function(_FailureRegistrationState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialRegistrationState value)? initial,
    TResult? Function(_LoadingRegistrationState value)? loading,
    TResult? Function(_SuccessRegistrationState value)? success,
    TResult? Function(_FailureRegistrationState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialRegistrationState value)? initial,
    TResult Function(_LoadingRegistrationState value)? loading,
    TResult Function(_SuccessRegistrationState value)? success,
    TResult Function(_FailureRegistrationState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureRegistrationState extends RegistrationState {
  const factory _FailureRegistrationState(final AppException exception) =
      _$FailureRegistrationStateImpl;
  const _FailureRegistrationState._() : super._();

  AppException get exception;

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureRegistrationStateImplCopyWith<_$FailureRegistrationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
