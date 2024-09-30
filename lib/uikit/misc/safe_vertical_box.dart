import 'dart:math';

import 'package:flutter/material.dart';

class SafeVerticalBox extends StatelessWidget {
  /// A box with a height of [height] that is safe for the top and bottom of the screen.
  ///
  /// * If [top] is true, the box will be at least as high as the status bar.
  /// * If [bottom] is true, the box will be at least as high as the navigation bar.
  /// * If both [top] and [bottom] are false, the box will be exactly [height] high.
  ///
  /// This widget is useful for creating a safe space at the top or bottom of the screen.
  const SafeVerticalBox({
    required this.height,
    this.top = false,
    this.bottom = true,
    super.key,
  });

  final double height;
  final bool top;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    if (top) {
      return SizedBox(
        height: max(height, MediaQuery.of(context).padding.top),
      );
    }

    if (bottom) {
      return SizedBox(
        height: max(height, MediaQuery.of(context).padding.bottom),
      );
    }

    return SizedBox(height: height);
  }
}
