// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

/// @nodoc
mixin _$AppException {}

/// @nodoc
abstract class $AppExceptionCopyWith<$Res> {
  factory $AppExceptionCopyWith(
          AppException value, $Res Function(AppException) then) =
      _$AppExceptionCopyWithImpl<$Res, AppException>;
}

/// @nodoc
class _$AppExceptionCopyWithImpl<$Res, $Val extends AppException>
    implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call() {
    return _then(_value);
  }
}

/// @nodoc
abstract class _$$NoInternetAppExceptionImplCopyWith<$Res> {
  factory _$$NoInternetAppExceptionImplCopyWith(
          _$NoInternetAppExceptionImpl value,
          $Res Function(_$NoInternetAppExceptionImpl) then) =
      __$$NoInternetAppExceptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoInternetAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$NoInternetAppExceptionImpl>
    implements _$$NoInternetAppExceptionImplCopyWith<$Res> {
  __$$NoInternetAppExceptionImplCopyWithImpl(
      _$NoInternetAppExceptionImpl _value,
      $Res Function(_$NoInternetAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call() {
    return _then(_$NoInternetAppExceptionImpl());
  }
}

/// @nodoc
class _$NoInternetAppExceptionImpl extends _NoInternetAppException {
  const _$NoInternetAppExceptionImpl() : super._();

  @override
  String toString() {
    return 'AppException.noInternet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoInternetAppExceptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return noInternet();
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return noInternet?.call();
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet();
    }
    return orElse();
  }
}

abstract class _NoInternetAppException extends AppException {
  const factory _NoInternetAppException() = _$NoInternetAppExceptionImpl;
  const _NoInternetAppException._() : super._();
}

/// @nodoc
abstract class _$$ServerAppExceptionImplCopyWith<$Res> {
  factory _$$ServerAppExceptionImplCopyWith(_$ServerAppExceptionImpl value,
          $Res Function(_$ServerAppExceptionImpl) then) =
      __$$ServerAppExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? statusCode, String? message});
}

/// @nodoc
class __$$ServerAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$ServerAppExceptionImpl>
    implements _$$ServerAppExceptionImplCopyWith<$Res> {
  __$$ServerAppExceptionImplCopyWithImpl(_$ServerAppExceptionImpl _value,
      $Res Function(_$ServerAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ServerAppExceptionImpl(
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode as int?,
      message: freezed == message ? _value.message : message as String?,
    ));
  }
}

/// @nodoc
class _$ServerAppExceptionImpl extends _ServerAppException {
  const _$ServerAppExceptionImpl({this.statusCode, this.message}) : super._();

  @override
  final int? statusCode;
  @override
  final String? message;

  @override
  String toString() {
    return 'AppException.server(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerAppExceptionImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerAppExceptionImplCopyWith<_$ServerAppExceptionImpl> get copyWith =>
      __$$ServerAppExceptionImplCopyWithImpl<_$ServerAppExceptionImpl>(
          this, _$identity);

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return server(statusCode, message);
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return server?.call(statusCode, message);
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(statusCode, message);
    }
    return orElse();
  }
}

abstract class _ServerAppException extends AppException {
  const factory _ServerAppException({final int? statusCode, final String? message}) =
      _$ServerAppExceptionImpl;
  const _ServerAppException._() : super._();

  int? get statusCode;
  String? get message;

  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerAppExceptionImplCopyWith<_$ServerAppExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedAppExceptionImplCopyWith<$Res> {
  factory _$$UnauthorizedAppExceptionImplCopyWith(
          _$UnauthorizedAppExceptionImpl value,
          $Res Function(_$UnauthorizedAppExceptionImpl) then) =
      __$$UnauthorizedAppExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UnauthorizedAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$UnauthorizedAppExceptionImpl>
    implements _$$UnauthorizedAppExceptionImplCopyWith<$Res> {
  __$$UnauthorizedAppExceptionImplCopyWithImpl(
      _$UnauthorizedAppExceptionImpl _value,
      $Res Function(_$UnauthorizedAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UnauthorizedAppExceptionImpl(
      message: freezed == message ? _value.message : message as String?,
    ));
  }
}

/// @nodoc
class _$UnauthorizedAppExceptionImpl extends _UnauthorizedAppException {
  const _$UnauthorizedAppExceptionImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AppException.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedAppExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedAppExceptionImplCopyWith<_$UnauthorizedAppExceptionImpl>
      get copyWith => __$$UnauthorizedAppExceptionImplCopyWithImpl<
          _$UnauthorizedAppExceptionImpl>(this, _$identity);

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return unauthorized(message);
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return unauthorized?.call(message);
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }
}

abstract class _UnauthorizedAppException extends AppException {
  const factory _UnauthorizedAppException({final String? message}) =
      _$UnauthorizedAppExceptionImpl;
  const _UnauthorizedAppException._() : super._();

