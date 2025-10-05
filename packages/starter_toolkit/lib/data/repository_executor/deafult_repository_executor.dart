import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/exceptions/development_error.dart';
import 'package:starter_toolkit/data/exceptions/unknown_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class DefaultRepositoryExecutor extends RepositoryExecutor {
  const DefaultRepositoryExecutor();

  @override
  Future<T> execute<T>(Function() function) async {
    try {
      final result = await function();
      return result;
    } on DioException catch (e, stackTrace) {
      if (e is AppException) {
        rethrow;
      } else if (e.error is AppException) {
        throw e.error! as AppException;
      } else {
        throw UnknownException(e, stackTrace);
      }
    } on AppException catch (_) {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw UnknownException(e, stackTrace);
    } catch (e) {
      if (kDebugMode) {
        rethrow;
      }

      throw DevelopmentError();
    }
  }
}
