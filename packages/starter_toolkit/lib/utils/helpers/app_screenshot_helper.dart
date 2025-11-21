import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Service for capturing screenshots of Flutter widgets.
///
/// Provides functionality to capture screenshots of widgets marked with GlobalKey
/// with optimized quality settings.
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
}
