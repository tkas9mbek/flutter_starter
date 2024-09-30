// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_paginated_data_queries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPaginatedDataQueriesImpl _$$GetPaginatedDataQueriesImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPaginatedDataQueriesImpl(
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$GetPaginatedDataQueriesImplToJson(
    _$GetPaginatedDataQueriesImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('limit', instance.limit);
  writeNotNull('filters', instance.filters);
  writeNotNull('sort', instance.sort);
  return val;
}
