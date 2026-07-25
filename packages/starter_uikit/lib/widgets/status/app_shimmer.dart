import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// How an [AppShimmer] group renders.
enum AppShimmerMode {
  /// Animated shimmer sweep (default), paused in background and when the
  /// platform disables animations.
  animated,

  /// Shapes are drawn in the base color with no animation.
  static,

  /// No skeleton styling — the child is shown as-is.
  disabled,
}

/// One shimmer animation for a whole loading area.
///
/// Drives a single animation for a group of placeholders instead of one per
/// shape: wrap the section in one [AppShimmer] filled with static shapes
/// ([AppShimmerBox]/[AppShimmerCircle]/[AppShimmerText]). That keeps one
/// `AnimationController` + shader for the group rather than N animated
/// builders.
///
/// Keep real painted surfaces (card backgrounds, dividers, icons, text,
/// images) outside [AppShimmer] — anything painted inside the child is masked
/// by the shimmer shader and will appear as part of the skeleton.
class AppShimmer extends StatefulWidget {
  const AppShimmer({
    required this.child,
    this.mode = AppShimmerMode.animated,
    super.key,
  });

  final Widget child;
  final AppShimmerMode mode;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer> with WidgetsBindingObserver {
  bool _foreground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final foreground = state == AppLifecycleState.resumed;
    if (foreground != _foreground) {
      setState(() => _foreground = foreground);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mode == AppShimmerMode.disabled) {
      return widget.child;
    }

    final theme = ThemeProvider.of(context).theme;
    final animate =
        widget.mode == AppShimmerMode.animated &&
        _foreground &&
        !MediaQuery.disableAnimationsOf(context);

    return Shimmer.fromColors(
      enabled: animate,
      period: const Duration(milliseconds: 1500),
      baseColor: theme.surface,
      highlightColor: theme.surfaceMuted,
      child: widget.child,
    );
  }
}

/// Static rounded placeholder shape for use inside an [AppShimmer]. Has no
/// animation of its own — the surrounding [AppShimmer] drives the shimmer.
class AppShimmerBox extends StatelessWidget {
  const AppShimmerBox({this.radius = 8, this.width, this.height, super.key});

  final double radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// Static circular placeholder (avatar/icon) for use inside an [AppShimmer].
class AppShimmerCircle extends StatelessWidget {
  const AppShimmerCircle({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.surface,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Static single-line text placeholder for use inside an [AppShimmer].
///
/// Pass [style] to derive the placeholder height from the real text style it
/// stands in for, so the skeleton matches the loaded layout.
class AppShimmerText extends StatelessWidget {
  const AppShimmerText({
    this.height = 12,
    this.radius = 6,
    this.sampleText = 'Lorem ipsum dolor',
    this.width,
    this.style,
    super.key,
  });

  final double height;
  final double radius;
  final double? width;
  final TextStyle? style;
  final String sampleText;

  @override
  Widget build(BuildContext context) {
    return AppShimmerBox(
      width: width,
      height: resolveHeight(context),
      radius: radius,
    );
  }

  double resolveHeight(BuildContext context) {
    final style = this.style;
    if (style == null) {
      return height;
    }

    final maxWidth = width ?? MediaQuery.sizeOf(context).width;
    final textPainter = TextPainter(
      text: TextSpan(text: sampleText, style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout(maxWidth: maxWidth);

    return textPainter.height;
  }
}
