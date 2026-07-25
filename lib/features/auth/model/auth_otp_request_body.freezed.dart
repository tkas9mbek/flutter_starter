// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_otp_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthOtpRequestBody {

 String get phone;
/// Create a copy of AuthOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthOtpRequestBodyCopyWith<AuthOtpRequestBody> get copyWith => _$AuthOtpRequestBodyCopyWithImpl<AuthOtpRequestBody>(this as AuthOtpRequestBody, _$identity);

  /// Serializes this AuthOtpRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOtpRequestBody&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'AuthOtpRequestBody(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $AuthOtpRequestBodyCopyWith<$Res>  {
  factory $AuthOtpRequestBodyCopyWith(AuthOtpRequestBody value, $Res Function(AuthOtpRequestBody) _then) = _$AuthOtpRequestBodyCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$AuthOtpRequestBodyCopyWithImpl<$Res>
    implements $AuthOtpRequestBodyCopyWith<$Res> {
  _$AuthOtpRequestBodyCopyWithImpl(this._self, this._then);

  final AuthOtpRequestBody _self;
  final $Res Function(AuthOtpRequestBody) _then;

/// Create a copy of AuthOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthOtpRequestBody].
extension AuthOtpRequestBodyPatterns on AuthOtpRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthOtpRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthOtpRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthOtpRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _AuthOtpRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthOtpRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _AuthOtpRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthOtpRequestBody() when $default != null:
return $default(_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone)  $default,) {final _that = this;
switch (_that) {
case _AuthOtpRequestBody():
return $default(_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone)?  $default,) {final _that = this;
switch (_that) {
case _AuthOtpRequestBody() when $default != null:
return $default(_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthOtpRequestBody implements AuthOtpRequestBody {
  const _AuthOtpRequestBody({required this.phone});
  factory _AuthOtpRequestBody.fromJson(Map<String, dynamic> json) => _$AuthOtpRequestBodyFromJson(json);

@override final  String phone;

/// Create a copy of AuthOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthOtpRequestBodyCopyWith<_AuthOtpRequestBody> get copyWith => __$AuthOtpRequestBodyCopyWithImpl<_AuthOtpRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthOtpRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthOtpRequestBody&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'AuthOtpRequestBody(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$AuthOtpRequestBodyCopyWith<$Res> implements $AuthOtpRequestBodyCopyWith<$Res> {
  factory _$AuthOtpRequestBodyCopyWith(_AuthOtpRequestBody value, $Res Function(_AuthOtpRequestBody) _then) = __$AuthOtpRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$AuthOtpRequestBodyCopyWithImpl<$Res>
    implements _$AuthOtpRequestBodyCopyWith<$Res> {
  __$AuthOtpRequestBodyCopyWithImpl(this._self, this._then);

  final _AuthOtpRequestBody _self;
  final $Res Function(_AuthOtpRequestBody) _then;

/// Create a copy of AuthOtpRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_AuthOtpRequestBody(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
