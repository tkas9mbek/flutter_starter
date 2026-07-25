// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_phone_codes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemotePhoneCodes {

 List<PhoneCode> get items;
/// Create a copy of RemotePhoneCodes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemotePhoneCodesCopyWith<RemotePhoneCodes> get copyWith => _$RemotePhoneCodesCopyWithImpl<RemotePhoneCodes>(this as RemotePhoneCodes, _$identity);

  /// Serializes this RemotePhoneCodes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemotePhoneCodes&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'RemotePhoneCodes(items: $items)';
}


}

/// @nodoc
abstract mixin class $RemotePhoneCodesCopyWith<$Res>  {
  factory $RemotePhoneCodesCopyWith(RemotePhoneCodes value, $Res Function(RemotePhoneCodes) _then) = _$RemotePhoneCodesCopyWithImpl;
@useResult
$Res call({
 List<PhoneCode> items
});




}
/// @nodoc
class _$RemotePhoneCodesCopyWithImpl<$Res>
    implements $RemotePhoneCodesCopyWith<$Res> {
  _$RemotePhoneCodesCopyWithImpl(this._self, this._then);

  final RemotePhoneCodes _self;
  final $Res Function(RemotePhoneCodes) _then;

/// Create a copy of RemotePhoneCodes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PhoneCode>,
  ));
}

}


/// Adds pattern-matching-related methods to [RemotePhoneCodes].
extension RemotePhoneCodesPatterns on RemotePhoneCodes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemotePhoneCodes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemotePhoneCodes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemotePhoneCodes value)  $default,){
final _that = this;
switch (_that) {
case _RemotePhoneCodes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemotePhoneCodes value)?  $default,){
final _that = this;
switch (_that) {
case _RemotePhoneCodes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PhoneCode> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemotePhoneCodes() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PhoneCode> items)  $default,) {final _that = this;
switch (_that) {
case _RemotePhoneCodes():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PhoneCode> items)?  $default,) {final _that = this;
switch (_that) {
case _RemotePhoneCodes() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemotePhoneCodes implements RemotePhoneCodes {
  const _RemotePhoneCodes({required this.items});
  factory _RemotePhoneCodes.fromJson(Map<String, dynamic> json) => _$RemotePhoneCodesFromJson(json);

@override final  List<PhoneCode> items;

/// Create a copy of RemotePhoneCodes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemotePhoneCodesCopyWith<_RemotePhoneCodes> get copyWith => __$RemotePhoneCodesCopyWithImpl<_RemotePhoneCodes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemotePhoneCodesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemotePhoneCodes&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'RemotePhoneCodes(items: $items)';
}


}

/// @nodoc
abstract mixin class _$RemotePhoneCodesCopyWith<$Res> implements $RemotePhoneCodesCopyWith<$Res> {
  factory _$RemotePhoneCodesCopyWith(_RemotePhoneCodes value, $Res Function(_RemotePhoneCodes) _then) = __$RemotePhoneCodesCopyWithImpl;
@override @useResult
$Res call({
 List<PhoneCode> items
});




}
/// @nodoc
class __$RemotePhoneCodesCopyWithImpl<$Res>
    implements _$RemotePhoneCodesCopyWith<$Res> {
  __$RemotePhoneCodesCopyWithImpl(this._self, this._then);

  final _RemotePhoneCodes _self;
  final $Res Function(_RemotePhoneCodes) _then;

/// Create a copy of RemotePhoneCodes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_RemotePhoneCodes(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PhoneCode>,
  ));
}


}


