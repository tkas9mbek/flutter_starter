import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Builds a custom rationale dialog and resolves to the user's consent.
typedef PermissionDialogBuilder = Future<bool> Function(BuildContext context);

/// Coordinates platform permission requests with a custom rationale dialog.
///
/// On Android, the rationale dialog is shown before the OS prompt. On iOS,
/// the OS prompt is invoked directly because Apple guidelines forbid
/// pre-prompting.
class PermissionDialogHelper {
  /// Shows the camera-permission rationale [dialogBuilder].
  static Future<bool> showCameraPermissionDialog({
    required BuildContext context,
    required PermissionDialogBuilder dialogBuilder,
  }) {
    if (!context.mounted) {
      return Future.value(false);
    }

    return dialogBuilder(context);
  }

  /// Shows the location-permission rationale [dialogBuilder].
  static Future<bool> showLocationPermissionDialog({
    required BuildContext context,
    required PermissionDialogBuilder dialogBuilder,
  }) {
    if (!context.mounted) {
      return Future.value(false);
    }

    return dialogBuilder(context);
  }

  /// Shows the photos-permission rationale [dialogBuilder].
  static Future<bool> showPhotosPermissionDialog({
    required BuildContext context,
    required PermissionDialogBuilder dialogBuilder,
  }) {
    if (!context.mounted) {
      return Future.value(false);
    }

    return dialogBuilder(context);
  }

  /// Requests camera permission, showing the [dialogBuilder] rationale on
  /// Android first. Returns whether the OS ultimately granted access.
  static Future<bool> requestCameraPermissionWithDialog({
    required BuildContext context,
    required PermissionDialogBuilder dialogBuilder,
  }) async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return false;
    }

    // On iOS, skip custom dialog and request permission directly
    if (Platform.isIOS) {
      final result = await Permission.camera.request();

      return result.isGranted;
    }

    // Android: show custom dialog first
    if (!context.mounted) {
      return false;
    }
    final userConsent = await showCameraPermissionDialog(
      context: context,
      dialogBuilder: dialogBuilder,
    );
    if (!userConsent) {
      return false;
    }

    final result = await Permission.camera.request();

    return result.isGranted;
  }

  /// Requests photos permission, showing the [dialogBuilder] rationale on
  /// Android first. iOS treats `limited` access as granted.
  static Future<bool> requestPhotosPermissionWithDialog({
    required BuildContext context,
    required PermissionDialogBuilder dialogBuilder,
  }) async {
    const permission = Permission.photos;

    final status = await permission.status;

    // On iOS, both granted and limited access should be treated as permission granted
    if (status.isGranted || (Platform.isIOS && status.isLimited)) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return false;
    }

    // On iOS, skip custom dialog and request permission directly
    if (Platform.isIOS) {
      final result = await permission.request();

      // On iOS, both granted and limited access should be treated as permission granted
      return result.isGranted || result.isLimited;
    }

    // Android: show custom dialog first
    if (!context.mounted) {
      return false;
    }
    final userConsent = await showPhotosPermissionDialog(
      context: context,
      dialogBuilder: dialogBuilder,
    );
    if (!userConsent) {
      return false;
    }

    final result = await permission.request();

    return result.isGranted;
  }

  /// Requests location permission, showing the [dialogBuilder] rationale
  /// on Android first. Returns whether the OS ultimately granted access.
  static Future<bool> requestLocationPermissionWithDialog({
    required BuildContext context,
    required PermissionDialogBuilder dialogBuilder,
  }) async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return false;
    }

    // On iOS, skip custom dialog and request permission directly
    if (Platform.isIOS) {
      final result = await Permission.location.request();

      return result.isGranted;
    }

    // Android: show custom dialog first
    if (!context.mounted) {
      return false;
    }
    final userConsent = await showLocationPermissionDialog(
      context: context,
      dialogBuilder: dialogBuilder,
    );
    if (!userConsent) {
      return false;
    }

    final result = await Permission.location.request();

    return result.isGranted;
  }
}
