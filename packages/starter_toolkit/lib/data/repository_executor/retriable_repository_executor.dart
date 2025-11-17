import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/exceptions/development_error.dart';
import 'package:starter_toolkit/data/exceptions/unknown_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

/// Repository executor with automatic retry logic and exponential backoff.
///
/// Retries failed operations up to [maxRetries] times, skipping 4xx client errors.
class RetriableRepositoryExecutor extends RepositoryExecutor {
  const RetriableRepositoryExecutor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  final int maxRetries;
  final Duration retryDelay;

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    Exception? lastException;

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        final result = await function();
        return result;
      } on DioException catch (e, stackTrace) {
        lastException = e;

        // Don't retry client errors (4xx) except network issues
        final statusCode = e.response?.statusCode;
        if (statusCode != null && statusCode >= 400 && statusCode < 500) {
          // Map and throw immediately for client errors
          if (e.error is AppException) {
            throw e.error! as AppException;
          }
          throw UnknownException(e, stackTrace);
        }

        // Check if this is the last attempt
        if (attempt == maxRetries - 1) {
          // Last attempt failed, throw the error
          if (e.error is AppException) {
            throw e.error! as AppException;
          }
          throw UnknownException(e, stackTrace);
        }

        // Wait before retry with exponential backoff
        await Future.delayed(retryDelay * (attempt + 1));
        continue;
      } on AppException {
        // Don't retry business exceptions
        rethrow;
      } on Exception catch (e, stackTrace) {
        lastException = e;

        // Last attempt for generic exceptions
        if (attempt == maxRetries - 1) {
          throw UnknownException(e, stackTrace);
        }

        // Retry with exponential backoff
        await Future.delayed(retryDelay * (attempt + 1));
        continue;
      } catch (e) {
        // Non-Exception errors (shouldn't happen but handle anyway)
        if (kDebugMode) {
          rethrow;
        }
        throw DevelopmentError();
      }
    }

    // This shouldn't be reached, but just in case
    if (lastException != null) {
      throw UnknownException(lastException, StackTrace.current);
    }
    throw DevelopmentError();
  }
}
