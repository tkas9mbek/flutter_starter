import 'package:flutter/widgets.dart';

/// [AnimatedSwitcher] with a stack-based layout builder for smooth transitions
/// between BLoC state views.
///
/// Children are keyed automatically by their runtime type, so state-based
/// children (each state returning a different widget type) animate without
/// manual keys. Pass an explicit [Key] on a child only to distinguish two
/// states that render the same widget type.
class StackAnimatedSwitcher extends StatelessWidget {
  const StackAnimatedSwitcher({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.alignment = Alignment.topCenter,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: alignment,
        children: [
          ...previousChildren,
          if (currentChild != null) ...[currentChild],
        ],
      ),
      child: KeyedSubtree(
        key: child.key ?? ValueKey(child.runtimeType),
        child: child,
      ),
    );
  }
}
