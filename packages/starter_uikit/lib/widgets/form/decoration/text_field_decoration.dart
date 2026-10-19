import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/form/decoration/text_field_visual_state.dart';

/// Strategy for wrapping a text field's inner content in a decorated container.
mixin TextFieldDecoration {
  Widget build(BuildContext context, Widget child);

  /// What the uikit fields call; decorations that ignore interaction state
  /// only implement [build].
  Widget buildWithState(
    BuildContext context,
    Widget child,
    TextFieldVisualState state,
  ) => build(context, child);
}
