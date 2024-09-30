import 'package:flutter/material.dart';
import 'package:flutter_starter/core/data/exceptions/server_exception.dart';
import 'package:flutter_starter/generated/l10n.dart';

class RightsException extends ServerException {
  const RightsException()
      : super(
          message: null,
          statusCode: 403,
        );

  @override
  String getDescription(BuildContext context) =>
      S.of(context).errorMessageNoRightsToView;

  @override
  String getSnackbarDescription(BuildContext context) =>
      S.of(context).errorMessageNoRightsToPerform;

  @override
  bool get canRefresh => false;
}
