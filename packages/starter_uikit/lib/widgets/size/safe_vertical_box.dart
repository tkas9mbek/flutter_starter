import 'dart:math';

import 'package:flutter/material.dart';

/// Vertical spacer of [height] that grows to at least the status-bar inset
/// when [top] is true, or the bottom system inset when [bottom] is true.
class SafeVerticalBox extends StatelessWidget {
  const SafeVerticalBox({
    this.top = false,
    this.bottom = false,
    this.height,
    super.key,
  });

  final double? height;
  final bool top;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    if (top) {
      return SizedBox(
        height: max(height ?? 0, MediaQuery.of(context).padding.top),
      );
    }

    if (bottom) {
      return SizedBox(
        height: max(height ?? 0, MediaQuery.of(context).padding.bottom),
      );
    }

    return SizedBox(height: height);
  }
}
