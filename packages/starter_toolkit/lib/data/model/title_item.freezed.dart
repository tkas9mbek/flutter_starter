// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'title_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TitleItem {

 String get title; String? get id;
/// Create a copy of TitleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TitleItemCopyWith<TitleItem> get copyWith => _$TitleItemCopyWithImpl<TitleItem>(this as TitleItem, _$identity);

  /// Serializes this TitleItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TitleItem&&(identical(other.title, title) || other.title == title)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,id);

@override
String toString() {
  return 'TitleItem(title: $title, id: $id)';
}


}

/// @nodoc
abstract mixin class $TitleItemCopyWith<$Res>  {
  factory $TitleItemCopyWith(TitleItem value, $Res Function(TitleItem) _then) = _$TitleItemCopyWithImpl;
@useResult
$Res call({
 String title, String? id
});




}
/// @nodoc
class _$TitleItemCopyWithImpl<$Res>
    implements $TitleItemCopyWith<$Res> {
  _$TitleItemCopyWithImpl(this._self, this._then);

  final TitleItem _self;
  final $Res Function(TitleItem) _then;

/// Create a copy of TitleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TitleItem].
extension TitleItemPatterns on TitleItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TitleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TitleItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TitleItem value)  $default,){
final _that = this;
switch (_that) {
case _TitleItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TitleItem value)?  $default,){
final _that = this;
switch (_that) {
case _TitleItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TitleItem() when $default != null:
return $default(_that.title,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? id)  $default,) {final _that = this;
switch (_that) {
case _TitleItem():
return $default(_that.title,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _TitleItem() when $default != null:
return $default(_that.title,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TitleItem implements TitleItem {
   _TitleItem({required this.title, this.id});
  factory _TitleItem.fromJson(Map<String, dynamic> json) => _$TitleItemFromJson(json);

@override final  String title;
@override final  String? id;

/// Create a copy of TitleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TitleItemCopyWith<_TitleItem> get copyWith => __$TitleItemCopyWithImpl<_TitleItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TitleItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TitleItem&&(identical(other.title, title) || other.title == title)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,id);

@override
String toString() {
  return 'TitleItem(title: $title, id: $id)';
}


}

/// @nodoc
abstract mixin class _$TitleItemCopyWith<$Res> implements $TitleItemCopyWith<$Res> {
  factory _$TitleItemCopyWith(_TitleItem value, $Res Function(_TitleItem) _then) = __$TitleItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String? id
});




}
/// @nodoc
class __$TitleItemCopyWithImpl<$Res>
    implements _$TitleItemCopyWith<$Res> {
  __$TitleItemCopyWithImpl(this._self, this._then);

  final _TitleItem _self;
  final $Res Function(_TitleItem) _then;

/// Create a copy of TitleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? id = freezed,}) {
  return _then(_TitleItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
