import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class ApiAuthAuthorizedDataSource implements AuthAuthorizedDataSource {
  const ApiAuthAuthorizedDataSource(this._client);

  final ApiClient _client;

  @override
  Future<void> logout() {
    return _client.requestVoid(method: HttpMethod.post, path: '/auth/logout');
  }
}
