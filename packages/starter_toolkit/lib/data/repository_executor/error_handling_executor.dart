import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/exceptions/app_exception_factory.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Decorator that handles and normalizes errors to AppException.
///
/// This decorator should be the first in the chain (closest to raw executor)
/// to ensure all errors are properly handled.
class ErrorHandlingExecutor extends RepositoryExecutorDecorator {
  const ErrorHandlingExecutor(super.wrapped);

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    try {
      return await wrapped.execute(function);
    } on DioException catch (e, stackTrace) {
      // Already wrapped as AppException
      if (e.error is AppException) {
        throw e.error! as AppException;
      }

      // Create AppException from Dio response
      throw AppExceptionFactory.fromDioResponse(
        statusCode: e.response?.statusCode,
        response: e.response,
      );
    } on AppException {
      // Already an AppException, just rethrow
      rethrow;
    } catch (e, stackTrace) {
      // Unknown error - rethrow in debug mode for easier debugging
      if (kDebugMode) {
        rethrow;
      }
      // In production, wrap as development error
      throw const AppException.development();
    }
  }
}
