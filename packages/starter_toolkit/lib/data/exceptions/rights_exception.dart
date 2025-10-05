import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/server_exception.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

class RightsException extends ServerException {
  const RightsException(String message)
      : super(
          message: message,
          statusCode: 403,
        );

  @override
  String getDescription(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageNoRightsToView;

  @override
  String getSnackbarDescription(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageNoRightsToPerform;

  @override
  bool get canRefresh => false;
}
