import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Themed 22x22 checkbox square: outlined when unchecked, primary-filled
/// with a check when [selected], muted when not [enabled]; an optional
/// [label] expands to the right.
class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    required this.selected,
    required this.enabled,
    this.label,
    super.key,
  });

  final bool selected;
  final bool enabled;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final (fill, outline, tick) = switch ((enabled, selected)) {
      (true, true) => (theme.primary, theme.primary, theme.onPrimary),
      (true, false) => (AppColors.transparent, theme.borderStrong, null),
      (false, true) => (theme.surfaceMuted, theme.border, theme.textTertiary),
      (false, false) => (theme.surfaceMuted, theme.border, null),
    };

    return Row(
      mainAxisSize: label == null ? MainAxisSize.min : MainAxisSize.max,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 22,
          width: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fill,
            border: Border.all(color: outline, width: 1.5),
            borderRadius: BorderRadius.circular(AppRadii.xs),
          ),
          child: tick == null
              ? null
              : CustomPaint(
                  size: const Size.square(14),
                  painter: _TickPainter(tick),
                ),
        ),
        if (label != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label ?? '',
              style: textStyles.regularBody16.copyWith(
                color: enabled ? theme.textPrimary : theme.textTertiary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// The icon set's tick is a filled square with a cut-out, which cannot sit on
// a primary fill, so the check stroke is painted directly.
class _TickPainter extends CustomPainter {
  const _TickPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(size.width * 0.15, size.height * 0.52)
      ..lineTo(size.width * 0.4, size.height * 0.76)
      ..lineTo(size.width * 0.86, size.height * 0.26);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TickPainter oldDelegate) => oldDelegate.color != color;
}
