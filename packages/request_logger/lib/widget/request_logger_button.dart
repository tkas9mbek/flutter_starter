import 'package:flutter/material.dart';
import 'package:request_logger/screen/request_log_list_screen.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Compact pill that opens the captured HTTP request log list.
///
/// Renders outside the app's routed content (it shares a [Stack] with it,
/// not a subtree), so it has no Navigator ancestor of its own — it pushes
/// through [navigatorKey] instead of `Navigator.of(context)`.
class RequestLoggerButton extends StatelessWidget {
  const RequestLoggerButton({
    required this.label,
    required this.navigatorKey,
    super.key,
  });

  final String label;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    const borderRadius = BorderRadius.all(Radius.circular(12));

    return Material(
      color: theme.surface,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: _openLogList,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: theme.error),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textStyles.regularBody13.copyWith(color: theme.error),
              ),
              const SizedBox(width: 4),
              Icon(Icons.bug_report_outlined, size: 14, color: theme.error),
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
