import 'package:flutter/widgets.dart';
import 'package:flutter_starter/core/data/exceptions/app_exception.dart';
import 'package:flutter_starter/generated/l10n.dart';

class NoInternetException extends AppException {
  @override
  String getDescription(BuildContext context) =>
      S.of(context).errorMessageNoInternetConnection;
}
