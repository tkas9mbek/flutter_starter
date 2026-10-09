import 'package:starter/core/remote_config/domain/remote_config_data_source.dart';
import 'package:starter/core/remote_config/domain/remote_config_registry.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';

class MockRemoteConfigDataSource implements RemoteConfigDataSource {
  const MockRemoteConfigDataSource(this._registry, this._network);

  final RemoteConfigRegistry _registry;
  final MockNetworkBehavior _network;

  @override
  Stream<void> get updates => const Stream<void>.empty();

  // delay(), not simulate(): this twin also serves non-mock builds without
  // Firebase, where a random failure would be a real bug.
  @override
  Future<T> get<T extends RemoteConfigEntry>() async {
    await _network.delay();

    return _registry.descriptorFor<T>().defaultValue;
  }
}
