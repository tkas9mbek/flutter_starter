// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_list_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiListItemsImpl<T> _$$ApiListItemsImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ApiListItemsImpl<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$$ApiListItemsImplToJson<T>(
  _$ApiListItemsImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
    };