  String? get message;
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnauthorizedAppExceptionImplCopyWith<_$UnauthorizedAppExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForbiddenAppExceptionImplCopyWith<$Res> {
  factory _$$ForbiddenAppExceptionImplCopyWith(
          _$ForbiddenAppExceptionImpl value,
          $Res Function(_$ForbiddenAppExceptionImpl) then) =
      __$$ForbiddenAppExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ForbiddenAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$ForbiddenAppExceptionImpl>
    implements _$$ForbiddenAppExceptionImplCopyWith<$Res> {
  __$$ForbiddenAppExceptionImplCopyWithImpl(
      _$ForbiddenAppExceptionImpl _value,
      $Res Function(_$ForbiddenAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ForbiddenAppExceptionImpl(
      message: freezed == message ? _value.message : message as String?,
    ));
  }
}

/// @nodoc
class _$ForbiddenAppExceptionImpl extends _ForbiddenAppException {
  const _$ForbiddenAppExceptionImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AppException.forbidden(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForbiddenAppExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForbiddenAppExceptionImplCopyWith<_$ForbiddenAppExceptionImpl>
      get copyWith => __$$ForbiddenAppExceptionImplCopyWithImpl<
          _$ForbiddenAppExceptionImpl>(this, _$identity);

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return forbidden(message);
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return forbidden?.call(message);
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(message);
    }
    return orElse();
  }
}

abstract class _ForbiddenAppException extends AppException {
  const factory _ForbiddenAppException({final String? message}) =
      _$ForbiddenAppExceptionImpl;
  const _ForbiddenAppException._() : super._();

  String? get message;
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForbiddenAppExceptionImplCopyWith<_$ForbiddenAppExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InternalServerErrorAppExceptionImplCopyWith<$Res> {
  factory _$$InternalServerErrorAppExceptionImplCopyWith(
          _$InternalServerErrorAppExceptionImpl value,
          $Res Function(_$InternalServerErrorAppExceptionImpl) then) =
      __$$InternalServerErrorAppExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$InternalServerErrorAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res,
        _$InternalServerErrorAppExceptionImpl>
    implements _$$InternalServerErrorAppExceptionImplCopyWith<$Res> {
  __$$InternalServerErrorAppExceptionImplCopyWithImpl(
      _$InternalServerErrorAppExceptionImpl _value,
      $Res Function(_$InternalServerErrorAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$InternalServerErrorAppExceptionImpl(
      message: freezed == message ? _value.message : message as String?,
    ));
  }
}

/// @nodoc
class _$InternalServerErrorAppExceptionImpl
    extends _InternalServerErrorAppException {
  const _$InternalServerErrorAppExceptionImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AppException.internalServerError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternalServerErrorAppExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InternalServerErrorAppExceptionImplCopyWith<
          _$InternalServerErrorAppExceptionImpl>
      get copyWith => __$$InternalServerErrorAppExceptionImplCopyWithImpl<
          _$InternalServerErrorAppExceptionImpl>(this, _$identity);

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return internalServerError(message);
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return internalServerError?.call(message);
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (internalServerError != null) {
      return internalServerError(message);
    }
    return orElse();
  }
}

abstract class _InternalServerErrorAppException extends AppException {
  const factory _InternalServerErrorAppException({final String? message}) =
      _$InternalServerErrorAppExceptionImpl;
  const _InternalServerErrorAppException._() : super._();

  String? get message;
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InternalServerErrorAppExceptionImplCopyWith<
          _$InternalServerErrorAppExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownAppExceptionImplCopyWith<$Res> {
  factory _$$UnknownAppExceptionImplCopyWith(_$UnknownAppExceptionImpl value,
          $Res Function(_$UnknownAppExceptionImpl) then) =
      __$$UnknownAppExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class __$$UnknownAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$UnknownAppExceptionImpl>
    implements _$$UnknownAppExceptionImplCopyWith<$Res> {
  __$$UnknownAppExceptionImplCopyWithImpl(_$UnknownAppExceptionImpl _value,
      $Res Function(_$UnknownAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$UnknownAppExceptionImpl(
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace as StackTrace,
    ));
  }
}

/// @nodoc
class _$UnknownAppExceptionImpl extends _UnknownAppException {
  const _$UnknownAppExceptionImpl(
      {required this.error, required this.stackTrace})
      : super._();

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'AppException.unknown(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownAppExceptionImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(error), stackTrace);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownAppExceptionImplCopyWith<_$UnknownAppExceptionImpl> get copyWith =>
      __$$UnknownAppExceptionImplCopyWithImpl<_$UnknownAppExceptionImpl>(
          this, _$identity);

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return unknown(error, stackTrace);
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return unknown?.call(error, stackTrace);
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(error, stackTrace);
    }
    return orElse();
  }
}

abstract class _UnknownAppException extends AppException {
  const factory _UnknownAppException(
      {required final Object error,
      required final StackTrace stackTrace}) = _$UnknownAppExceptionImpl;
  const _UnknownAppException._() : super._();

