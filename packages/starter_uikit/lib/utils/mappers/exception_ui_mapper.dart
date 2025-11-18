import 'package:flutter/widgets.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/models/exception_ui_model.dart';

/// Maps domain exceptions to UI models with localization.
///
/// Methods are auto-generated from @ExceptionUiConfig annotations.
/// Run: dart run tool/generate_exception_mapper.dart
class ExceptionUiMapper {
  final BuildContext context;
  late final UiLocalizer _localizer;

  ExceptionUiMapper(this.context) {
    _localizer = UiLocalizer.of(context);
  }

  // START GENERATED METHODS
  /// Maps domain exception to UI model
  ExceptionUiModel map(AppException exception) {
    return exception.when(
      noInternet: mapNoInternet,
      server: mapServer,
      unauthorized: mapUnauthorized,
      forbidden: mapForbidden,
      internalServerError: mapInternalServerError,
      unknown: mapUnknown,
      development: mapDevelopment,
      urlLaunchFailed: mapUrlLaunchFailed,
    );
  }

  /// Maps NoInternetException
  @protected
  ExceptionUiModel mapNoInternet() {
    return ExceptionUiModel(
      title: _localizer.errorMessageNoConnection,
      description: _localizer.errorMessageCouldNotConnectServer,
      snackbarDescription: _localizer.errorMessageNoConnection,
      canRefresh: true,
      canRetry: true,
    );
  }

  /// Maps ServerException
  @protected
  ExceptionUiModel mapServer(int? statusCode, String? message) {
    return ExceptionUiModel(
      title: _localizer.errorMessageErrorWhileRequesting,
      description: message ?? _localizer.errorMessageDefaultRequestError,
      snackbarDescription: message ?? _localizer.errorMessageDefaultRequestError,
      canRefresh: true,
      canRetry: true,
    );
  }

  /// Maps UnauthorizedException
  @protected
  ExceptionUiModel mapUnauthorized(String? message) {
    return ExceptionUiModel(
      description: message ?? _localizer.errorMessageAuthRequired,
      snackbarDescription: message ?? _localizer.errorMessageAuthRequired,
      canRefresh: false,
      canRetry: false,
    );
  }

  /// Maps ForbiddenException
  @protected
  ExceptionUiModel mapForbidden(String? message) {
    return ExceptionUiModel(
      description: message ?? _localizer.errorMessageNoRightsToView,
      snackbarDescription: message ?? _localizer.errorMessageNoRightsToPerform,
      canRefresh: false,
      canRetry: false,
    );
  }

  /// Maps InternalServerErrorException
  @protected
  ExceptionUiModel mapInternalServerError(String? message) {
    return ExceptionUiModel(
      title: _localizer.errorMessageServerError,
      description: message ?? _localizer.errorMessageServerInternalError,
      snackbarDescription: message ?? _localizer.errorMessageServerInternalError,
      canRefresh: true,
      canRetry: true,
    );
  }

  /// Maps UnknownException
  @protected
  ExceptionUiModel mapUnknown(Object error, StackTrace stackTrace) {
    return ExceptionUiModel(
      description: _localizer.errorMessageUnexpectedError,
      snackbarDescription: _localizer.errorMessageUnexpectedError,
      canRefresh: true,
      canRetry: true,
    );
  }

  /// Maps DevelopmentException
  @protected
  ExceptionUiModel mapDevelopment() {
    return ExceptionUiModel(
      description: _localizer.errorMessageMobileBug,
      snackbarDescription: _localizer.errorMessageMobileBug,
      canRefresh: false,
      canRetry: false,
    );
  }

  /// Maps UrlLaunchFailedException
  @protected
  ExceptionUiModel mapUrlLaunchFailed() {
    return ExceptionUiModel(
      description: _localizer.errorMessageUrlLaunchError,
      snackbarDescription: _localizer.errorMessageUrlLaunchError,
      canRefresh: false,
      canRetry: false,
    );
  }

  // END GENERATED METHODS
}
