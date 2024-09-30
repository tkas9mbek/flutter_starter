import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_api_error.freezed.dart';

part 'input_api_error.g.dart';

@freezed
class InputApiError with _$InputApiError {
  const factory InputApiError({
    required String field,
    required String message,
  }) = _InputApiError;

  factory InputApiError.fromJson(Map<String, dynamic> json) =>
      _$InputApiErrorFromJson(json);
}
