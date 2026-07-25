// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskCreateRequest _$TaskCreateRequestFromJson(Map<String, dynamic> json) =>
    _TaskCreateRequest(
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$TaskCreateRequestToJson(_TaskCreateRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };
