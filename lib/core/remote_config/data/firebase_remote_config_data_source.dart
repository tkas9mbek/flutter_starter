import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:starter/core/remote_config/domain/remote_config_data_source.dart';
import 'package:starter/core/remote_config/domain/remote_config_registry.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';

class FirebaseRemoteConfigDataSource implements RemoteConfigDataSource {
  const FirebaseRemoteConfigDataSource(this._remoteConfig, this._registry);

  final FirebaseRemoteConfig _remoteConfig;
  final RemoteConfigRegistry _registry;

  @override
  Stream<void> get updates =>
      _remoteConfig.onConfigUpdated.asyncMap((_) => _remoteConfig.activate());

  @override
  Future<T> get<T extends RemoteConfigEntry>() async {
    final descriptor = _registry.descriptorFor<T>();

    await _remoteConfig.fetchAndActivate();

    final raw = _remoteConfig.getString(descriptor.key);

    if (raw.isEmpty) {
      return descriptor.defaultValue;
    }

    final decoded = jsonDecode(raw);
    // List-valued parameters (e.g. phone_code) are wrapped so every
    // descriptor can keep a Map-based fromJson.
    final json = decoded is List
        ? <String, dynamic>{'items': decoded}
        : decoded as Map<String, dynamic>;

    return descriptor.fromJson(json);
  }
}
