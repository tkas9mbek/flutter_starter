import 'package:flutter/material.dart';

/// Base exception class for application-specific errors.
///
/// Provides methods for displaying error messages to users.
abstract class AppException implements Exception {
  String? getTitle(BuildContext context) => null;

  String getDescription(BuildContext context) => toString();

  String getSnackbarDescription(BuildContext context) =>
      getDescription(context);

  bool get canRefresh => true;
}
