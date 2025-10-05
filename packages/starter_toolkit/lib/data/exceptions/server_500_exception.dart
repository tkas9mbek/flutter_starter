import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/server_exception.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

class Server500Exception extends ServerException {
  const Server500Exception({String? message})
      : super(
          message: message,
          statusCode: 500,
        );

  @override
  String getTitle(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageServerError;

  @override
  String getDescription(BuildContext context) =>
      message ?? ToolkitLocalizer.of(context).errorMessageServerInternalError;

  @override
  bool get canRefresh => true;
}
