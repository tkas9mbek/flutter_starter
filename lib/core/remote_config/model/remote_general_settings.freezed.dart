// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_general_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteGeneralSettings {

 AppVersion get appVersion;
/// Create a copy of RemoteGeneralSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteGeneralSettingsCopyWith<RemoteGeneralSettings> get copyWith => _$RemoteGeneralSettingsCopyWithImpl<RemoteGeneralSettings>(this as RemoteGeneralSettings, _$identity);

  /// Serializes this RemoteGeneralSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteGeneralSettings&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appVersion);

@override
String toString() {
  return 'RemoteGeneralSettings(appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class $RemoteGeneralSettingsCopyWith<$Res>  {
  factory $RemoteGeneralSettingsCopyWith(RemoteGeneralSettings value, $Res Function(RemoteGeneralSettings) _then) = _$RemoteGeneralSettingsCopyWithImpl;
@useResult
$Res call({
 AppVersion appVersion
});


$AppVersionCopyWith<$Res> get appVersion;

}
/// @nodoc
class _$RemoteGeneralSettingsCopyWithImpl<$Res>
    implements $RemoteGeneralSettingsCopyWith<$Res> {
  _$RemoteGeneralSettingsCopyWithImpl(this._self, this._then);

  final RemoteGeneralSettings _self;
  final $Res Function(RemoteGeneralSettings) _then;

/// Create a copy of RemoteGeneralSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appVersion = null,}) {
  return _then(_self.copyWith(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as AppVersion,
  ));
}
/// Create a copy of RemoteGeneralSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionCopyWith<$Res> get appVersion {
  
  return $AppVersionCopyWith<$Res>(_self.appVersion, (value) {
    return _then(_self.copyWith(appVersion: value));
  });
}
}


