import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_decoration.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_visual_state.dart';

/// Default [TextFieldDecoration]: a flat, always-bordered container whose
/// fill and outline follow the field's [TextFieldVisualState]. [color]
/// replaces the surface fill for every enabled state.
class FilledTextFieldDecoration with TextFieldDecoration {
  const FilledTextFieldDecoration({
    @Deprecated('Fields are always bordered in the flat design')
    this.hasBorder = true,
    this.color,
  });

  final Color? color;

  @Deprecated('Fields are always bordered in the flat design')
  final bool hasBorder;

  @override
  Widget build(BuildContext context, Widget child) {
    return buildWithState(context, child, TextFieldVisualState.idle);
  }

  @override
  Widget buildWithState(
    BuildContext context,
    Widget child,
    TextFieldVisualState state,
  ) => _FieldBox(state: state, color: color, child: child);
}

class _FieldBox extends StatelessWidget {
  const _FieldBox({required this.state, required this.child, this.color});

  final TextFieldVisualState state;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      constraints: const BoxConstraints(minHeight: 52),
      padding: const EdgeInsets.fromLTRB(16, 7, 16, 8),
      decoration: BoxDecoration(
        color: state.fillColor(theme, fill: color),
        borderRadius: BorderRadius.circular(AppRadii.control),
        border: Border.all(color: state.borderColor(theme)),
      ),
      child: child,
    );
  }
}
