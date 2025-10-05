import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/server_exception.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

class AuthException extends ServerException {
  const AuthException(String message)
      : super(message: message, statusCode: 401);

  @override
  String getDescription(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageAuthRequired;

  @override
  bool get canRefresh => false;
}
