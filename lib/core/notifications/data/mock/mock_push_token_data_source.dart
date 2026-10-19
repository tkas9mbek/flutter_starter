import 'package:starter/core/notifications/domain/push_token_data_source.dart';

class MockPushTokenDataSource implements PushTokenDataSource {
  const MockPushTokenDataSource();

  @override
  Future<void> postPushToken(String token) async {}
}
