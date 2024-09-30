// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_list_value_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilterListValueItem<T> _$FilterListValueItemFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _FilterListValueItem<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$FilterListValueItem<T> {
  String get id => throw _privateConstructorUsedError;
  List<T> get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterListValueItemCopyWith<T, FilterListValueItem<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterListValueItemCopyWith<T, $Res> {
  factory $FilterListValueItemCopyWith(FilterListValueItem<T> value,
          $Res Function(FilterListValueItem<T>) then) =
      _$FilterListValueItemCopyWithImpl<T, $Res, FilterListValueItem<T>>;
  @useResult
  $Res call({String id, List<T> value});
}

/// @nodoc
class _$FilterListValueItemCopyWithImpl<T, $Res,
        $Val extends FilterListValueItem<T>>
    implements $FilterListValueItemCopyWith<T, $Res> {
  _$FilterListValueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterListValueItemImplCopyWith<T, $Res>
    implements $FilterListValueItemCopyWith<T, $Res> {
  factory _$$FilterListValueItemImplCopyWith(_$FilterListValueItemImpl<T> value,
          $Res Function(_$FilterListValueItemImpl<T>) then) =
      __$$FilterListValueItemImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String id, List<T> value});
}

/// @nodoc
class __$$FilterListValueItemImplCopyWithImpl<T, $Res>
    extends _$FilterListValueItemCopyWithImpl<T, $Res,
        _$FilterListValueItemImpl<T>>
    implements _$$FilterListValueItemImplCopyWith<T, $Res> {
  __$$FilterListValueItemImplCopyWithImpl(_$FilterListValueItemImpl<T> _value,
      $Res Function(_$FilterListValueItemImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
  }) {
    return _then(_$FilterListValueItemImpl<T>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$FilterListValueItemImpl<T> implements _FilterListValueItem<T> {
  _$FilterListValueItemImpl({required this.id, required final List<T> value})
      : _value = value;

  factory _$FilterListValueItemImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$FilterListValueItemImplFromJson(json, fromJsonT);

  @override
  final String id;
  final List<T> _value;
  @override
  List<T> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  @override
  String toString() {
    return 'FilterListValueItem<$T>(id: $id, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterListValueItemImpl<T> &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(_value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterListValueItemImplCopyWith<T, _$FilterListValueItemImpl<T>>
      get copyWith => __$$FilterListValueItemImplCopyWithImpl<T,
          _$FilterListValueItemImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$FilterListValueItemImplToJson<T>(this, toJsonT);
  }
}

abstract class _FilterListValueItem<T> implements FilterListValueItem<T> {
  factory _FilterListValueItem(
      {required final String id,
      required final List<T> value}) = _$FilterListValueItemImpl<T>;

  factory _FilterListValueItem.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$FilterListValueItemImpl<T>.fromJson;

  @override
  String get id;
  @override
  List<T> get value;
  @override
  @JsonKey(ignore: true)
  _$$FilterListValueItemImplCopyWith<T, _$FilterListValueItemImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
