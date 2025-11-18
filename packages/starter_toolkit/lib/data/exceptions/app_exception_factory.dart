import 'package:dio/dio.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

/// Factory for creating exceptions from HTTP responses.
class AppExceptionFactory {
  const AppExceptionFactory._();

  /// Creates exception from Dio response.
  static AppException fromDioResponse({
    int? statusCode,
    Response? response,
  }) {
    final responseData = response?.data;

    String? message;
    if (responseData is Map<String, dynamic>) {
      message = responseData['message'] as String?;
    }

    switch (statusCode) {
      case 401:
        return AppException.unauthorized(message: message);
      case 403:
        return AppException.forbidden(message: message);
      case 500:
        return AppException.internalServerError(message: message);
      default:
        return AppException.server(
          statusCode: statusCode,
          message: message,
        );
    }
  }
}
