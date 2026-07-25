import 'package:starter/core/remote_config/domain/remote_config_data_source.dart';
import 'package:starter/core/remote_config/domain/remote_config_registry.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';

class MockRemoteConfigDataSource implements RemoteConfigDataSource {
  const MockRemoteConfigDataSource(this._registry);

  final RemoteConfigRegistry _registry;

  @override
  Stream<void> get updates => const Stream<void>.empty();

  @override
  Future<T> get<T extends RemoteConfigEntry>() async {
    await Future.delayed(const Duration(seconds: 2));

    return _registry.descriptorFor<T>().defaultValue;
  }
}
