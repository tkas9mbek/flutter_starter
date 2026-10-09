import 'package:starter/features/profile/data/mock/mock_profile_scenarios.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';

class MockProfileDataSource implements ProfileDataSource {
  const MockProfileDataSource(this._network);

  final MockNetworkBehavior _network;

  @override
  Future<User> getUserProfile() async {
    await _network.simulate();

    return MockProfileScenarios.user;
  }
}
