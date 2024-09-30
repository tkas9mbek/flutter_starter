// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_value_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterValueItemImpl<T> _$$FilterValueItemImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$FilterValueItemImpl<T>(
      id: json['id'] as String,
      value: fromJsonT(json['value']),
    );

Map<String, dynamic> _$$FilterValueItemImplToJson<T>(
  _$FilterValueItemImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'value': toJsonT(instance.value),
    };
