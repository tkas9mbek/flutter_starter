import 'package:flutter/widgets.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

class NoInternetException extends AppException {
  @override
  String getTitle(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageNoConnection;

  @override
  String getDescription(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageCouldNotConnectServer;
}
