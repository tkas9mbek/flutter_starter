import 'package:flutter/material.dart';
import 'package:request_logger/data/http_bean.dart';
import 'package:request_logger/data/request_status.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
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
    final status = log.status;
    final statusColor = switch (status) {
      RequestStatus.success => theme.success,
      RequestStatus.error || RequestStatus.noInternet => theme.error,
      RequestStatus.sending => theme.textSecondary,
    };
    final url = log.request?.url;
    final path = url?.path.isNotEmpty ?? false ? url!.path : url?.host ?? '—';
    final duration = log.response?.duration ?? log.error?.duration;
    final statusCode = log.response?.statusCode ?? log.error?.statusCode;
    final subtitle = [
      if (url != null && url.host.isNotEmpty) ...[url.host],
      if (duration != null) ...['$duration ms'],
    ].join(' · ');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  log.request?.method ?? '?',
                  style: textStyles.mediumBody12.copyWith(color: statusColor),
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
            if (status == RequestStatus.sending) ...[
              const SizedBox(
                height: 16,
                width: 16,
                child: CustomCircularProgressIndicator(size: 14),
              ),
            ] else ...[
              Text(
                statusCode?.toString() ?? '—',
                style: textStyles.mediumBody13.copyWith(color: statusColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
