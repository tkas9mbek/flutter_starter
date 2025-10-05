// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_login_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthLoginRequestBody _$AuthLoginRequestBodyFromJson(Map<String, dynamic> json) {
  return _AuthLoginRequestBody.fromJson(json);
}

/// @nodoc
mixin _$AuthLoginRequestBody {
  String get phone => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this AuthLoginRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthLoginRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthLoginRequestBodyCopyWith<AuthLoginRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthLoginRequestBodyCopyWith<$Res> {
  factory $AuthLoginRequestBodyCopyWith(AuthLoginRequestBody value,
          $Res Function(AuthLoginRequestBody) then) =
      _$AuthLoginRequestBodyCopyWithImpl<$Res, AuthLoginRequestBody>;
  @useResult
  $Res call({String phone, String password});
}

/// @nodoc
class _$AuthLoginRequestBodyCopyWithImpl<$Res,
        $Val extends AuthLoginRequestBody>
    implements $AuthLoginRequestBodyCopyWith<$Res> {
  _$AuthLoginRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthLoginRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthLoginRequestBodyImplCopyWith<$Res>
    implements $AuthLoginRequestBodyCopyWith<$Res> {
  factory _$$AuthLoginRequestBodyImplCopyWith(_$AuthLoginRequestBodyImpl value,
          $Res Function(_$AuthLoginRequestBodyImpl) then) =
      __$$AuthLoginRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String password});
}

/// @nodoc
class __$$AuthLoginRequestBodyImplCopyWithImpl<$Res>
    extends _$AuthLoginRequestBodyCopyWithImpl<$Res, _$AuthLoginRequestBodyImpl>
    implements _$$AuthLoginRequestBodyImplCopyWith<$Res> {
  __$$AuthLoginRequestBodyImplCopyWithImpl(_$AuthLoginRequestBodyImpl _value,
      $Res Function(_$AuthLoginRequestBodyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthLoginRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_$AuthLoginRequestBodyImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthLoginRequestBodyImpl implements _AuthLoginRequestBody {
  const _$AuthLoginRequestBodyImpl(
      {required this.phone, required this.password});

  factory _$AuthLoginRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthLoginRequestBodyImplFromJson(json);

  @override
  final String phone;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthLoginRequestBody(phone: $phone, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoginRequestBodyImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, password);

  /// Create a copy of AuthLoginRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoginRequestBodyImplCopyWith<_$AuthLoginRequestBodyImpl>
      get copyWith =>
          __$$AuthLoginRequestBodyImplCopyWithImpl<_$AuthLoginRequestBodyImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthLoginRequestBodyImplToJson(
      this,
    );
  }
}

abstract class _AuthLoginRequestBody implements AuthLoginRequestBody {
  const factory _AuthLoginRequestBody(
      {required final String phone,
      required final String password}) = _$AuthLoginRequestBodyImpl;

  factory _AuthLoginRequestBody.fromJson(Map<String, dynamic> json) =
      _$AuthLoginRequestBodyImpl.fromJson;

  @override
  String get phone;
  @override
  String get password;

  /// Create a copy of AuthLoginRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthLoginRequestBodyImplCopyWith<_$AuthLoginRequestBodyImpl>
      get copyWith => throw _privateConstructorUsedError;
}
