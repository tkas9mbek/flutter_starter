import 'package:flutter/material.dart';
import 'package:request_logger/screen/request_log_list_screen.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Compact flat pill, filled with [color] (a status token, `theme.warning` by
/// default), that opens the captured HTTP request log list.
///
/// Renders outside the app's routed content (it shares a [Stack] with it,
/// not a subtree), so it has no Navigator ancestor of its own — it pushes
/// through [navigatorKey] instead of `Navigator.of(context)`.
class RequestLoggerButton extends StatelessWidget {
  const RequestLoggerButton({
    required this.label,
    required this.navigatorKey,
    this.color,
    super.key,
  });

  final String label;
  final GlobalKey<NavigatorState> navigatorKey;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _openLogList,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? theme.warning,
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textStyles.mediumBody13.copyWith(color: theme.onStatus),
              ),
              const SizedBox(width: 4),
              Icon(Icons.bug_report_outlined, size: 14, color: theme.onStatus),
            ],
          ),
        ),
      ),
    );
  }

  void _openLogList() => navigatorKey.currentState?.push(
    MaterialPageRoute<void>(builder: (_) => const RequestLogListScreen()),
  );
}
