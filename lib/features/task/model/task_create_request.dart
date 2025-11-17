import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_create_request.freezed.dart';

part 'task_create_request.g.dart';

@Freezed(fromJson: true, toJson: true)
class TaskCreateRequest with _$TaskCreateRequest {
  const factory TaskCreateRequest({
    required String title,
    required String description,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
  }) = _TaskCreateRequest;

  factory TaskCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskCreateRequestFromJson(json);
}
