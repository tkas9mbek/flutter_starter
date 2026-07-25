import 'package:dio/dio.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Normalizes any thrown error into an [AppException].
///
/// Must sit innermost (closest to the raw executor) so outer decorators such as
/// the retry executor see already-normalized [AppException]s.
class ErrorHandlingExecutor extends RepositoryExecutorDecorator {
  const ErrorHandlingExecutor(super.wrapped);

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    try {
      return await wrapped.execute(function);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error! as AppException;
      }

      throw AppException.fromDioResponse(
        statusCode: e.response?.statusCode,
        response: e.response,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      var isDebugMode = false;
      assert(() {
        isDebugMode = true;

        return true;
      }());

      // Surface unexpected errors in debug; hide them behind a generic exception in release.
      if (isDebugMode) {
        rethrow;
      }

      throw const DevelopmentException();
    }
  }
}
