import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';

/// Makes any [child] tappable the accessible way: an [InkWell], so the child
/// can be focused with a keyboard, wrapped in semantics that tell screen
/// readers it is a button, with [semanticLabel] when the child has no text
/// (an icon).
///
/// Use it instead of a bare `GestureDetector`, which a screen reader and a
/// keyboard cannot reach. There is no splash or hover tint (flat design); only
/// a keyboard focus is drawn.
class AppTapArea extends StatelessWidget {
  const AppTapArea({
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.selected,
    super.key,
  });

  final Widget child;

  /// Without it the area is inert and is not announced as a button.
  final VoidCallback? onTap;

  /// What a screen reader says. Set it for an icon with no text.
  final String? semanticLabel;

  /// Whether this area is the chosen one of a group, like a tab.
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      label: semanticLabel,
      selected: selected,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.focused)
                ? null
                : AppColors.transparent,
          ),
          child: child,
        ),
      ),
    );
  }
}
