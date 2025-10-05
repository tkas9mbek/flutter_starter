import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

class UrlLaunchException extends AppException {
  @override
  String getDescription(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageUrlLaunchError;

  @override
  bool get canRefresh => false;
}
