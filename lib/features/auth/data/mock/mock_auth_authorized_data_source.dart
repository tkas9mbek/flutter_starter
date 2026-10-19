import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';

class MockAuthAuthorizedDataSource implements AuthAuthorizedDataSource {
  const MockAuthAuthorizedDataSource(this._network);

  final MockNetworkBehavior _network;

  @override
  Future<void> logout() async {
    await _network.simulate();
  }
}
