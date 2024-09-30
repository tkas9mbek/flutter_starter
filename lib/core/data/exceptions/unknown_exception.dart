import 'package:flutter/widgets.dart';
import 'package:flutter_starter/core/data/exceptions/app_exception.dart';
import 'package:flutter_starter/generated/l10n.dart';

class UnknownException extends AppException {
  final Object e;
  final StackTrace stackTrace;

  UnknownException(
    this.e,
    this.stackTrace,
  );

  @override
  String getDescription(BuildContext context) {
    return S.of(context).errorMessageUnexpectedError;
  }
}
