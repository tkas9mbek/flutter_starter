import 'package:dio/dio.dart';
import 'package:starter_toolkit/data/exceptions/annotations.dart';

/// Domain exception carrying minimal error data, with no UI dependencies.
///
/// Convert to a UI model via `ExceptionUiMapper` in
/// `starter_uikit/lib/utils/mappers/exception_ui_mapper.dart`. Adding or renaming a subtype
/// here, or changing its `@ExceptionUiConfig`, requires rerunning that mapper's generator.
sealed class AppException implements Exception {
  const AppException();

  /// Exception type identifier used for logging.
  String get name;

  bool get canRetry;

  /// Creates exception from Dio response.
  static AppException fromDioResponse({int? statusCode, Response? response}) {
    final responseData = response?.data;

    String? message;
    if (responseData is Map<String, dynamic>) {
      message = responseData['message'] as String?;
    }

    switch (statusCode) {
      case 401:
        return UnauthorizedException(message: message);
      case 403:
        return ForbiddenException(message: message);
      case 500:
        return InternalServerErrorException(message: message);
      default:
        return ServerException(statusCode: statusCode, message: message);
    }
  }
}

/// No internet connection
@ExceptionUiConfig(
  titleKey: 'errorMessageNoConnection',
  descriptionKey: 'errorMessageCouldNotConnectServer',
  snackbarKey: 'errorMessageNoConnection',
)
final class NoInternetException extends AppException {
  const NoInternetException();

  @override
  String get name => 'NoInternet';

  @override
  bool get canRetry => true;
}

/// Server error with status code and optional message
@ExceptionUiConfig(
  titleKey: 'errorMessageErrorWhileRequesting',
  descriptionKey: 'errorMessageDefaultRequestError',
)
final class ServerException extends AppException {
  const ServerException({required this.statusCode, this.message});

  final int? statusCode;
  final String? message;

  @override
  String get name => 'Server';

  @override
  bool get canRetry => true;
}

/// Authentication error (401)
@ExceptionUiConfig(descriptionKey: 'errorMessageAuthRequired')
final class UnauthorizedException extends AppException {
  const UnauthorizedException({this.message});

  final String? message;

  @override
  String get name => 'Unauthorized';

  @override
  bool get canRetry => false;
}

/// Forbidden error (403)
@ExceptionUiConfig(
  descriptionKey: 'errorMessageNoRightsToView',
  snackbarKey: 'errorMessageNoRightsToPerform',
)
final class ForbiddenException extends AppException {
  const ForbiddenException({this.message});

  final String? message;

  @override
  String get name => 'Forbidden';

  @override
  bool get canRetry => false;
}

/// Internal server error (500)
@ExceptionUiConfig(
  titleKey: 'errorMessageServerError',
  descriptionKey: 'errorMessageServerInternalError',
)
final class InternalServerErrorException extends AppException {
  const InternalServerErrorException({this.message});

  final String? message;

  @override
  String get name => 'InternalServerError';

  @override
  bool get canRetry => true;
}

/// Unknown/unexpected error with details
@ExceptionUiConfig(descriptionKey: 'errorMessageUnexpectedError')
final class UnknownException extends AppException {
  const UnknownException({required this.error, required this.stackTrace});

  final Object error;
  final StackTrace stackTrace;

  @override
  String get name => 'Unknown';

  @override
  bool get canRetry => true;
}

/// Development/programming error
@ExceptionUiConfig(descriptionKey: 'errorMessageMobileBug')
final class DevelopmentException extends AppException {
  const DevelopmentException();

  @override
  String get name => 'Development';

  @override
  bool get canRetry => false;
}

/// URL launch failure
@ExceptionUiConfig(descriptionKey: 'errorMessageUrlLaunchError')
final class UrlLaunchFailedException extends AppException {
  const UrlLaunchFailedException();

  @override
  String get name => 'UrlLaunchFailed';

  @override
  bool get canRetry => false;
}
