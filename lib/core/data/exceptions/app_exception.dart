import 'package:flutter/material.dart';

abstract class AppException implements Exception {
  String getDescription(BuildContext context) => toString();

  String getSnackbarDescription(BuildContext context) =>
      getDescription(context);

  bool get canRefresh => true;
}
