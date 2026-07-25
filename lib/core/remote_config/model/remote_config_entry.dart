/// Marker base type every Firebase Remote Config payload model implements.
///
/// The type itself is the lookup key for [RemoteConfigDataSource.get], so a
/// caller can resolve a config with `dataSource.get<RemoteGeneralSettings>()`.
abstract class RemoteConfigEntry {
  const RemoteConfigEntry();
}
