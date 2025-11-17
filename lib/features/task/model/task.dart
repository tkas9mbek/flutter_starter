import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@Freezed(fromJson: true, toJson: true)
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required bool isCompleted,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
