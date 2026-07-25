import 'dart:async';

import 'package:flutter/material.dart';

/// Fires [onActivated] once its [child] is tapped [tapCount] times in quick succession.
class TapActivator extends StatefulWidget {
  const TapActivator({
    required this.child,
    required this.onActivated,
    this.tapCount = 7,
    super.key,
  });

  final Widget child;
  final VoidCallback onActivated;
  final int tapCount;

  @override
  State<TapActivator> createState() => _TapActivatorState();
}

class _TapActivatorState extends State<TapActivator> {
  int tapCount = 0;
  Timer? timer;

  void onTap() {
    setState(() => tapCount++);
    if (tapCount >= widget.tapCount) {
      widget.onActivated();
      setState(() => tapCount = 0);
    }

    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      setState(() => tapCount = 0);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: widget.child,
    );
  }
}
