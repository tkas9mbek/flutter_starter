import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

/// Service for capturing and saving screenshots of Flutter widgets.
///
/// Provides functionality to capture screenshots of widgets marked with GlobalKey
/// and save them to the device's gallery with optimized quality settings.
///
/// Requires appropriate permissions in AndroidManifest.xml (WRITE_EXTERNAL_STORAGE)
/// and Info.plist (NSPhotoLibraryAddUsageDescription).
class AppScreenshotHelper {
  /// Captures a screenshot of a widget identified by [key].
  ///
  /// Uses device-specific [pixelRatio] for optimal quality when provided
  /// or automatically determines it from [context] or platform info.
  ///
  /// Returns PNG-encoded image as Uint8List or null if capture fails.
  Future<Uint8List?> captureScreenshot(
    GlobalKey key, {
    double? pixelRatio,
    BuildContext? context,
  }) async {
    final actualPixelRatio = pixelRatio ??
        (context != null
            ? MediaQuery.of(context).devicePixelRatio
            : ui.PlatformDispatcher.instance.views.first.devicePixelRatio);

    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      return null;
    }

    final image = await boundary.toImage(pixelRatio: actualPixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return byteData?.buffer.asUint8List();
  }

  /// Saves image bytes to device gallery.
  ///
  /// Generates a timestamped filename with optional [prefix].
  /// Returns success status of save operation.
  Future<bool> saveImageToGallery(
    Uint8List imageBytes, {
    String? prefix,
  }) async {
    final fileName =
        '${prefix ?? 'screenshot'}_${DateTime.now().millisecondsSinceEpoch}.png';

    final result = await ImageGallerySaver.saveImage(
      imageBytes,
      quality: 95,
      name: fileName,
    );

    return result != null && (result is Map && result['isSuccess'] == true);
  }

  /// Captures and saves a screenshot in a single operation.
  ///
  /// Combines screenshot capture and gallery saving with error handling.
  /// Returns success status and error message if applicable.
  Future<({bool success, String? errorMessage})> captureAndSaveScreenshot(
    GlobalKey key, {
    String? filePrefix,
    double? pixelRatio,
    BuildContext? context,
  }) async {
    try {
      final imageBytes = await captureScreenshot(
        key,
        pixelRatio: pixelRatio,
        context: context,
      );
      if (imageBytes == null) {
        return (success: false, errorMessage: 'Failed to capture screenshot');
      }

      final saved = await saveImageToGallery(imageBytes, prefix: filePrefix);
      return (
        success: saved,
        errorMessage: saved ? null : 'Failed to save image'
      );
    } catch (e) {
      return (
        success: false,
        errorMessage: 'Error: ${e.toString().split('\n').first}'
      );
    }
  }
}
