// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_register_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthRegisterRequestBody _$AuthRegisterRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _AuthRegisterRequestBody.fromJson(json);
}

/// @nodoc
mixin _$AuthRegisterRequestBody {
  String get phone => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this AuthRegisterRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthRegisterRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthRegisterRequestBodyCopyWith<AuthRegisterRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthRegisterRequestBodyCopyWith<$Res> {
  factory $AuthRegisterRequestBodyCopyWith(AuthRegisterRequestBody value,
          $Res Function(AuthRegisterRequestBody) then) =
      _$AuthRegisterRequestBodyCopyWithImpl<$Res, AuthRegisterRequestBody>;
  @useResult
  $Res call({String phone, String password});
}

/// @nodoc
class _$AuthRegisterRequestBodyCopyWithImpl<$Res,
        $Val extends AuthRegisterRequestBody>
    implements $AuthRegisterRequestBodyCopyWith<$Res> {
  _$AuthRegisterRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthRegisterRequestBody
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
abstract class _$$AuthRegisterRequestBodyImplCopyWith<$Res>
    implements $AuthRegisterRequestBodyCopyWith<$Res> {
  factory _$$AuthRegisterRequestBodyImplCopyWith(
          _$AuthRegisterRequestBodyImpl value,
          $Res Function(_$AuthRegisterRequestBodyImpl) then) =
      __$$AuthRegisterRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String password});
}

/// @nodoc
class __$$AuthRegisterRequestBodyImplCopyWithImpl<$Res>
    extends _$AuthRegisterRequestBodyCopyWithImpl<$Res,
        _$AuthRegisterRequestBodyImpl>
    implements _$$AuthRegisterRequestBodyImplCopyWith<$Res> {
  __$$AuthRegisterRequestBodyImplCopyWithImpl(
      _$AuthRegisterRequestBodyImpl _value,
      $Res Function(_$AuthRegisterRequestBodyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthRegisterRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_$AuthRegisterRequestBodyImpl(
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
class _$AuthRegisterRequestBodyImpl implements _AuthRegisterRequestBody {
  const _$AuthRegisterRequestBodyImpl(
      {required this.phone, required this.password});

  factory _$AuthRegisterRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthRegisterRequestBodyImplFromJson(json);

  @override
  final String phone;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthRegisterRequestBody(phone: $phone, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthRegisterRequestBodyImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, password);

  /// Create a copy of AuthRegisterRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthRegisterRequestBodyImplCopyWith<_$AuthRegisterRequestBodyImpl>
      get copyWith => __$$AuthRegisterRequestBodyImplCopyWithImpl<
          _$AuthRegisterRequestBodyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthRegisterRequestBodyImplToJson(
      this,
    );
  }
}

abstract class _AuthRegisterRequestBody implements AuthRegisterRequestBody {
  const factory _AuthRegisterRequestBody(
      {required final String phone,
      required final String password}) = _$AuthRegisterRequestBodyImpl;

  factory _AuthRegisterRequestBody.fromJson(Map<String, dynamic> json) =
      _$AuthRegisterRequestBodyImpl.fromJson;

  @override
  String get phone;
  @override
  String get password;

  /// Create a copy of AuthRegisterRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthRegisterRequestBodyImplCopyWith<_$AuthRegisterRequestBodyImpl>
      get copyWith => throw _privateConstructorUsedError;
}
