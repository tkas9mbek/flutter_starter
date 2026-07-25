import 'package:starter/core/notifications/domain/messaging_data_source.dart';
import 'package:starter/core/notifications/model/push_message.dart';

class MockMessagingDataSource implements MessagingDataSource {
  const MockMessagingDataSource();

  @override
  Future<String?> getToken() async => 'mock_push_token';

  @override
  Stream<String> get tokenChanges => const Stream<String>.empty();

  @override
  Stream<PushMessage> get messages => const Stream<PushMessage>.empty();

  @override
  Future<PushMessage?> getInitialMessage() async => null;

  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> dispose() async {}
}