  Object get error;
  StackTrace get stackTrace;
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownAppExceptionImplCopyWith<_$UnknownAppExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DevelopmentAppExceptionImplCopyWith<$Res> {
  factory _$$DevelopmentAppExceptionImplCopyWith(
          _$DevelopmentAppExceptionImpl value,
          $Res Function(_$DevelopmentAppExceptionImpl) then) =
      __$$DevelopmentAppExceptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DevelopmentAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$DevelopmentAppExceptionImpl>
    implements _$$DevelopmentAppExceptionImplCopyWith<$Res> {
  __$$DevelopmentAppExceptionImplCopyWithImpl(
      _$DevelopmentAppExceptionImpl _value,
      $Res Function(_$DevelopmentAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call() {
    return _then(_$DevelopmentAppExceptionImpl());
  }
}

/// @nodoc
class _$DevelopmentAppExceptionImpl extends _DevelopmentAppException {
  const _$DevelopmentAppExceptionImpl() : super._();

  @override
  String toString() {
    return 'AppException.development()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevelopmentAppExceptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return development();
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return development?.call();
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (development != null) {
      return development();
    }
    return orElse();
  }
}

abstract class _DevelopmentAppException extends AppException {
  const factory _DevelopmentAppException() = _$DevelopmentAppExceptionImpl;
  const _DevelopmentAppException._() : super._();
}

/// @nodoc
abstract class _$$UrlLaunchFailedAppExceptionImplCopyWith<$Res> {
  factory _$$UrlLaunchFailedAppExceptionImplCopyWith(
          _$UrlLaunchFailedAppExceptionImpl value,
          $Res Function(_$UrlLaunchFailedAppExceptionImpl) then) =
      __$$UrlLaunchFailedAppExceptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UrlLaunchFailedAppExceptionImplCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res,
        _$UrlLaunchFailedAppExceptionImpl>
    implements _$$UrlLaunchFailedAppExceptionImplCopyWith<$Res> {
  __$$UrlLaunchFailedAppExceptionImplCopyWithImpl(
      _$UrlLaunchFailedAppExceptionImpl _value,
      $Res Function(_$UrlLaunchFailedAppExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call() {
    return _then(_$UrlLaunchFailedAppExceptionImpl());
  }
}

/// @nodoc
class _$UrlLaunchFailedAppExceptionImpl extends _UrlLaunchFailedAppException {
  const _$UrlLaunchFailedAppExceptionImpl() : super._();

  @override
  String toString() {
    return 'AppException.urlLaunchFailed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlLaunchFailedAppExceptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function(int? statusCode, String? message) server,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) forbidden,
    required TResult Function(String? message) internalServerError,
    required TResult Function(Object error, StackTrace stackTrace) unknown,
    required TResult Function() development,
    required TResult Function() urlLaunchFailed,
  }) {
    return urlLaunchFailed();
  }

  @override
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function(int? statusCode, String? message)? server,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? forbidden,
    TResult? Function(String? message)? internalServerError,
    TResult? Function(Object error, StackTrace stackTrace)? unknown,
    TResult? Function()? development,
    TResult? Function()? urlLaunchFailed,
  }) {
    return urlLaunchFailed?.call();
  }

  @override
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function(int? statusCode, String? message)? server,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? forbidden,
    TResult Function(String? message)? internalServerError,
    TResult Function(Object error, StackTrace stackTrace)? unknown,
    TResult Function()? development,
    TResult Function()? urlLaunchFailed,
    required TResult orElse(),
  }) {
    if (urlLaunchFailed != null) {
      return urlLaunchFailed();
    }
    return orElse();
  }
}

abstract class _UrlLaunchFailedAppException extends AppException {
  const factory _UrlLaunchFailedAppException() =
      _$UrlLaunchFailedAppExceptionImpl;
  const _UrlLaunchFailedAppException._() : super._();
}
