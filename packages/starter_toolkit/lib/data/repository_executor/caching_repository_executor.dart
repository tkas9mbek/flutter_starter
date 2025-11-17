import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/exceptions/development_error.dart';
import 'package:starter_toolkit/data/exceptions/unknown_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

/// Repository executor with simple caching capability
/// Demonstrates feature-specific executor implementation
class CachingRepositoryExecutor extends RepositoryExecutor {
  CachingRepositoryExecutor({
    this.cacheDuration = const Duration(minutes: 5),
  });

  final Duration cacheDuration;
  final Map<String, _CacheEntry> _cache = {};

  @override
  Future<T> execute<T>(Future<T> Function() function, {String? cacheKey}) async {
    // Try to get from cache if key provided
    if (cacheKey != null) {
      final cached = _cache[cacheKey];

      if (cached != null && !cached.isExpired) {
        return cached.data as T;
      }
    }

    try {
      final result = await function();

      // Cache the result if key provided
      if (cacheKey != null) {
        _cache[cacheKey] = _CacheEntry(
          data: result,
          timestamp: DateTime.now(),
          duration: cacheDuration,
        );
      }

      return result;
    } on DioException catch (e, stackTrace) {
      if (e.error is AppException) {
        throw e.error! as AppException;
      }
      throw UnknownException(e, stackTrace);
    } on AppException {
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      throw DevelopmentError();
    }
  }

  void clearCache([String? key]) {
    if (key != null) {
      _cache.remove(key);
    } else {
      _cache.clear();
    }
  }
}

class _CacheEntry {
  final Object data;
  final DateTime timestamp;
  final Duration duration;

  _CacheEntry({
    required this.data,
    required this.timestamp,
    required this.duration,
  });

  bool get isExpired => DateTime.now().difference(timestamp) > duration;
}
