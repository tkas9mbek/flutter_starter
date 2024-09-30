import 'package:dio/dio.dart';
import 'package:flutter_starter/core/data/exceptions/app_exception.dart';
import 'package:flutter_starter/core/data/exceptions/unknown_exception.dart';
import 'package:flutter_starter/core/data/repository_executor/repository_executor.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RepositoryExecutor)
class DefaultRepositoryExecutor extends RepositoryExecutor {
  DefaultRepositoryExecutor();

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
    } on Exception catch (e, stackTrace) {
      throw UnknownException(e, stackTrace);
    } catch (e) {
      rethrow;
    }
  }
}
