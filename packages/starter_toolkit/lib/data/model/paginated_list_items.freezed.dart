// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_list_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedListItems<T> {

 int get pageLimit; int get countItems; int get countPages; List<T> get elements;
/// Create a copy of PaginatedListItems
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedListItemsCopyWith<T, PaginatedListItems<T>> get copyWith => _$PaginatedListItemsCopyWithImpl<T, PaginatedListItems<T>>(this as PaginatedListItems<T>, _$identity);

  /// Serializes this PaginatedListItems to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedListItems<T>&&(identical(other.pageLimit, pageLimit) || other.pageLimit == pageLimit)&&(identical(other.countItems, countItems) || other.countItems == countItems)&&(identical(other.countPages, countPages) || other.countPages == countPages)&&const DeepCollectionEquality().equals(other.elements, elements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageLimit,countItems,countPages,const DeepCollectionEquality().hash(elements));

@override
String toString() {
  return 'PaginatedListItems<$T>(pageLimit: $pageLimit, countItems: $countItems, countPages: $countPages, elements: $elements)';
}


}

/// @nodoc
abstract mixin class $PaginatedListItemsCopyWith<T,$Res>  {
  factory $PaginatedListItemsCopyWith(PaginatedListItems<T> value, $Res Function(PaginatedListItems<T>) _then) = _$PaginatedListItemsCopyWithImpl;
@useResult
$Res call({
 int pageLimit, int countItems, int countPages, List<T> elements
});




}
/// @nodoc
class _$PaginatedListItemsCopyWithImpl<T,$Res>
    implements $PaginatedListItemsCopyWith<T, $Res> {
  _$PaginatedListItemsCopyWithImpl(this._self, this._then);

  final PaginatedListItems<T> _self;
  final $Res Function(PaginatedListItems<T>) _then;

/// Create a copy of PaginatedListItems
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageLimit = null,Object? countItems = null,Object? countPages = null,Object? elements = null,}) {
  return _then(_self.copyWith(
pageLimit: null == pageLimit ? _self.pageLimit : pageLimit // ignore: cast_nullable_to_non_nullable
as int,countItems: null == countItems ? _self.countItems : countItems // ignore: cast_nullable_to_non_nullable
as int,countPages: null == countPages ? _self.countPages : countPages // ignore: cast_nullable_to_non_nullable
as int,elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<T>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedListItems].
extension PaginatedListItemsPatterns<T> on PaginatedListItems<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedListItems<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedListItems() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedListItems<T> value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedListItems():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedListItems<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedListItems() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pageLimit,  int countItems,  int countPages,  List<T> elements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedListItems() when $default != null:
return $default(_that.pageLimit,_that.countItems,_that.countPages,_that.elements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pageLimit,  int countItems,  int countPages,  List<T> elements)  $default,) {final _that = this;
switch (_that) {
case _PaginatedListItems():
return $default(_that.pageLimit,_that.countItems,_that.countPages,_that.elements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pageLimit,  int countItems,  int countPages,  List<T> elements)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedListItems() when $default != null:
return $default(_that.pageLimit,_that.countItems,_that.countPages,_that.elements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PaginatedListItems<T> implements PaginatedListItems<T> {
   _PaginatedListItems({required this.pageLimit, required this.countItems, required this.countPages, required final  List<T> elements}): _elements = elements;
  factory _PaginatedListItems.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PaginatedListItemsFromJson(json,fromJsonT);

@override final  int pageLimit;
@override final  int countItems;
@override final  int countPages;
 final  List<T> _elements;
@override List<T> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}


/// Create a copy of PaginatedListItems
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedListItemsCopyWith<T, _PaginatedListItems<T>> get copyWith => __$PaginatedListItemsCopyWithImpl<T, _PaginatedListItems<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PaginatedListItemsToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedListItems<T>&&(identical(other.pageLimit, pageLimit) || other.pageLimit == pageLimit)&&(identical(other.countItems, countItems) || other.countItems == countItems)&&(identical(other.countPages, countPages) || other.countPages == countPages)&&const DeepCollectionEquality().equals(other._elements, _elements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageLimit,countItems,countPages,const DeepCollectionEquality().hash(_elements));

@override
String toString() {
  return 'PaginatedListItems<$T>(pageLimit: $pageLimit, countItems: $countItems, countPages: $countPages, elements: $elements)';
}


}

/// @nodoc
abstract mixin class _$PaginatedListItemsCopyWith<T,$Res> implements $PaginatedListItemsCopyWith<T, $Res> {
  factory _$PaginatedListItemsCopyWith(_PaginatedListItems<T> value, $Res Function(_PaginatedListItems<T>) _then) = __$PaginatedListItemsCopyWithImpl;
@override @useResult
$Res call({
 int pageLimit, int countItems, int countPages, List<T> elements
});




}
/// @nodoc
class __$PaginatedListItemsCopyWithImpl<T,$Res>
    implements _$PaginatedListItemsCopyWith<T, $Res> {
  __$PaginatedListItemsCopyWithImpl(this._self, this._then);

  final _PaginatedListItems<T> _self;
  final $Res Function(_PaginatedListItems<T>) _then;

/// Create a copy of PaginatedListItems
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageLimit = null,Object? countItems = null,Object? countPages = null,Object? elements = null,}) {
  return _then(_PaginatedListItems<T>(
pageLimit: null == pageLimit ? _self.pageLimit : pageLimit // ignore: cast_nullable_to_non_nullable
as int,countItems: null == countItems ? _self.countItems : countItems // ignore: cast_nullable_to_non_nullable
as int,countPages: null == countPages ? _self.countPages : countPages // ignore: cast_nullable_to_non_nullable
as int,elements: null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<T>,
  ));
}


}

// dart format on
