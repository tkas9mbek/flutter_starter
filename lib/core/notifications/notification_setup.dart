import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:starter/core/global/firebase_config.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/notifications/model/push_message.dart';
import 'package:starter/core/notifications/push_navigation_resolver.dart';

final FlutterLocalNotificationsPlugin _localNotifications =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High importance notifications',
  description: 'Used for important foreground notifications.',
  importance: Importance.max,
);

bool _isInitialized = false;

/// Background isolate entry-point. Notification messages are rendered by the
/// OS automatically; this exists so data-only payloads can be processed later.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async =>
    WidgetsFlutterBinding.ensureInitialized();

/// One-time setup: local-notification channel, tap handling, and foreground
/// presentation. Idempotent — safe to call more than once.
Future<void> initializeNotifications() async {
  // Firebase path is an example — see FirebaseConfig.
  if (_isInitialized || !FirebaseConfig.enabled) {
    return;
  }

  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    ),
  );

  await _localNotifications.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: _onLocalNotificationTapped,
  );

  await _localNotifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(_channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  _isInitialized = true;
}

/// Renders [message] as a local notification (FCM shows nothing while the app
/// is in the foreground, so we surface it ourselves).
Future<void> showFlutterNotification(RemoteMessage message) async {
  final notification = message.notification;

  if (notification == null) {
    return;
  }

  await _localNotifications.show(
    id: notification.hashCode,
    title: notification.title,
    body: notification.body,
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    ),
    payload: jsonEncode(message.data),
  );
}

void _onLocalNotificationTapped(NotificationResponse response) {
  final payload = response.payload;

  if (payload == null || payload.isEmpty) {
    return;
  }

  final data = jsonDecode(payload) as Map<String, dynamic>;

  if (getIt.isRegistered<PushNavigationResolver>()) {
    getIt<PushNavigationResolver>().resolve(
      PushMessage(data: data, wasOpened: true),
    );
  }
}
