// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_list_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiListItems<T> _$ApiListItemsFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ApiListItems<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ApiListItems<T> {
  List<T> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiListItemsCopyWith<T, ApiListItems<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiListItemsCopyWith<T, $Res> {
  factory $ApiListItemsCopyWith(
          ApiListItems<T> value, $Res Function(ApiListItems<T>) then) =
      _$ApiListItemsCopyWithImpl<T, $Res, ApiListItems<T>>;
  @useResult
  $Res call({List<T> items});
}

/// @nodoc
class _$ApiListItemsCopyWithImpl<T, $Res, $Val extends ApiListItems<T>>
    implements $ApiListItemsCopyWith<T, $Res> {
  _$ApiListItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiListItemsImplCopyWith<T, $Res>
    implements $ApiListItemsCopyWith<T, $Res> {
  factory _$$ApiListItemsImplCopyWith(_$ApiListItemsImpl<T> value,
          $Res Function(_$ApiListItemsImpl<T>) then) =
      __$$ApiListItemsImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> items});
}

/// @nodoc
class __$$ApiListItemsImplCopyWithImpl<T, $Res>
    extends _$ApiListItemsCopyWithImpl<T, $Res, _$ApiListItemsImpl<T>>
    implements _$$ApiListItemsImplCopyWith<T, $Res> {
  __$$ApiListItemsImplCopyWithImpl(
      _$ApiListItemsImpl<T> _value, $Res Function(_$ApiListItemsImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$ApiListItemsImpl<T>(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ApiListItemsImpl<T> implements _ApiListItems<T> {
  _$ApiListItemsImpl({required final List<T> items}) : _items = items;

  factory _$ApiListItemsImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ApiListItemsImplFromJson(json, fromJsonT);

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ApiListItems<$T>(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiListItemsImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiListItemsImplCopyWith<T, _$ApiListItemsImpl<T>> get copyWith =>
      __$$ApiListItemsImplCopyWithImpl<T, _$ApiListItemsImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ApiListItemsImplToJson<T>(this, toJsonT);
  }
}

abstract class _ApiListItems<T> implements ApiListItems<T> {
  factory _ApiListItems({required final List<T> items}) = _$ApiListItemsImpl<T>;

  factory _ApiListItems.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ApiListItemsImpl<T>.fromJson;

  @override
  List<T> get items;
  @override
  @JsonKey(ignore: true)
  _$$ApiListItemsImplCopyWith<T, _$ApiListItemsImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
