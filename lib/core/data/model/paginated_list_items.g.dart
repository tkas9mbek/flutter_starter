// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_list_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedListItemsImpl<T> _$$PaginatedListItemsImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$PaginatedListItemsImpl<T>(
      pageLimit: (json['pageLimit'] as num).toInt(),
      countItems: (json['countItems'] as num).toInt(),
      countPages: (json['countPages'] as num).toInt(),
      elements: (json['elements'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$$PaginatedListItemsImplToJson<T>(
  _$PaginatedListItemsImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'pageLimit': instance.pageLimit,
      'countItems': instance.countItems,
      'countPages': instance.countPages,
      'elements': instance.elements.map(toJsonT).toList(),
    };
