import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starter/core/notifications/domain/messaging_data_source.dart';
import 'package:starter/core/notifications/model/push_message.dart';

class FirebaseMessagingDataSource implements MessagingDataSource {
  FirebaseMessagingDataSource(this._messaging) {
    _tokenSubscription = _messaging.onTokenRefresh.listen(_tokenSubject.add);
    _messageSubscription = MergeStream<PushMessage>([
      FirebaseMessaging.onMessage.map(
        (message) => _toPushMessage(message, wasOpened: false),
      ),
      FirebaseMessaging.onMessageOpenedApp.map(
        (message) => _toPushMessage(message, wasOpened: true),
      ),
    ]).listen(_messageSubject.add);
  }

  final FirebaseMessaging _messaging;
  final _tokenSubject = BehaviorSubject<String>();
  final _messageSubject = PublishSubject<PushMessage>();
  late final StreamSubscription<String> _tokenSubscription;
  late final StreamSubscription<PushMessage> _messageSubscription;

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  Stream<String> get tokenChanges => _tokenSubject.distinct();

  @override
  Stream<PushMessage> get messages => _messageSubject.stream;

  @override
  Future<PushMessage?> getInitialMessage() async {
    final message = await _messaging.getInitialMessage();

    if (message == null) {
      return null;
    }

    return _toPushMessage(message, wasOpened: true);
  }

  @override
  Future<void> requestPermission() async {
    await _messaging.requestPermission();
  }

  @override
  Future<void> subscribeToTopic(String topic) =>
      _messaging.subscribeToTopic(topic);

  @override
  Future<void> dispose() async {
    await _tokenSubscription.cancel();
    await _messageSubscription.cancel();
    await _tokenSubject.close();
    await _messageSubject.close();
  }

  PushMessage _toPushMessage(
    RemoteMessage message, {
    required bool wasOpened,
  }) => PushMessage(
    title: message.notification?.title,
    body: message.notification?.body,
    data: message.data,
    wasOpened: wasOpened,
  );
}
