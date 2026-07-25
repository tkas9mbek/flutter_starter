import 'dart:async';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter/core/global/storage_keys.dart';
import 'package:starter/core/notifications/domain/messaging_data_source.dart';
import 'package:starter/core/notifications/domain/push_token_data_source.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';
/// Owns the device push-token lifecycle: posts the token to the backend only
/// when it differs from the last one sent (persisted in secure storage), and
/// re-posts automatically whenever the SDK rotates the token.
class PushTokenRepository {
  PushTokenRepository(
    this._repositoryExecutor,
    this._messagingDataSource,
    this._pushTokenDataSource,
    this._secureStorage,
  ) {
    _tokenSubscription = _messagingDataSource.tokenChanges.listen(
      (token) => unawaited(_postSafely(token)),
    );
  }

  final RepositoryExecutor _repositoryExecutor;
  final MessagingDataSource _messagingDataSource;
  final PushTokenDataSource _pushTokenDataSource;
  final FlutterSecureStorage _secureStorage;
  StreamSubscription<String>? _tokenSubscription;

  /// Posts the current token if it changed. Call after the user authenticates.
  Future<void> postCurrentToken() async {
    final token = await _messagingDataSource.getToken();

    if (token == null) {
      return;
    }

    await _postSafely(token);
  }

  /// Forgets the last-sent token so the next [postCurrentToken] re-posts.
  Future<void> clearToken() =>
      _secureStorage.delete(key: SecureStorageKeys.lastPushToken);

  Future<void> dispose() async {
    await _tokenSubscription?.cancel();
  }

  Future<void> _postSafely(String token) async {
    try {
      final lastToken = await _secureStorage.read(
        key: SecureStorageKeys.lastPushToken,
      );

      if (lastToken == token) {
        return;
      }

      await _repositoryExecutor.execute(
        () => _pushTokenDataSource.postPushToken(token),
      );

      await _secureStorage.write(
        key: SecureStorageKeys.lastPushToken,
        value: token,
      );
    } on AppException catch (e) {
      log('Push token post failed: ${e.name}', name: 'PushTokenRepository');
    }
  }
}
