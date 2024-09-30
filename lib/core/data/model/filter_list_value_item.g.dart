// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_list_value_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterListValueItemImpl<T> _$$FilterListValueItemImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$FilterListValueItemImpl<T>(
      id: json['id'] as String,
      value: (json['value'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$$FilterListValueItemImplToJson<T>(
  _$FilterListValueItemImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value.map(toJsonT).toList(),
    };
