// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_register_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthRegisterRequestBody {

 String get name; String get phone; String get password; DateTime get birthday;
/// Create a copy of AuthRegisterRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthRegisterRequestBodyCopyWith<AuthRegisterRequestBody> get copyWith => _$AuthRegisterRequestBodyCopyWithImpl<AuthRegisterRequestBody>(this as AuthRegisterRequestBody, _$identity);

  /// Serializes this AuthRegisterRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthRegisterRequestBody&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.birthday, birthday) || other.birthday == birthday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone,password,birthday);

@override
String toString() {
  return 'AuthRegisterRequestBody(name: $name, phone: $phone, password: $password, birthday: $birthday)';
}


}

/// @nodoc
abstract mixin class $AuthRegisterRequestBodyCopyWith<$Res>  {
  factory $AuthRegisterRequestBodyCopyWith(AuthRegisterRequestBody value, $Res Function(AuthRegisterRequestBody) _then) = _$AuthRegisterRequestBodyCopyWithImpl;
@useResult
$Res call({
 String name, String phone, String password, DateTime birthday
});




}
/// @nodoc
class _$AuthRegisterRequestBodyCopyWithImpl<$Res>
    implements $AuthRegisterRequestBodyCopyWith<$Res> {
  _$AuthRegisterRequestBodyCopyWithImpl(this._self, this._then);

  final AuthRegisterRequestBody _self;
  final $Res Function(AuthRegisterRequestBody) _then;

/// Create a copy of AuthRegisterRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = null,Object? password = null,Object? birthday = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthRegisterRequestBody].
extension AuthRegisterRequestBodyPatterns on AuthRegisterRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthRegisterRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthRegisterRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthRegisterRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _AuthRegisterRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthRegisterRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _AuthRegisterRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String phone,  String password,  DateTime birthday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthRegisterRequestBody() when $default != null:
return $default(_that.name,_that.phone,_that.password,_that.birthday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String phone,  String password,  DateTime birthday)  $default,) {final _that = this;
switch (_that) {
case _AuthRegisterRequestBody():
return $default(_that.name,_that.phone,_that.password,_that.birthday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String phone,  String password,  DateTime birthday)?  $default,) {final _that = this;
switch (_that) {
case _AuthRegisterRequestBody() when $default != null:
return $default(_that.name,_that.phone,_that.password,_that.birthday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthRegisterRequestBody implements AuthRegisterRequestBody {
  const _AuthRegisterRequestBody({required this.name, required this.phone, required this.password, required this.birthday});
  factory _AuthRegisterRequestBody.fromJson(Map<String, dynamic> json) => _$AuthRegisterRequestBodyFromJson(json);

@override final  String name;
@override final  String phone;
@override final  String password;
@override final  DateTime birthday;

/// Create a copy of AuthRegisterRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthRegisterRequestBodyCopyWith<_AuthRegisterRequestBody> get copyWith => __$AuthRegisterRequestBodyCopyWithImpl<_AuthRegisterRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthRegisterRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthRegisterRequestBody&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.birthday, birthday) || other.birthday == birthday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone,password,birthday);

@override
String toString() {
  return 'AuthRegisterRequestBody(name: $name, phone: $phone, password: $password, birthday: $birthday)';
}


}

/// @nodoc
abstract mixin class _$AuthRegisterRequestBodyCopyWith<$Res> implements $AuthRegisterRequestBodyCopyWith<$Res> {
  factory _$AuthRegisterRequestBodyCopyWith(_AuthRegisterRequestBody value, $Res Function(_AuthRegisterRequestBody) _then) = __$AuthRegisterRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String name, String phone, String password, DateTime birthday
});




}
/// @nodoc
class __$AuthRegisterRequestBodyCopyWithImpl<$Res>
    implements _$AuthRegisterRequestBodyCopyWith<$Res> {
  __$AuthRegisterRequestBodyCopyWithImpl(this._self, this._then);

  final _AuthRegisterRequestBody _self;
  final $Res Function(_AuthRegisterRequestBody) _then;

/// Create a copy of AuthRegisterRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? password = null,Object? birthday = null,}) {
  return _then(_AuthRegisterRequestBody(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
