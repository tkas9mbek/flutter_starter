// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_verify_otp_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthVerifyOtpRequestBody {

 String get phone; String get otp;
/// Create a copy of AuthVerifyOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthVerifyOtpRequestBodyCopyWith<AuthVerifyOtpRequestBody> get copyWith => _$AuthVerifyOtpRequestBodyCopyWithImpl<AuthVerifyOtpRequestBody>(this as AuthVerifyOtpRequestBody, _$identity);

  /// Serializes this AuthVerifyOtpRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthVerifyOtpRequestBody&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone,otp);

@override
String toString() {
  return 'AuthVerifyOtpRequestBody(phone: $phone, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $AuthVerifyOtpRequestBodyCopyWith<$Res>  {
  factory $AuthVerifyOtpRequestBodyCopyWith(AuthVerifyOtpRequestBody value, $Res Function(AuthVerifyOtpRequestBody) _then) = _$AuthVerifyOtpRequestBodyCopyWithImpl;
@useResult
$Res call({
 String phone, String otp
});




}
/// @nodoc
class _$AuthVerifyOtpRequestBodyCopyWithImpl<$Res>
    implements $AuthVerifyOtpRequestBodyCopyWith<$Res> {
  _$AuthVerifyOtpRequestBodyCopyWithImpl(this._self, this._then);

  final AuthVerifyOtpRequestBody _self;
  final $Res Function(AuthVerifyOtpRequestBody) _then;

/// Create a copy of AuthVerifyOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? otp = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthVerifyOtpRequestBody].
extension AuthVerifyOtpRequestBodyPatterns on AuthVerifyOtpRequestBody {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthVerifyOtpRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthVerifyOtpRequestBody() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthVerifyOtpRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _AuthVerifyOtpRequestBody():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthVerifyOtpRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _AuthVerifyOtpRequestBody() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone,  String otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthVerifyOtpRequestBody() when $default != null:
return $default(_that.phone,_that.otp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone,  String otp)  $default,) {final _that = this;
switch (_that) {
case _AuthVerifyOtpRequestBody():
return $default(_that.phone,_that.otp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone,  String otp)?  $default,) {final _that = this;
switch (_that) {
case _AuthVerifyOtpRequestBody() when $default != null:
return $default(_that.phone,_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthVerifyOtpRequestBody implements AuthVerifyOtpRequestBody {
  const _AuthVerifyOtpRequestBody({required this.phone, required this.otp});
  factory _AuthVerifyOtpRequestBody.fromJson(Map<String, dynamic> json) => _$AuthVerifyOtpRequestBodyFromJson(json);

@override final  String phone;
@override final  String otp;

/// Create a copy of AuthVerifyOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthVerifyOtpRequestBodyCopyWith<_AuthVerifyOtpRequestBody> get copyWith => __$AuthVerifyOtpRequestBodyCopyWithImpl<_AuthVerifyOtpRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthVerifyOtpRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthVerifyOtpRequestBody&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone,otp);

@override
String toString() {
  return 'AuthVerifyOtpRequestBody(phone: $phone, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$AuthVerifyOtpRequestBodyCopyWith<$Res> implements $AuthVerifyOtpRequestBodyCopyWith<$Res> {
  factory _$AuthVerifyOtpRequestBodyCopyWith(_AuthVerifyOtpRequestBody value, $Res Function(_AuthVerifyOtpRequestBody) _then) = __$AuthVerifyOtpRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String phone, String otp
});




}
/// @nodoc
class __$AuthVerifyOtpRequestBodyCopyWithImpl<$Res>
    implements _$AuthVerifyOtpRequestBodyCopyWith<$Res> {
  __$AuthVerifyOtpRequestBodyCopyWithImpl(this._self, this._then);

  final _AuthVerifyOtpRequestBody _self;
  final $Res Function(_AuthVerifyOtpRequestBody) _then;

/// Create a copy of AuthVerifyOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? otp = null,}) {
  return _then(_AuthVerifyOtpRequestBody(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
