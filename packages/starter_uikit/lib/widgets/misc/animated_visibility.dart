import 'package:flutter/material.dart';

/// Expands its [child] into view and shrinks it away as [visible] changes,
/// animating both size and opacity. Keep it in the tree permanently and
/// toggle [visible] — e.g. for field validation errors.
class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility({
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.alignment = Alignment.topLeft,
    super.key,
  });

  final bool visible;
  final Widget child;
  final Duration duration;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedAlign(
        duration: duration,
        alignment: alignment,
        heightFactor: visible ? 1 : 0,
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          duration: duration,
          opacity: visible ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
