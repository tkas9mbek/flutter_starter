// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InputApiError _$InputApiErrorFromJson(Map<String, dynamic> json) {
  return _InputApiError.fromJson(json);
}

/// @nodoc
mixin _$InputApiError {
  String get field => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InputApiErrorCopyWith<InputApiError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputApiErrorCopyWith<$Res> {
  factory $InputApiErrorCopyWith(
          InputApiError value, $Res Function(InputApiError) then) =
      _$InputApiErrorCopyWithImpl<$Res, InputApiError>;
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class _$InputApiErrorCopyWithImpl<$Res, $Val extends InputApiError>
    implements $InputApiErrorCopyWith<$Res> {
  _$InputApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InputApiErrorImplCopyWith<$Res>
    implements $InputApiErrorCopyWith<$Res> {
  factory _$$InputApiErrorImplCopyWith(
          _$InputApiErrorImpl value, $Res Function(_$InputApiErrorImpl) then) =
      __$$InputApiErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class __$$InputApiErrorImplCopyWithImpl<$Res>
    extends _$InputApiErrorCopyWithImpl<$Res, _$InputApiErrorImpl>
    implements _$$InputApiErrorImplCopyWith<$Res> {
  __$$InputApiErrorImplCopyWithImpl(
      _$InputApiErrorImpl _value, $Res Function(_$InputApiErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? message = null,
  }) {
    return _then(_$InputApiErrorImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InputApiErrorImpl implements _InputApiError {
  const _$InputApiErrorImpl({required this.field, required this.message});

  factory _$InputApiErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputApiErrorImplFromJson(json);

  @override
  final String field;
  @override
  final String message;

  @override
  String toString() {
    return 'InputApiError(field: $field, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputApiErrorImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, field, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputApiErrorImplCopyWith<_$InputApiErrorImpl> get copyWith =>
      __$$InputApiErrorImplCopyWithImpl<_$InputApiErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputApiErrorImplToJson(
      this,
    );
  }
}

abstract class _InputApiError implements InputApiError {
  const factory _InputApiError(
      {required final String field,
      required final String message}) = _$InputApiErrorImpl;

  factory _InputApiError.fromJson(Map<String, dynamic> json) =
      _$InputApiErrorImpl.fromJson;

  @override
  String get field;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$InputApiErrorImplCopyWith<_$InputApiErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
