import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/global/firebase_config.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/notifications/data/api_push_token_data_source.dart';
import 'package:starter/core/notifications/data/firebase_messaging_data_source.dart';
import 'package:starter/core/notifications/data/mock_messaging_data_source.dart';
import 'package:starter/core/notifications/data/mock_push_token_data_source.dart';
import 'package:starter/core/notifications/domain/messaging_data_source.dart';
import 'package:starter/core/notifications/domain/push_notification_repository.dart';
import 'package:starter/core/notifications/domain/push_token_data_source.dart';
import 'package:starter/core/notifications/domain/push_token_repository.dart';
import 'package:starter/core/notifications/push_navigation_resolver.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class NotificationsModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  List<Unregister> get unregisterCallbacks => [
    () => unregisterIfRegistered<PushTokenRepository>(
      disposingFunction: (repo) => repo.dispose(),
    ),
    unregisterIfRegistered<PushNotificationRepository>,
    unregisterIfRegistered<PushTokenDataSource>,
    () => unregisterIfRegistered<MessagingDataSource>(
      disposingFunction: (dataSource) => dataSource.dispose(),
    ),
    unregisterIfRegistered<PushNavigationResolver>,
  ];

  @override
  void register() {
    getIt
      ..registerLazySingleton<PushNavigationResolver>(
        PushNavigationResolver.new,
      )
      ..registerLazySingleton<MessagingDataSource>(() {
        // Firebase path is an example — see FirebaseConfig.
        if (useMock || !FirebaseConfig.enabled) {
          return const MockMessagingDataSource();
        }

        return FirebaseMessagingDataSource(FirebaseMessaging.instance);
      })
      ..registerLazySingleton<PushTokenDataSource>(() {
        if (useMock) {
          return const MockPushTokenDataSource();
        }

        return ApiPushTokenDataSource(getIt<ApiClient>());
      })
      ..registerLazySingleton<PushNotificationRepository>(
        () => PushNotificationRepository(getIt<MessagingDataSource>()),
      )
      ..registerLazySingleton<PushTokenRepository>(
        () => PushTokenRepository(
          const RawRepositoryExecutor().withErrorHandling().withRetry(
            maxRetries: 3,
            retryDelay: const Duration(seconds: 2),
          ),
          getIt<MessagingDataSource>(),
          getIt<PushTokenDataSource>(),
          getIt<FlutterSecureStorage>(),
        ),
      );
  }
}
