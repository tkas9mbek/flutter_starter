import 'package:flutter/material.dart';

abstract class AppException implements Exception {
  String? getTitle(BuildContext context) => null;

  String getDescription(BuildContext context) => toString();

  String getSnackbarDescription(BuildContext context) =>
      getDescription(context);

  bool get canRefresh => true;
}
