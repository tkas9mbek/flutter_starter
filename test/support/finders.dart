import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

/// Finds [SvgIcon] widgets rendering the given `UiSvgIcons` asset [icon].
Finder findSvgIcon(String icon) => find.byWidgetPredicate(
  (widget) => widget is SvgIcon && widget.icon == icon,
);
