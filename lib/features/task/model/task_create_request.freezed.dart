// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_create_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskCreateRequest _$TaskCreateRequestFromJson(Map<String, dynamic> json) {
  return _TaskCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$TaskCreateRequest {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;

  /// Serializes this TaskCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCreateRequestCopyWith<TaskCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCreateRequestCopyWith<$Res> {
  factory $TaskCreateRequestCopyWith(
          TaskCreateRequest value, $Res Function(TaskCreateRequest) then) =
      _$TaskCreateRequestCopyWithImpl<$Res, TaskCreateRequest>;
  @useResult
  $Res call(
      {String title,
      String description,
      DateTime date,
      DateTime startTime,
      DateTime endTime});
}

/// @nodoc
class _$TaskCreateRequestCopyWithImpl<$Res, $Val extends TaskCreateRequest>
    implements $TaskCreateRequestCopyWith<$Res> {
  _$TaskCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskCreateRequestImplCopyWith<$Res>
    implements $TaskCreateRequestCopyWith<$Res> {
  factory _$$TaskCreateRequestImplCopyWith(_$TaskCreateRequestImpl value,
          $Res Function(_$TaskCreateRequestImpl) then) =
      __$$TaskCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      DateTime date,
      DateTime startTime,
      DateTime endTime});
}

/// @nodoc
class __$$TaskCreateRequestImplCopyWithImpl<$Res>
    extends _$TaskCreateRequestCopyWithImpl<$Res, _$TaskCreateRequestImpl>
    implements _$$TaskCreateRequestImplCopyWith<$Res> {
  __$$TaskCreateRequestImplCopyWithImpl(_$TaskCreateRequestImpl _value,
      $Res Function(_$TaskCreateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$TaskCreateRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskCreateRequestImpl implements _TaskCreateRequest {
  const _$TaskCreateRequestImpl(
      {required this.title,
      required this.description,
      required this.date,
      required this.startTime,
      required this.endTime});

  factory _$TaskCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskCreateRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime date;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;

  @override
  String toString() {
    return 'TaskCreateRequest(title: $title, description: $description, date: $date, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskCreateRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, description, date, startTime, endTime);

  /// Create a copy of TaskCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskCreateRequestImplCopyWith<_$TaskCreateRequestImpl> get copyWith =>
      __$$TaskCreateRequestImplCopyWithImpl<_$TaskCreateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _TaskCreateRequest implements TaskCreateRequest {
  const factory _TaskCreateRequest(
      {required final String title,
      required final String description,
      required final DateTime date,
      required final DateTime startTime,
      required final DateTime endTime}) = _$TaskCreateRequestImpl;

  factory _TaskCreateRequest.fromJson(Map<String, dynamic> json) =
      _$TaskCreateRequestImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get date;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;

  /// Create a copy of TaskCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskCreateRequestImplCopyWith<_$TaskCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
