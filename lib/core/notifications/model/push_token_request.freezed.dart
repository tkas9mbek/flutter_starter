// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_token_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushTokenRequest {

 String get systemType; String get token;
/// Create a copy of PushTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushTokenRequestCopyWith<PushTokenRequest> get copyWith => _$PushTokenRequestCopyWithImpl<PushTokenRequest>(this as PushTokenRequest, _$identity);

  /// Serializes this PushTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushTokenRequest&&(identical(other.systemType, systemType) || other.systemType == systemType)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,systemType,token);

@override
String toString() {
  return 'PushTokenRequest(systemType: $systemType, token: $token)';
}


}

/// @nodoc
abstract mixin class $PushTokenRequestCopyWith<$Res>  {
  factory $PushTokenRequestCopyWith(PushTokenRequest value, $Res Function(PushTokenRequest) _then) = _$PushTokenRequestCopyWithImpl;
@useResult
$Res call({
 String systemType, String token
});




}
/// @nodoc
class _$PushTokenRequestCopyWithImpl<$Res>
    implements $PushTokenRequestCopyWith<$Res> {
  _$PushTokenRequestCopyWithImpl(this._self, this._then);

  final PushTokenRequest _self;
  final $Res Function(PushTokenRequest) _then;

/// Create a copy of PushTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systemType = null,Object? token = null,}) {
  return _then(_self.copyWith(
systemType: null == systemType ? _self.systemType : systemType // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PushTokenRequest].
extension PushTokenRequestPatterns on PushTokenRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushTokenRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushTokenRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushTokenRequest value)  $default,){
final _that = this;
switch (_that) {
case _PushTokenRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushTokenRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PushTokenRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String systemType,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushTokenRequest() when $default != null:
return $default(_that.systemType,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String systemType,  String token)  $default,) {final _that = this;
switch (_that) {
case _PushTokenRequest():
return $default(_that.systemType,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String systemType,  String token)?  $default,) {final _that = this;
switch (_that) {
case _PushTokenRequest() when $default != null:
return $default(_that.systemType,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PushTokenRequest implements PushTokenRequest {
  const _PushTokenRequest({required this.systemType, required this.token});
  factory _PushTokenRequest.fromJson(Map<String, dynamic> json) => _$PushTokenRequestFromJson(json);

@override final  String systemType;
@override final  String token;

/// Create a copy of PushTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushTokenRequestCopyWith<_PushTokenRequest> get copyWith => __$PushTokenRequestCopyWithImpl<_PushTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PushTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushTokenRequest&&(identical(other.systemType, systemType) || other.systemType == systemType)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,systemType,token);

@override
String toString() {
  return 'PushTokenRequest(systemType: $systemType, token: $token)';
}


}

/// @nodoc
abstract mixin class _$PushTokenRequestCopyWith<$Res> implements $PushTokenRequestCopyWith<$Res> {
  factory _$PushTokenRequestCopyWith(_PushTokenRequest value, $Res Function(_PushTokenRequest) _then) = __$PushTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String systemType, String token
});




}
/// @nodoc
class __$PushTokenRequestCopyWithImpl<$Res>
    implements _$PushTokenRequestCopyWith<$Res> {
  __$PushTokenRequestCopyWithImpl(this._self, this._then);

  final _PushTokenRequest _self;
  final $Res Function(_PushTokenRequest) _then;

/// Create a copy of PushTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? systemType = null,Object? token = null,}) {
  return _then(_PushTokenRequest(
systemType: null == systemType ? _self.systemType : systemType // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
