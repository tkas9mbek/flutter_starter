// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_list_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaginatedListItems<T> _$PaginatedListItemsFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _PaginatedListItems<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PaginatedListItems<T> {
  int get pageLimit => throw _privateConstructorUsedError;
  int get countItems => throw _privateConstructorUsedError;
  int get countPages => throw _privateConstructorUsedError;
  List<T> get elements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginatedListItemsCopyWith<T, PaginatedListItems<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedListItemsCopyWith<T, $Res> {
  factory $PaginatedListItemsCopyWith(PaginatedListItems<T> value,
          $Res Function(PaginatedListItems<T>) then) =
      _$PaginatedListItemsCopyWithImpl<T, $Res, PaginatedListItems<T>>;
  @useResult
  $Res call({int pageLimit, int countItems, int countPages, List<T> elements});
}

/// @nodoc
class _$PaginatedListItemsCopyWithImpl<T, $Res,
        $Val extends PaginatedListItems<T>>
    implements $PaginatedListItemsCopyWith<T, $Res> {
  _$PaginatedListItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageLimit = null,
    Object? countItems = null,
    Object? countPages = null,
    Object? elements = null,
  }) {
    return _then(_value.copyWith(
      pageLimit: null == pageLimit
          ? _value.pageLimit
          : pageLimit // ignore: cast_nullable_to_non_nullable
              as int,
      countItems: null == countItems
          ? _value.countItems
          : countItems // ignore: cast_nullable_to_non_nullable
              as int,
      countPages: null == countPages
          ? _value.countPages
          : countPages // ignore: cast_nullable_to_non_nullable
              as int,
      elements: null == elements
          ? _value.elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginatedListItemsImplCopyWith<T, $Res>
    implements $PaginatedListItemsCopyWith<T, $Res> {
  factory _$$PaginatedListItemsImplCopyWith(_$PaginatedListItemsImpl<T> value,
          $Res Function(_$PaginatedListItemsImpl<T>) then) =
      __$$PaginatedListItemsImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int pageLimit, int countItems, int countPages, List<T> elements});
}

/// @nodoc
class __$$PaginatedListItemsImplCopyWithImpl<T, $Res>
    extends _$PaginatedListItemsCopyWithImpl<T, $Res,
        _$PaginatedListItemsImpl<T>>
    implements _$$PaginatedListItemsImplCopyWith<T, $Res> {
  __$$PaginatedListItemsImplCopyWithImpl(_$PaginatedListItemsImpl<T> _value,
      $Res Function(_$PaginatedListItemsImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageLimit = null,
    Object? countItems = null,
    Object? countPages = null,
    Object? elements = null,
  }) {
    return _then(_$PaginatedListItemsImpl<T>(
      pageLimit: null == pageLimit
          ? _value.pageLimit
          : pageLimit // ignore: cast_nullable_to_non_nullable
              as int,
      countItems: null == countItems
          ? _value.countItems
          : countItems // ignore: cast_nullable_to_non_nullable
              as int,
      countPages: null == countPages
          ? _value.countPages
          : countPages // ignore: cast_nullable_to_non_nullable
              as int,
      elements: null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PaginatedListItemsImpl<T> implements _PaginatedListItems<T> {
  _$PaginatedListItemsImpl(
      {required this.pageLimit,
      required this.countItems,
      required this.countPages,
      required final List<T> elements})
      : _elements = elements;

  factory _$PaginatedListItemsImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$PaginatedListItemsImplFromJson(json, fromJsonT);

  @override
  final int pageLimit;
  @override
  final int countItems;
  @override
  final int countPages;
  final List<T> _elements;
  @override
  List<T> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @override
  String toString() {
    return 'PaginatedListItems<$T>(pageLimit: $pageLimit, countItems: $countItems, countPages: $countPages, elements: $elements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedListItemsImpl<T> &&
            (identical(other.pageLimit, pageLimit) ||
                other.pageLimit == pageLimit) &&
            (identical(other.countItems, countItems) ||
                other.countItems == countItems) &&
            (identical(other.countPages, countPages) ||
                other.countPages == countPages) &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pageLimit, countItems,
      countPages, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedListItemsImplCopyWith<T, _$PaginatedListItemsImpl<T>>
      get copyWith => __$$PaginatedListItemsImplCopyWithImpl<T,
          _$PaginatedListItemsImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PaginatedListItemsImplToJson<T>(this, toJsonT);
  }
}

abstract class _PaginatedListItems<T> implements PaginatedListItems<T> {
  factory _PaginatedListItems(
      {required final int pageLimit,
      required final int countItems,
      required final int countPages,
      required final List<T> elements}) = _$PaginatedListItemsImpl<T>;

  factory _PaginatedListItems.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$PaginatedListItemsImpl<T>.fromJson;

  @override
  int get pageLimit;
  @override
  int get countItems;
  @override
  int get countPages;
  @override
  List<T> get elements;
  @override
  @JsonKey(ignore: true)
  _$$PaginatedListItemsImplCopyWith<T, _$PaginatedListItemsImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
