import 'package:starter/core/notifications/model/push_message.dart';

/// Contract over the platform push-messaging SDK (Firebase Cloud Messaging).
///
/// Keeps Firebase types out of the domain/UI: tokens are plain strings and
/// messages are [PushMessage]s.
abstract class MessagingDataSource {
  /// Current device push token, or `null` if unavailable.
  Future<String?> getToken();

  /// Emits the new token whenever the SDK rotates it.
  Stream<String> get tokenChanges;

  /// Foreground arrivals and taps, mapped to [PushMessage].
  Stream<PushMessage> get messages;

  /// The message that launched the app from a terminated state, if any.
  Future<PushMessage?> getInitialMessage();

  /// Requests the OS notification permission (iOS / Android 13+).
  Future<void> requestPermission();

  /// Subscribes the device to a broadcast [topic].
  Future<void> subscribeToTopic(String topic);

  Future<void> dispose();
}
