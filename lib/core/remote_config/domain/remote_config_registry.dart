import 'package:starter/core/remote_config/model/remote_config_entry.dart';

/// Maps a [RemoteConfigEntry] type to the Firebase Remote Config parameter
/// that backs it: the parameter [key], its JSON parser, and the offline
/// [defaultValue] returned when the key is missing or empty.
class RemoteConfigDescriptor<T extends RemoteConfigEntry> {
  const RemoteConfigDescriptor({
    required this.key,
    required this.fromJson,
    required this.defaultValue,
  });

  final String key;
  final T Function(Map<String, dynamic> json) fromJson;
  final T defaultValue;

  Type get type => T;
}

/// Service-locator registry of [RemoteConfigDescriptor]s keyed by entry type.
///
/// [RemoteConfigDataSource] resolves a descriptor by `T`, so a caller can
/// read any registered config with `get<T>()` without knowing its key.
class RemoteConfigRegistry {
  RemoteConfigRegistry(List<RemoteConfigDescriptor> descriptors)
    : _descriptors = {
        for (final descriptor in descriptors) descriptor.type: descriptor,
      };

  final Map<Type, RemoteConfigDescriptor> _descriptors;

  RemoteConfigDescriptor<T> descriptorFor<T extends RemoteConfigEntry>() {
    final descriptor = _descriptors[T];

    if (descriptor is! RemoteConfigDescriptor<T>) {
      throw StateError('No RemoteConfigDescriptor registered for type $T');
    }

    return descriptor;
  }
}
