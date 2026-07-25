import 'package:starter/core/remote_config/model/remote_config_entry.dart';

/// Service-locator data source over Firebase Remote Config. Resolves a
/// strongly-typed config by its model type: `get<RemoteGeneralSettings>()`.
abstract class RemoteConfigDataSource {
  Future<T> get<T extends RemoteConfigEntry>();

  /// Emits whenever the activated remote config changes (Firebase realtime
  /// updates). Carries no payload — listeners re-read via [get].
  Stream<void> get updates;
}
