import 'package:starter_toolkit/data/repository_cache/repository_cache.dart';

/// In-memory [RepositoryCache] with lazy, sweep-on-write eviction.
///
/// Register as an app-wide singleton. Eviction is lazy: an expired entry found
/// on read is removed and refetched, and every successful write sweeps other
/// expired entries — bounding memory without a leakable timer.
class InMemoryRepositoryCache extends RepositoryCache {
  InMemoryRepositoryCache({
    this.defaultTtl = const Duration(minutes: 5),
  });

  final Duration defaultTtl;
  final Map<String, _CacheEntry> _cache = {};

  @override
  Future<T> getOrFetch<T>(
    Future<T> Function() fetch, {
    required String key,
    Duration? ttl,
  }) async {
    final cached = _cache[key];
    if (cached != null && !cached.isExpired) {
      return cached.data as T;
    }

    final data = await fetch();

    _cache
      ..[key] = _CacheEntry(
        data: data as Object,
        timestamp: DateTime.now(),
        duration: ttl ?? defaultTtl,
      )
      ..removeWhere((_, entry) => entry.isExpired);

    return data;
  }

  @override
  void invalidate([String? key]) {
    if (key != null) {
      _cache.remove(key);
    } else {
      _cache.clear();
    }
  }
}

class _CacheEntry {
  const _CacheEntry({
    required this.data,
    required this.timestamp,
    required this.duration,
  });

  final Object data;
  final DateTime timestamp;
  final Duration duration;

  bool get isExpired => DateTime.now().difference(timestamp) > duration;
}
