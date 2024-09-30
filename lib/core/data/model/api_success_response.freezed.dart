// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_success_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiSuccessResponse _$ApiSuccessResponseFromJson(Map<String, dynamic> json) {
  return _ApiSuccessResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiSuccessResponse {
  bool get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiSuccessResponseCopyWith<ApiSuccessResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiSuccessResponseCopyWith<$Res> {
  factory $ApiSuccessResponseCopyWith(
          ApiSuccessResponse value, $Res Function(ApiSuccessResponse) then) =
      _$ApiSuccessResponseCopyWithImpl<$Res, ApiSuccessResponse>;
  @useResult
  $Res call({bool success});
}

/// @nodoc
class _$ApiSuccessResponseCopyWithImpl<$Res, $Val extends ApiSuccessResponse>
    implements $ApiSuccessResponseCopyWith<$Res> {
  _$ApiSuccessResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiSuccessResponseImplCopyWith<$Res>
    implements $ApiSuccessResponseCopyWith<$Res> {
  factory _$$ApiSuccessResponseImplCopyWith(_$ApiSuccessResponseImpl value,
          $Res Function(_$ApiSuccessResponseImpl) then) =
      __$$ApiSuccessResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success});
}

/// @nodoc
class __$$ApiSuccessResponseImplCopyWithImpl<$Res>
    extends _$ApiSuccessResponseCopyWithImpl<$Res, _$ApiSuccessResponseImpl>
    implements _$$ApiSuccessResponseImplCopyWith<$Res> {
  __$$ApiSuccessResponseImplCopyWithImpl(_$ApiSuccessResponseImpl _value,
      $Res Function(_$ApiSuccessResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
  }) {
    return _then(_$ApiSuccessResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$ApiSuccessResponseImpl implements _ApiSuccessResponse {
  _$ApiSuccessResponseImpl({required this.success});

  factory _$ApiSuccessResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiSuccessResponseImplFromJson(json);

  @override
  final bool success;

  @override
  String toString() {
    return 'ApiSuccessResponse(success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSuccessResponseImpl &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSuccessResponseImplCopyWith<_$ApiSuccessResponseImpl> get copyWith =>
      __$$ApiSuccessResponseImplCopyWithImpl<_$ApiSuccessResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiSuccessResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiSuccessResponse implements ApiSuccessResponse {
  factory _ApiSuccessResponse({required final bool success}) =
      _$ApiSuccessResponseImpl;

  factory _ApiSuccessResponse.fromJson(Map<String, dynamic> json) =
      _$ApiSuccessResponseImpl.fromJson;

  @override
  bool get success;
  @override
  @JsonKey(ignore: true)
  _$$ApiSuccessResponseImplCopyWith<_$ApiSuccessResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
