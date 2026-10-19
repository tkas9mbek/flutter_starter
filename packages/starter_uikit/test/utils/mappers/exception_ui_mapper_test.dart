import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/models/exception_ui_model.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';

import '../../support/pump_app.dart';

void main() {
  final cases =
      <String, (AppException, ExceptionUiModel Function(UikitLocalizer))>{
        'NoInternetException': (
          const NoInternetException(),
          (l10n) => ExceptionUiModel(
            title: l10n.errorMessageNoConnection,
            description: l10n.errorMessageCouldNotConnectServer,
            snackbarDescription: l10n.errorMessageNoConnection,
          ),
        ),
        'ServerException without message': (
          const ServerException(statusCode: 418),
          (l10n) => ExceptionUiModel(
            title: l10n.errorMessageErrorWhileRequesting,
            description: l10n.errorMessageDefaultRequestError,
            snackbarDescription: l10n.errorMessageDefaultRequestError,
          ),
        ),
        'ServerException with message': (
          const ServerException(statusCode: 418, message: 'Teapot'),
          (l10n) => ExceptionUiModel(
            title: l10n.errorMessageErrorWhileRequesting,
            description: 'Teapot',
            snackbarDescription: 'Teapot',
          ),
        ),
        'UnauthorizedException without message': (
          const UnauthorizedException(),
          (l10n) => ExceptionUiModel.noRetry(
            description: l10n.errorMessageAuthRequired,
          ),
        ),
        'UnauthorizedException with message': (
          const UnauthorizedException(message: 'Session expired'),
          (_) => const ExceptionUiModel.noRetry(description: 'Session expired'),
        ),
        'ForbiddenException without message': (
          const ForbiddenException(),
          (l10n) => ExceptionUiModel.noRetry(
            description: l10n.errorMessageNoRightsToView,
            snackbarDescription: l10n.errorMessageNoRightsToPerform,
          ),
        ),
        'ForbiddenException with message': (
          const ForbiddenException(message: 'Admins only'),
          (_) => const ExceptionUiModel.noRetry(description: 'Admins only'),
        ),
        'InternalServerErrorException without message': (
          const InternalServerErrorException(),
          (l10n) => ExceptionUiModel(
            title: l10n.errorMessageServerError,
            description: l10n.errorMessageServerInternalError,
            snackbarDescription: l10n.errorMessageServerInternalError,
          ),
        ),
        'InternalServerErrorException with message': (
          const InternalServerErrorException(message: 'Down'),
          (l10n) => ExceptionUiModel(
            title: l10n.errorMessageServerError,
            description: 'Down',
            snackbarDescription: 'Down',
          ),
        ),
        'UnknownException': (
          const UnknownException(error: 'boom', stackTrace: StackTrace.empty),
          (l10n) => ExceptionUiModel.noRetry(
            description: l10n.errorMessageUnexpectedError,
          ),
        ),
        'DevelopmentException': (
          const DevelopmentException(),
          (l10n) =>
              ExceptionUiModel.noRetry(description: l10n.errorMessageMobileBug),
        ),
        'UrlLaunchFailedException': (
          const UrlLaunchFailedException(),
          (l10n) => ExceptionUiModel.noRetry(
            description: l10n.errorMessageUrlLaunchError,
          ),
        ),
      };

  group(
    'ExceptionUiMapper',
    () => cases.forEach(
      (name, spec) => testWidgets('maps $name', (tester) async {
        final (exception, expected) = spec;

        await tester.pumpApp(const SizedBox());

        final context = tester.element(find.byType(Scaffold));
        final model = ExceptionUiMapper(context).map(exception);

        expect(model, expected(tester.uikitL10n));
        expect(model.canRetry, exception.canRetry);
      }),
    ),
  );
}
