import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_toolkit/data/exceptions/annotations.dart';

part 'app_exception.freezed.dart';

/// Domain exception containing minimal error data.
///
/// Pure data class with no UI dependencies.
/// Use ExceptionUiMapper from starter_uikit to convert to UI model for display.
@freezed
class AppException with _$AppException implements Exception {
  const AppException._();

  /// No internet connection
  @ExceptionUiConfig(
    titleKey: 'errorMessageNoConnection',
    descriptionKey: 'errorMessageCouldNotConnectServer',
    snackbarKey: 'errorMessageNoConnection',
  )
  const factory AppException.noInternet() = _NoInternetAppException;

  /// Server error with status code and optional message
  @ExceptionUiConfig(
    titleKey: 'errorMessageErrorWhileRequesting',
    descriptionKey: 'errorMessageDefaultRequestError',
  )
  const factory AppException.server({
    required int? statusCode,
    String? message,
  }) = _ServerAppException;

  /// Authentication error (401)
  @ExceptionUiConfig(
    descriptionKey: 'errorMessageAuthRequired',
    canRetry: false,
    canRefresh: false,
  )
  const factory AppException.unauthorized({
    String? message,
  }) = _UnauthorizedAppException;

  /// Forbidden error (403)
  @ExceptionUiConfig(
    descriptionKey: 'errorMessageNoRightsToView',
    snackbarKey: 'errorMessageNoRightsToPerform',
    canRetry: false,
    canRefresh: false,
  )
  const factory AppException.forbidden({
    String? message,
  }) = _ForbiddenAppException;

  /// Internal server error (500)
  @ExceptionUiConfig(
    titleKey: 'errorMessageServerError',
    descriptionKey: 'errorMessageServerInternalError',
  )
  const factory AppException.internalServerError({
    String? message,
  }) = _InternalServerErrorAppException;

  /// Unknown/unexpected error with details
  @ExceptionUiConfig(
    descriptionKey: 'errorMessageUnexpectedError',
  )
  const factory AppException.unknown({
    required Object error,
    required StackTrace stackTrace,
  }) = _UnknownAppException;

  /// Development/programming error
  @ExceptionUiConfig(
    descriptionKey: 'errorMessageMobileBug',
    canRetry: false,
    canRefresh: false,
  )
  const factory AppException.development() = _DevelopmentAppException;

  /// URL launch failure
  @ExceptionUiConfig(
    descriptionKey: 'errorMessageUrlLaunchError',
    canRetry: false,
    canRefresh: false,
  )
  const factory AppException.urlLaunchFailed() = _UrlLaunchFailedAppException;

  /// Exception type identifier for logging
  String get type => when(
        noInternet: () => 'NoInternet',
        server: (_, __) => 'Server',
        unauthorized: (_) => 'Unauthorized',
        forbidden: (_) => 'Forbidden',
        internalServerError: (_) => 'InternalServerError',
        unknown: (_, __) => 'Unknown',
        development: () => 'Development',
        urlLaunchFailed: () => 'UrlLaunchFailed',
      );
}
