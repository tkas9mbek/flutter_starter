import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/models/exception_ui_model.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper_decorator.dart';

import '../../support/pump_app.dart';

const _offline = ExceptionUiModel.noRetry(description: 'Offline mode');

class _OfflineMapper extends ExceptionUiMapperDecorator {
  _OfflineMapper(super.context, super.wrapped);

  @override
  ExceptionUiModel mapNoInternet() => _offline;
}

void main() {
  final exceptions = <AppException>[
    const ServerException(statusCode: 500, message: 'boom'),
    const UnauthorizedException(),
    const ForbiddenException(message: 'nope'),
    const InternalServerErrorException(),
    const UnknownException(error: 'x', stackTrace: StackTrace.empty),
    const DevelopmentException(),
    const UrlLaunchFailedException(),
  ];

  group(
    'ExceptionUiMapperDecorator',
    () => testWidgets('uses the override and delegates every other mapping', (
      tester,
    ) async {
      await tester.pumpApp(const SizedBox());

      final context = tester.element(find.byType(Scaffold));
      final base = ExceptionUiMapper(context);
      final decorated = _OfflineMapper(context, base);

      expect(decorated.map(const NoInternetException()), _offline);

      for (final exception in exceptions) {
        expect(decorated.map(exception), base.map(exception));
      }
    }),
  );
}
