import 'package:starter/core/notifications/domain/messaging_data_source.dart';
import 'package:starter/core/notifications/model/push_message.dart';

/// Receive-side facade: exposes incoming pushes and permission/topic control.
/// Token registration lives in [PushTokenRepository].
class PushNotificationRepository {
  const PushNotificationRepository(this._messagingDataSource);

  final MessagingDataSource _messagingDataSource;

  /// Foreground arrivals and taps. Filter on [PushMessage.wasOpened] to react
  /// only to taps.
  Stream<PushMessage> get messages => _messagingDataSource.messages;

  /// The push that cold-started the app, if any.
  Future<PushMessage?> getInitialMessage() =>
      _messagingDataSource.getInitialMessage();

  Future<void> requestPermission() => _messagingDataSource.requestPermission();

  Future<void> subscribeToTopic(String topic) =>
      _messagingDataSource.subscribeToTopic(topic);
}
