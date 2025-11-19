import 'dart:async';

import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Decorator adding time-based caching capability.
///
/// Provides [cached] method for executing operations with caching.
/// Regular [execute] method passes through without caching.
///
/// Automatically cleans up expired cache entries every 5 minutes.
class CachingExecutor extends RepositoryExecutorDecorator {
  final Duration defaultTtl;
  final Map<String, _CacheEntry> _cache = {};
  Timer? _cleanupTimer;

  CachingExecutor(
    super.wrapped, {
    this.defaultTtl = const Duration(minutes: 5),
  }) {
    _cleanupTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => _removeExpiredEntries(),
    );
  }

  void _removeExpiredEntries() {
    _cache.removeWhere((key, value) => value.isExpired);
  }

  @override
  Future<T> execute<T>(Future<T> Function() function) async =>
      wrapped.execute(function);

  /// Executes function with caching enabled.
  ///
  /// If [key] exists in cache and not expired, returns cached value.
  /// Otherwise executes function, caches result, and returns it.
  ///
  /// [ttl] overrides the default cache duration if provided.
  Future<T> cached<T>(
    Future<T> Function() function, {
    required String key,
    Duration? ttl,
  }) async {
    final cached = _cache[key];
    if (cached != null && !cached.isExpired) {
      return cached.data as T;
    }

    // Execute through wrapped executor chain
    final result = await wrapped.execute(function);

    // Store in cache
    _cache[key] = _CacheEntry(
      data: result as Object,
      timestamp: DateTime.now(),
      duration: ttl ?? defaultTtl,
    );

    return result;
  }

  /// Clears cache entries.
  ///
  /// If [key] is provided, clears only that entry.
  /// Otherwise clears all entries.
  void clearCache([String? key]) {
    if (key != null) {
      _cache.remove(key);
    } else {
      _cache.clear();
    }
  }

  /// Disposes resources including cleanup timer.
  ///
  /// Call this when the executor is no longer needed.
  void dispose() {
    _cleanupTimer?.cancel();
    _cache.clear();
  }
}

class _CacheEntry {
  final Object data;
  final DateTime timestamp;
  final Duration duration;

  const _CacheEntry({
    required this.data,
    required this.timestamp,
    required this.duration,
  });

  bool get isExpired => DateTime.now().difference(timestamp) > duration;
}
