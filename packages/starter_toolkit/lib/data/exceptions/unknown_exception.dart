import 'package:flutter/widgets.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

class UnknownException extends AppException {
  final Object e;
  final StackTrace stackTrace;

  UnknownException(
    this.e,
    this.stackTrace,
  );

  @override
  String getTitle(BuildContext context) {
    return ToolkitLocalizer.of(context).errorMessageUnexpectedError;
  }
}
