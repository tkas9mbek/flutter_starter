import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Centered, theme-aware circular progress indicator.
///
/// Already wraps itself in a [Center] — do not wrap it in another one.
/// Prefer [CustomCircularProgressIndicator.adaptive], which renders the
/// platform-native spinner (Cupertino on iOS/macOS, Material elsewhere).
class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({this.size = 24, this.color, super.key})
    : _adaptive = false;

  /// Platform-adaptive variant backed by [CircularProgressIndicator.adaptive].
  const CustomCircularProgressIndicator.adaptive({
    this.size = 24,
    this.color,
    super.key,
  }) : _adaptive = true;

  final Color? color;
  final double size;
  final bool _adaptive;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final indicatorColor = color ?? theme.primary;
    final platform = Theme.of(context).platform;
    final isCupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: _adaptive && isCupertino
            ? CupertinoActivityIndicator(
                color: indicatorColor,
                radius: size / 2,
              )
            : CircularProgressIndicator(
                color: indicatorColor,
                strokeWidth: size / 12,
              ),
      ),
    );
  }
}