/// @nodoc
mixin _$PhoneCode {

@JsonKey(name: 'phone_code') String get phoneCode;@JsonKey(name: 'country_code') String get countryCode; String get regex; RemoteLocalizedText get name; String get mask; String get icon;
/// Create a copy of PhoneCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneCodeCopyWith<PhoneCode> get copyWith => _$PhoneCodeCopyWithImpl<PhoneCode>(this as PhoneCode, _$identity);

  /// Serializes this PhoneCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneCode&&(identical(other.phoneCode, phoneCode) || other.phoneCode == phoneCode)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.regex, regex) || other.regex == regex)&&(identical(other.name, name) || other.name == name)&&(identical(other.mask, mask) || other.mask == mask)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneCode,countryCode,regex,name,mask,icon);

@override
String toString() {
  return 'PhoneCode(phoneCode: $phoneCode, countryCode: $countryCode, regex: $regex, name: $name, mask: $mask, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $PhoneCodeCopyWith<$Res>  {
  factory $PhoneCodeCopyWith(PhoneCode value, $Res Function(PhoneCode) _then) = _$PhoneCodeCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'phone_code') String phoneCode,@JsonKey(name: 'country_code') String countryCode, String regex, RemoteLocalizedText name, String mask, String icon
});




}
/// @nodoc
class _$PhoneCodeCopyWithImpl<$Res>
    implements $PhoneCodeCopyWith<$Res> {
  _$PhoneCodeCopyWithImpl(this._self, this._then);

  final PhoneCode _self;
  final $Res Function(PhoneCode) _then;

/// Create a copy of PhoneCode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneCode = null,Object? countryCode = null,Object? regex = null,Object? name = null,Object? mask = null,Object? icon = null,}) {
  return _then(_self.copyWith(
phoneCode: null == phoneCode ? _self.phoneCode : phoneCode // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,regex: null == regex ? _self.regex : regex // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as RemoteLocalizedText,mask: null == mask ? _self.mask : mask // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneCode].
extension PhoneCodePatterns on PhoneCode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneCode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneCode value)  $default,){
final _that = this;
switch (_that) {
case _PhoneCode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneCode value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneCode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_code')  String phoneCode, @JsonKey(name: 'country_code')  String countryCode,  String regex,  RemoteLocalizedText name,  String mask,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneCode() when $default != null:
return $default(_that.phoneCode,_that.countryCode,_that.regex,_that.name,_that.mask,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_code')  String phoneCode, @JsonKey(name: 'country_code')  String countryCode,  String regex,  RemoteLocalizedText name,  String mask,  String icon)  $default,) {final _that = this;
switch (_that) {
case _PhoneCode():
return $default(_that.phoneCode,_that.countryCode,_that.regex,_that.name,_that.mask,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'phone_code')  String phoneCode, @JsonKey(name: 'country_code')  String countryCode,  String regex,  RemoteLocalizedText name,  String mask,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _PhoneCode() when $default != null:
return $default(_that.phoneCode,_that.countryCode,_that.regex,_that.name,_that.mask,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneCode extends PhoneCode {
  const _PhoneCode({@JsonKey(name: 'phone_code') required this.phoneCode, @JsonKey(name: 'country_code') required this.countryCode, required this.regex, required this.name, required this.mask, required this.icon}): super._();
  factory _PhoneCode.fromJson(Map<String, dynamic> json) => _$PhoneCodeFromJson(json);

@override@JsonKey(name: 'phone_code') final  String phoneCode;
@override@JsonKey(name: 'country_code') final  String countryCode;
@override final  String regex;
@override final  RemoteLocalizedText name;
@override final  String mask;
@override final  String icon;

/// Create a copy of PhoneCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneCodeCopyWith<_PhoneCode> get copyWith => __$PhoneCodeCopyWithImpl<_PhoneCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneCode&&(identical(other.phoneCode, phoneCode) || other.phoneCode == phoneCode)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.regex, regex) || other.regex == regex)&&(identical(other.name, name) || other.name == name)&&(identical(other.mask, mask) || other.mask == mask)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneCode,countryCode,regex,name,mask,icon);

@override
String toString() {
  return 'PhoneCode(phoneCode: $phoneCode, countryCode: $countryCode, regex: $regex, name: $name, mask: $mask, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$PhoneCodeCopyWith<$Res> implements $PhoneCodeCopyWith<$Res> {
  factory _$PhoneCodeCopyWith(_PhoneCode value, $Res Function(_PhoneCode) _then) = __$PhoneCodeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'phone_code') String phoneCode,@JsonKey(name: 'country_code') String countryCode, String regex, RemoteLocalizedText name, String mask, String icon
});




}
/// @nodoc
class __$PhoneCodeCopyWithImpl<$Res>
    implements _$PhoneCodeCopyWith<$Res> {
  __$PhoneCodeCopyWithImpl(this._self, this._then);

  final _PhoneCode _self;
  final $Res Function(_PhoneCode) _then;

/// Create a copy of PhoneCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneCode = null,Object? countryCode = null,Object? regex = null,Object? name = null,Object? mask = null,Object? icon = null,}) {
  return _then(_PhoneCode(
phoneCode: null == phoneCode ? _self.phoneCode : phoneCode // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,regex: null == regex ? _self.regex : regex // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as RemoteLocalizedText,mask: null == mask ? _self.mask : mask // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
