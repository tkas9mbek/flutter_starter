import 'package:flutter/material.dart';
import 'package:uikit/generated/l10n.dart';

abstract class AppException implements Exception {
  const AppException();

  String getTitle(BuildContext context) =>
      S.of(context).errorMessageUnexpectedError;

  String getDescription(BuildContext context) =>
      S.of(context).errorMessageCheckAndTryLater;

  String getSnackbarDescription(BuildContext context) =>
      getDescription(context);

  bool get canRefresh => true;
}
