import 'package:flutter/widgets.dart';

extension TextScaleContext on BuildContext {
  /// True when the user's text size is large enough that a title and its
  /// value no longer fit side by side, so the row should stack them.
  bool get hasLargeText => MediaQuery.textScalerOf(this).scale(16) >= 24;
}
