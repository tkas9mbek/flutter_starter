import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/core/global/storage_keys.dart';
import 'package:starter/core/notifications/data/mock/mock_messaging_data_source.dart';
import 'package:starter/core/notifications/data/mock/mock_push_token_data_source.dart';
import 'package:starter/core/notifications/domain/messaging_data_source.dart';
import 'package:starter/core/notifications/domain/push_token_data_source.dart';
import 'package:starter/core/notifications/domain/push_token_repository.dart';
import 'package:starter/core/notifications/model/push_message.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

/// Messaging double whose current token and rotations the test controls.
class _ControllableMessagingDataSource implements MessagingDataSource {
  _ControllableMessagingDataSource(this.token);

  String? token;
  final _tokenChanges = StreamController<String>.broadcast();

  void rotate(String newToken) => _tokenChanges.add(newToken);

  @override
  Future<String?> getToken() async => token;

  @override
  Stream<String> get tokenChanges => _tokenChanges.stream;

  @override
  Stream<PushMessage> get messages => const Stream<PushMessage>.empty();

  @override
  Future<PushMessage?> getInitialMessage() async => null;

  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> dispose() => _tokenChanges.close();
}

class _RecordingPushTokenDataSource implements PushTokenDataSource {
  final posted = <String>[];

  @override
  Future<void> postPushToken(String token) async => posted.add(token);
}

class _ThrowingPushTokenDataSource implements PushTokenDataSource {
  const _ThrowingPushTokenDataSource();

  @override
  Future<void> postPushToken(String token) async =>
      throw const NoInternetException();
}

void main() {
  late MockFlutterSecureStorage storage;
  late Map<String, String> stored;

  setUp(() {
    storage = MockFlutterSecureStorage();
    stored = <String, String>{};

    when(() => storage.read(key: any(named: 'key'))).thenAnswer(
      (invocation) async => stored[invocation.namedArguments[#key] as String],
    );
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer(
      (invocation) async => stored[invocation.namedArguments[#key] as String] =
          invocation.namedArguments[#value] as String,
    );
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer(
      (invocation) async =>
          stored.remove(invocation.namedArguments[#key] as String),
    );
  });

  PushTokenRepository buildRepository(
    MessagingDataSource messaging,
    PushTokenDataSource pushTokenDataSource,
  ) {
    final repository = PushTokenRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      messaging,
      pushTokenDataSource,
      storage,
    );
    addTearDown(repository.dispose);

    return repository;
  }

  test('posts the current token through the twins and remembers it', () async {
    final repository = buildRepository(
      const MockMessagingDataSource(),
      const MockPushTokenDataSource(),
    );

    await repository.postCurrentToken();
    await repository.postCurrentToken();

    expect(stored[SecureStorageKeys.lastPushToken], 'mock_push_token');
    verify(
      () => storage.write(
        key: SecureStorageKeys.lastPushToken,
        value: 'mock_push_token',
      ),
    ).called(1);
  });

  test('does not re-post a token that was already sent', () async {
    stored[SecureStorageKeys.lastPushToken] = 'token-a';
    final pushTokenDataSource = _RecordingPushTokenDataSource();
    final repository = buildRepository(
      _ControllableMessagingDataSource('token-a'),
      pushTokenDataSource,
    );

    await repository.postCurrentToken();

    expect(pushTokenDataSource.posted, isEmpty);
  });

  test('posts nothing when the SDK has no token', () async {
    final pushTokenDataSource = _RecordingPushTokenDataSource();
    final repository = buildRepository(
      _ControllableMessagingDataSource(null),
      pushTokenDataSource,
    );

    await repository.postCurrentToken();

    expect(pushTokenDataSource.posted, isEmpty);
    verifyNever(() => storage.read(key: any(named: 'key')));
  });

  test('clearToken makes the next postCurrentToken re-post', () async {
    final pushTokenDataSource = _RecordingPushTokenDataSource();
    final repository = buildRepository(
      _ControllableMessagingDataSource('token-a'),
      pushTokenDataSource,
    );

    await repository.postCurrentToken();
    await repository.clearToken();
    await repository.postCurrentToken();

    expect(pushTokenDataSource.posted, ['token-a', 'token-a']);
  });

  test('posts a rotated token and skips a repeated rotation', () async {
    final messaging = _ControllableMessagingDataSource('token-a');
    addTearDown(messaging.dispose);
    final pushTokenDataSource = _RecordingPushTokenDataSource();
    buildRepository(messaging, pushTokenDataSource);

    messaging.rotate('token-b');
    await pumpEventQueue();
    messaging.rotate('token-b');
    await pumpEventQueue();

    expect(pushTokenDataSource.posted, ['token-b']);
    expect(stored[SecureStorageKeys.lastPushToken], 'token-b');
  });

  test('stops listening for rotations after dispose', () async {
    final messaging = _ControllableMessagingDataSource('token-a');
    addTearDown(messaging.dispose);
    final pushTokenDataSource = _RecordingPushTokenDataSource();
    final repository = buildRepository(messaging, pushTokenDataSource);

    await repository.dispose();
    messaging.rotate('token-b');
    await pumpEventQueue();

    expect(pushTokenDataSource.posted, isEmpty);
  });

  test(
    'a failed post is swallowed and not remembered, so it retries',
    () async {
      final repository = buildRepository(
        _ControllableMessagingDataSource('token-a'),
        const _ThrowingPushTokenDataSource(),
      );

      await expectLater(repository.postCurrentToken(), completes);

      expect(stored, isNot(contains(SecureStorageKeys.lastPushToken)));
      verifyNever(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      );
    },
  );
}
