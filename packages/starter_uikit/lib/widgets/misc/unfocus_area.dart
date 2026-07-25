import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Dismisses the keyboard when the user taps outside any editable text
/// field, but leaves focus alone when the tap lands on another field so
/// focus transfers without the keyboard closing and reopening.
class UnfocusArea extends StatelessWidget {
  const UnfocusArea({required this.child, super.key});

  final Widget child;

  bool _hitsEditable(PointerDownEvent event, BuildContext context) {
    final result = HitTestResult();
    WidgetsBinding.instance.hitTestInView(result, event.position, event.viewId);

    return result.path.any((entry) => entry.target is RenderEditable);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        final primaryFocus = FocusManager.instance.primaryFocus;

        if (primaryFocus == null || primaryFocus is FocusScopeNode) {
          return;
        }

        if (_hitsEditable(event, context)) {
          return;
        }

        primaryFocus.unfocus();
      },
      child: child,
    );
  }
}
