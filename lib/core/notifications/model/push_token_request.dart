import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_token_request.freezed.dart';

part 'push_token_request.g.dart';

@Freezed(toJson: true)
abstract class PushTokenRequest with _$PushTokenRequest {
  const factory PushTokenRequest({
    required String systemType,
    required String token,
  }) = _PushTokenRequest;

  factory PushTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$PushTokenRequestFromJson(json);
}
