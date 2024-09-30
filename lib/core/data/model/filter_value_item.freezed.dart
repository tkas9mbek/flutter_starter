// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_value_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilterValueItem<T> _$FilterValueItemFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _FilterValueItem<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$FilterValueItem<T> {
  String get id => throw _privateConstructorUsedError;
  T get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterValueItemCopyWith<T, FilterValueItem<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterValueItemCopyWith<T, $Res> {
  factory $FilterValueItemCopyWith(
          FilterValueItem<T> value, $Res Function(FilterValueItem<T>) then) =
      _$FilterValueItemCopyWithImpl<T, $Res, FilterValueItem<T>>;
  @useResult
  $Res call({String id, T value});
}

/// @nodoc
class _$FilterValueItemCopyWithImpl<T, $Res, $Val extends FilterValueItem<T>>
    implements $FilterValueItemCopyWith<T, $Res> {
  _$FilterValueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterValueItemImplCopyWith<T, $Res>
    implements $FilterValueItemCopyWith<T, $Res> {
  factory _$$FilterValueItemImplCopyWith(_$FilterValueItemImpl<T> value,
          $Res Function(_$FilterValueItemImpl<T>) then) =
      __$$FilterValueItemImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String id, T value});
}

/// @nodoc
class __$$FilterValueItemImplCopyWithImpl<T, $Res>
    extends _$FilterValueItemCopyWithImpl<T, $Res, _$FilterValueItemImpl<T>>
    implements _$$FilterValueItemImplCopyWith<T, $Res> {
  __$$FilterValueItemImplCopyWithImpl(_$FilterValueItemImpl<T> _value,
      $Res Function(_$FilterValueItemImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = freezed,
  }) {
    return _then(_$FilterValueItemImpl<T>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$FilterValueItemImpl<T> implements _FilterValueItem<T> {
  _$FilterValueItemImpl({required this.id, required this.value});

  factory _$FilterValueItemImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$FilterValueItemImplFromJson(json, fromJsonT);

  @override
  final String id;
  @override
  final T value;

  @override
  String toString() {
    return 'FilterValueItem<$T>(id: $id, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterValueItemImpl<T> &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterValueItemImplCopyWith<T, _$FilterValueItemImpl<T>> get copyWith =>
      __$$FilterValueItemImplCopyWithImpl<T, _$FilterValueItemImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$FilterValueItemImplToJson<T>(this, toJsonT);
  }
}

abstract class _FilterValueItem<T> implements FilterValueItem<T> {
  factory _FilterValueItem({required final String id, required final T value}) =
      _$FilterValueItemImpl<T>;

  factory _FilterValueItem.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$FilterValueItemImpl<T>.fromJson;

  @override
  String get id;
  @override
  T get value;
  @override
  @JsonKey(ignore: true)
  _$$FilterValueItemImplCopyWith<T, _$FilterValueItemImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
