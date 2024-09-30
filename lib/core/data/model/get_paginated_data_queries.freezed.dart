// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_paginated_data_queries.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPaginatedDataQueries _$GetPaginatedDataQueriesFromJson(
    Map<String, dynamic> json) {
  return _GetPaginatedDataQueries.fromJson(json);
}

/// @nodoc
mixin _$GetPaginatedDataQueries {
  int? get page => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  List<Map<String, dynamic>>? get filters => throw _privateConstructorUsedError;
  List<Map<String, dynamic>>? get sort => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPaginatedDataQueriesCopyWith<GetPaginatedDataQueries> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPaginatedDataQueriesCopyWith<$Res> {
  factory $GetPaginatedDataQueriesCopyWith(GetPaginatedDataQueries value,
          $Res Function(GetPaginatedDataQueries) then) =
      _$GetPaginatedDataQueriesCopyWithImpl<$Res, GetPaginatedDataQueries>;
  @useResult
  $Res call(
      {int? page,
      int? limit,
      List<Map<String, dynamic>>? filters,
      List<Map<String, dynamic>>? sort});
}

/// @nodoc
class _$GetPaginatedDataQueriesCopyWithImpl<$Res,
        $Val extends GetPaginatedDataQueries>
    implements $GetPaginatedDataQueriesCopyWith<$Res> {
  _$GetPaginatedDataQueriesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? limit = freezed,
    Object? filters = freezed,
    Object? sort = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      filters: freezed == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      sort: freezed == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetPaginatedDataQueriesImplCopyWith<$Res>
    implements $GetPaginatedDataQueriesCopyWith<$Res> {
  factory _$$GetPaginatedDataQueriesImplCopyWith(
          _$GetPaginatedDataQueriesImpl value,
          $Res Function(_$GetPaginatedDataQueriesImpl) then) =
      __$$GetPaginatedDataQueriesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? page,
      int? limit,
      List<Map<String, dynamic>>? filters,
      List<Map<String, dynamic>>? sort});
}

/// @nodoc
class __$$GetPaginatedDataQueriesImplCopyWithImpl<$Res>
    extends _$GetPaginatedDataQueriesCopyWithImpl<$Res,
        _$GetPaginatedDataQueriesImpl>
    implements _$$GetPaginatedDataQueriesImplCopyWith<$Res> {
  __$$GetPaginatedDataQueriesImplCopyWithImpl(
      _$GetPaginatedDataQueriesImpl _value,
      $Res Function(_$GetPaginatedDataQueriesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? limit = freezed,
    Object? filters = freezed,
    Object? sort = freezed,
  }) {
    return _then(_$GetPaginatedDataQueriesImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      sort: freezed == sort
          ? _value._sort
          : sort // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$GetPaginatedDataQueriesImpl extends _GetPaginatedDataQueries {
  const _$GetPaginatedDataQueriesImpl(
      {this.page,
      this.limit,
      final List<Map<String, dynamic>>? filters,
      final List<Map<String, dynamic>>? sort})
      : _filters = filters,
        _sort = sort,
        super._();

  factory _$GetPaginatedDataQueriesImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetPaginatedDataQueriesImplFromJson(json);

  @override
  final int? page;
  @override
  final int? limit;
  final List<Map<String, dynamic>>? _filters;
  @override
  List<Map<String, dynamic>>? get filters {
    final value = _filters;
    if (value == null) return null;
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Map<String, dynamic>>? _sort;
  @override
  List<Map<String, dynamic>>? get sort {
    final value = _sort;
    if (value == null) return null;
    if (_sort is EqualUnmodifiableListView) return _sort;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetPaginatedDataQueries(page: $page, limit: $limit, filters: $filters, sort: $sort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPaginatedDataQueriesImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality().equals(other._sort, _sort));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      limit,
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_sort));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPaginatedDataQueriesImplCopyWith<_$GetPaginatedDataQueriesImpl>
      get copyWith => __$$GetPaginatedDataQueriesImplCopyWithImpl<
          _$GetPaginatedDataQueriesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPaginatedDataQueriesImplToJson(
      this,
    );
  }
}

abstract class _GetPaginatedDataQueries extends GetPaginatedDataQueries {
  const factory _GetPaginatedDataQueries(
      {final int? page,
      final int? limit,
      final List<Map<String, dynamic>>? filters,
      final List<Map<String, dynamic>>? sort}) = _$GetPaginatedDataQueriesImpl;
  const _GetPaginatedDataQueries._() : super._();

  factory _GetPaginatedDataQueries.fromJson(Map<String, dynamic> json) =
      _$GetPaginatedDataQueriesImpl.fromJson;

  @override
  int? get page;
  @override
  int? get limit;
  @override
  List<Map<String, dynamic>>? get filters;
  @override
  List<Map<String, dynamic>>? get sort;
  @override
  @JsonKey(ignore: true)
  _$$GetPaginatedDataQueriesImplCopyWith<_$GetPaginatedDataQueriesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