/// Adds pattern-matching-related methods to [RemoteGeneralSettings].
extension RemoteGeneralSettingsPatterns on RemoteGeneralSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoteGeneralSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoteGeneralSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoteGeneralSettings value)  $default,){
final _that = this;
switch (_that) {
case _RemoteGeneralSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoteGeneralSettings value)?  $default,){
final _that = this;
switch (_that) {
case _RemoteGeneralSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppVersion appVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoteGeneralSettings() when $default != null:
return $default(_that.appVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppVersion appVersion)  $default,) {final _that = this;
switch (_that) {
case _RemoteGeneralSettings():
return $default(_that.appVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppVersion appVersion)?  $default,) {final _that = this;
switch (_that) {
case _RemoteGeneralSettings() when $default != null:
return $default(_that.appVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoteGeneralSettings implements RemoteGeneralSettings {
  const _RemoteGeneralSettings({required this.appVersion});
  factory _RemoteGeneralSettings.fromJson(Map<String, dynamic> json) => _$RemoteGeneralSettingsFromJson(json);

@override final  AppVersion appVersion;

/// Create a copy of RemoteGeneralSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteGeneralSettingsCopyWith<_RemoteGeneralSettings> get copyWith => __$RemoteGeneralSettingsCopyWithImpl<_RemoteGeneralSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteGeneralSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteGeneralSettings&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appVersion);

@override
String toString() {
  return 'RemoteGeneralSettings(appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class _$RemoteGeneralSettingsCopyWith<$Res> implements $RemoteGeneralSettingsCopyWith<$Res> {
  factory _$RemoteGeneralSettingsCopyWith(_RemoteGeneralSettings value, $Res Function(_RemoteGeneralSettings) _then) = __$RemoteGeneralSettingsCopyWithImpl;
@override @useResult
$Res call({
 AppVersion appVersion
});


@override $AppVersionCopyWith<$Res> get appVersion;

}
/// @nodoc
class __$RemoteGeneralSettingsCopyWithImpl<$Res>
    implements _$RemoteGeneralSettingsCopyWith<$Res> {
  __$RemoteGeneralSettingsCopyWithImpl(this._self, this._then);

  final _RemoteGeneralSettings _self;
  final $Res Function(_RemoteGeneralSettings) _then;

/// Create a copy of RemoteGeneralSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appVersion = null,}) {
  return _then(_RemoteGeneralSettings(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as AppVersion,
  ));
}

/// Create a copy of RemoteGeneralSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionCopyWith<$Res> get appVersion {
  
  return $AppVersionCopyWith<$Res>(_self.appVersion, (value) {
    return _then(_self.copyWith(appVersion: value));
  });
}
}


/// @nodoc
mixin _$AppVersion {

 AppVersionPlatform get minimal; AppVersionPlatform get current;
/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppVersionCopyWith<AppVersion> get copyWith => _$AppVersionCopyWithImpl<AppVersion>(this as AppVersion, _$identity);

  /// Serializes this AppVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppVersion&&(identical(other.minimal, minimal) || other.minimal == minimal)&&(identical(other.current, current) || other.current == current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimal,current);

@override
String toString() {
  return 'AppVersion(minimal: $minimal, current: $current)';
}


}

/// @nodoc
abstract mixin class $AppVersionCopyWith<$Res>  {
  factory $AppVersionCopyWith(AppVersion value, $Res Function(AppVersion) _then) = _$AppVersionCopyWithImpl;
@useResult
$Res call({
 AppVersionPlatform minimal, AppVersionPlatform current
});


$AppVersionPlatformCopyWith<$Res> get minimal;$AppVersionPlatformCopyWith<$Res> get current;

}
/// @nodoc
class _$AppVersionCopyWithImpl<$Res>
    implements $AppVersionCopyWith<$Res> {
  _$AppVersionCopyWithImpl(this._self, this._then);

  final AppVersion _self;
  final $Res Function(AppVersion) _then;

/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minimal = null,Object? current = null,}) {
  return _then(_self.copyWith(
minimal: null == minimal ? _self.minimal : minimal // ignore: cast_nullable_to_non_nullable
as AppVersionPlatform,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as AppVersionPlatform,
  ));
}
/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionPlatformCopyWith<$Res> get minimal {
  
  return $AppVersionPlatformCopyWith<$Res>(_self.minimal, (value) {
    return _then(_self.copyWith(minimal: value));
  });
}/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionPlatformCopyWith<$Res> get current {
  
  return $AppVersionPlatformCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppVersion].
extension AppVersionPatterns on AppVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppVersion value)  $default,){
final _that = this;
switch (_that) {
case _AppVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppVersion value)?  $default,){
final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppVersionPlatform minimal,  AppVersionPlatform current)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
return $default(_that.minimal,_that.current);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppVersionPlatform minimal,  AppVersionPlatform current)  $default,) {final _that = this;
switch (_that) {
case _AppVersion():
return $default(_that.minimal,_that.current);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppVersionPlatform minimal,  AppVersionPlatform current)?  $default,) {final _that = this;
switch (_that) {
case _AppVersion() when $default != null:
return $default(_that.minimal,_that.current);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppVersion implements AppVersion {
  const _AppVersion({required this.minimal, required this.current});
  factory _AppVersion.fromJson(Map<String, dynamic> json) => _$AppVersionFromJson(json);

@override final  AppVersionPlatform minimal;
@override final  AppVersionPlatform current;

/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppVersionCopyWith<_AppVersion> get copyWith => __$AppVersionCopyWithImpl<_AppVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppVersion&&(identical(other.minimal, minimal) || other.minimal == minimal)&&(identical(other.current, current) || other.current == current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimal,current);

@override
String toString() {
  return 'AppVersion(minimal: $minimal, current: $current)';
}


}

/// @nodoc
abstract mixin class _$AppVersionCopyWith<$Res> implements $AppVersionCopyWith<$Res> {
  factory _$AppVersionCopyWith(_AppVersion value, $Res Function(_AppVersion) _then) = __$AppVersionCopyWithImpl;
@override @useResult
$Res call({
 AppVersionPlatform minimal, AppVersionPlatform current
});


@override $AppVersionPlatformCopyWith<$Res> get minimal;@override $AppVersionPlatformCopyWith<$Res> get current;

}
/// @nodoc
class __$AppVersionCopyWithImpl<$Res>
    implements _$AppVersionCopyWith<$Res> {
  __$AppVersionCopyWithImpl(this._self, this._then);

  final _AppVersion _self;
  final $Res Function(_AppVersion) _then;

/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minimal = null,Object? current = null,}) {
  return _then(_AppVersion(
minimal: null == minimal ? _self.minimal : minimal // ignore: cast_nullable_to_non_nullable
as AppVersionPlatform,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as AppVersionPlatform,
  ));
}

/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionPlatformCopyWith<$Res> get minimal {
  
  return $AppVersionPlatformCopyWith<$Res>(_self.minimal, (value) {
    return _then(_self.copyWith(minimal: value));
  });
}/// Create a copy of AppVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppVersionPlatformCopyWith<$Res> get current {
  
  return $AppVersionPlatformCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}


