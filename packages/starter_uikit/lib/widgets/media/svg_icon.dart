import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_uikit/configs/ui_consts.dart';

/// Renders a `UiSvgIcons` asset at [size], tinted with [color].
///
/// The only sanctioned way to draw icons — material `Icon`/`Icons` are
/// forbidden in app UI; every glyph comes from the Figma-exported SVG set.
class SvgIcon extends StatelessWidget {
  const SvgIcon(this.icon, {this.size = 24, this.color, super.key});

  /// Asset path from `UiSvgIcons`.
  final String icon;

  final double size;

  /// Tint applied via `srcIn`; null keeps the SVG's own colors.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      package: UiConsts.package,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
