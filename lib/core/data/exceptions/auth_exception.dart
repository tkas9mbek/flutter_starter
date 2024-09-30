import 'package:flutter/material.dart';
import 'package:flutter_starter/core/data/exceptions/server_exception.dart';
import 'package:flutter_starter/generated/l10n.dart';

class AuthException extends ServerException {
  const AuthException() : super(message: null, statusCode: 401);

  @override
  String getDescription(BuildContext context) =>
      S.of(context).errorMessageAuthRequired;

  @override
  bool get canRefresh => false;
}