/// @nodoc
mixin _$AppVersionPlatform {

 String get ios; String get android;
/// Create a copy of AppVersionPlatform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppVersionPlatformCopyWith<AppVersionPlatform> get copyWith => _$AppVersionPlatformCopyWithImpl<AppVersionPlatform>(this as AppVersionPlatform, _$identity);

  /// Serializes this AppVersionPlatform to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppVersionPlatform&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'AppVersionPlatform(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class $AppVersionPlatformCopyWith<$Res>  {
  factory $AppVersionPlatformCopyWith(AppVersionPlatform value, $Res Function(AppVersionPlatform) _then) = _$AppVersionPlatformCopyWithImpl;
@useResult
$Res call({
 String ios, String android
});




}
/// @nodoc
class _$AppVersionPlatformCopyWithImpl<$Res>
    implements $AppVersionPlatformCopyWith<$Res> {
  _$AppVersionPlatformCopyWithImpl(this._self, this._then);

  final AppVersionPlatform _self;
  final $Res Function(AppVersionPlatform) _then;

/// Create a copy of AppVersionPlatform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ios = null,Object? android = null,}) {
  return _then(_self.copyWith(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as String,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppVersionPlatform].
extension AppVersionPlatformPatterns on AppVersionPlatform {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppVersionPlatform value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppVersionPlatform() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppVersionPlatform value)  $default,){
final _that = this;
switch (_that) {
case _AppVersionPlatform():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppVersionPlatform value)?  $default,){
final _that = this;
switch (_that) {
case _AppVersionPlatform() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ios,  String android)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppVersionPlatform() when $default != null:
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ios,  String android)  $default,) {final _that = this;
switch (_that) {
case _AppVersionPlatform():
return $default(_that.ios,_that.android);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ios,  String android)?  $default,) {final _that = this;
switch (_that) {
case _AppVersionPlatform() when $default != null:
return $default(_that.ios,_that.android);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppVersionPlatform implements AppVersionPlatform {
  const _AppVersionPlatform({required this.ios, required this.android});
  factory _AppVersionPlatform.fromJson(Map<String, dynamic> json) => _$AppVersionPlatformFromJson(json);

@override final  String ios;
@override final  String android;

/// Create a copy of AppVersionPlatform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppVersionPlatformCopyWith<_AppVersionPlatform> get copyWith => __$AppVersionPlatformCopyWithImpl<_AppVersionPlatform>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppVersionPlatformToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppVersionPlatform&&(identical(other.ios, ios) || other.ios == ios)&&(identical(other.android, android) || other.android == android));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ios,android);

@override
String toString() {
  return 'AppVersionPlatform(ios: $ios, android: $android)';
}


}

/// @nodoc
abstract mixin class _$AppVersionPlatformCopyWith<$Res> implements $AppVersionPlatformCopyWith<$Res> {
  factory _$AppVersionPlatformCopyWith(_AppVersionPlatform value, $Res Function(_AppVersionPlatform) _then) = __$AppVersionPlatformCopyWithImpl;
@override @useResult
$Res call({
 String ios, String android
});




}
/// @nodoc
class __$AppVersionPlatformCopyWithImpl<$Res>
    implements _$AppVersionPlatformCopyWith<$Res> {
  __$AppVersionPlatformCopyWithImpl(this._self, this._then);

  final _AppVersionPlatform _self;
  final $Res Function(_AppVersionPlatform) _then;

/// Create a copy of AppVersionPlatform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ios = null,Object? android = null,}) {
  return _then(_AppVersionPlatform(
ios: null == ios ? _self.ios : ios // ignore: cast_nullable_to_non_nullable
as String,android: null == android ? _self.android : android // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
