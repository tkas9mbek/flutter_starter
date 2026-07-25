import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_message.freezed.dart';

/// A push notification mapped into the domain — free of any Firebase types.
///
/// [wasOpened] is `true` when the user tapped the notification (app opened
/// from background/terminated or a local-notification tap), `false` when it
/// merely arrived while the app was in the foreground.
@freezed
abstract class PushMessage with _$PushMessage {
  const factory PushMessage({
    String? title,
    String? body,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
    @Default(false) bool wasOpened,
  }) = _PushMessage;
}
