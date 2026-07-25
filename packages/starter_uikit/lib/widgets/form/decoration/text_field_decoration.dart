import 'package:flutter/material.dart';

/// Strategy for wrapping a text field's inner content in a decorated container.
mixin TextFieldDecoration {
  Widget build(BuildContext context, Widget child);
}
