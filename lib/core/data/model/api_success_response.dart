import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_success_response.freezed.dart';

part 'api_success_response.g.dart';

@freezed
class ApiSuccessResponse with _$ApiSuccessResponse {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory ApiSuccessResponse({
    required bool success,
  }) = _ApiSuccessResponse;

  factory ApiSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiSuccessResponseFromJson(json);
}
