import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class RemoteProfileDataSource implements ProfileDataSource {
  final ApiClient _client;

  const RemoteProfileDataSource(this._client);

  @override
  Future<User> getUserProfile() => _client.requestJson<User>(
        method: HttpMethod.get,
        path: '/profile',
        fromJson: User.fromJson,
      );
}
