/// Contract for delivering the device push token to the backend.
abstract class PushTokenDataSource {
  Future<void> postPushToken(String token);
}
