import 'package:flutter/material.dart';
import 'package:request_logger/data/http_bean.dart';
import 'package:request_logger/data/request_status.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/status_pill.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

/// Single row of the request log list: method, path, status and duration.
class RequestLogListItem extends StatelessWidget {
  const RequestLogListItem({required this.log, required this.onTap, super.key});

  final HttpBean log;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final url = log.request?.url;
    final path = url?.path.isNotEmpty ?? false ? url!.path : url?.host ?? '—';
    final duration = log.response?.duration ?? log.error?.duration;
    final statusCode = log.response?.statusCode ?? log.error?.statusCode;
    final subtitle = [
      if (url != null && url.host.isNotEmpty) ...[url.host],
      if (duration != null) ...['$duration ms'],
    ].join(' · ');

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.xs),
                border: Border.all(color: theme.border),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  log.request?.method ?? '?',
                  style: textStyles.mediumBody12.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    path,
                    style: textStyles.mediumBody14,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: textStyles.regularBody12.copyWith(
                        color: theme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (log.status == RequestStatus.sending) ...[
              CustomCircularProgressIndicator(size: 16, color: theme.accent),
            ] else ...[
              StatusPill(
                label: statusCode?.toString() ?? log.error?.errorType ?? '—',
                color: _statusColor(theme, statusCode),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // No status code means the call never got a response, so it failed.
  Color _statusColor(AppTheme theme, int? statusCode) => switch (statusCode) {
    null => theme.error,
    >= 500 => theme.error,
    >= 400 => theme.warning,
    >= 200 && < 300 => theme.success,
    _ => theme.info,
  };
}
