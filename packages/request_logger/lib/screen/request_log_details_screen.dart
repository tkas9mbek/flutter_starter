import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:request_logger/data/http_bean.dart';
import 'package:request_logger/data/http_error_bean.dart';
import 'package:request_logger/data/http_request_bean.dart';
import 'package:request_logger/data/http_response_bean.dart';
import 'package:request_logger/widget/request_log_json_view.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

const _emptyPlaceholder = '—';

/// Details of a single captured HTTP call: a summary header plus `Request`
/// and `Response`/`Error` tabs, each copyable to the clipboard.
class RequestLogDetailsScreen extends StatelessWidget {
  const RequestLogDetailsScreen({required this.log, super.key});

  final HttpBean log;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final hasError = log.error != null;

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: theme.background,
          appBar: TitleAppBar(
            title: log.request?.method ?? 'Request',
            actions: [
              IconButton(
                icon: Icon(Icons.copy_rounded, color: theme.textPrimary),
                onPressed: () => _copyActiveTab(context),
              ),
            ],
            bottom: TabBar(
              labelColor: theme.accent,
              unselectedLabelColor: theme.textSecondary,
              indicatorColor: theme.accent,
              labelStyle: textStyles.mediumBody14,
              unselectedLabelStyle: textStyles.mediumBody14,
              tabs: [
                const Tab(text: 'Request'),
                Tab(text: hasError ? 'Error' : 'Response'),
              ],
            ),
          ),
          body: Column(
            children: [
              _SummaryHeader(log: log),
              const ThinHorizontalDivider(),
              Expanded(
                child: TabBarView(
                  children: [
                    _RequestTab(request: log.request),
                    if (log.error case final error?) ...[
                      _ErrorTab(error: error),
                    ] else ...[
                      _ResponseTab(response: log.response),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _requestText => RequestLogJsonView.prettyPrint({
    'headers': log.request?.headers,
    'params': log.request?.params,
    'body': log.request?.body,
  });

  String get _responseText => switch (log.error) {
    final error? => RequestLogJsonView.prettyPrint({
      'message': error.errorMessage,
      'type': error.errorType,
      'statusCode': error.statusCode,
      'data': error.errorData,
    }),
    null => RequestLogJsonView.prettyPrint({
      'headers': log.response?.headers,
      'data': log.response?.data,
    }),
  };

  void _copyActiveTab(BuildContext context) {
    final text = DefaultTabController.of(context).index == 0
        ? _requestText
        : _responseText;

    unawaited(Clipboard.setData(ClipboardData(text: text)));
    NotificationSnackBar.show(
      context,
      NotificationSnackBar.success(text: 'Copied to clipboard'),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.log});

  final HttpBean log;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final error = log.error;
    final statusCode = log.response?.statusCode ?? error?.statusCode;
    final statusMessage = log.response?.statusMessage ?? error?.statusMessage;
    final duration = log.response?.duration ?? error?.duration;
    final requestTime = log.request?.requestTime;
    final isFailed = error != null || (statusCode ?? 0) >= 400;
    final status = [
      if (statusCode != null) ...[
        '$statusCode',
      ] else if (error?.errorType case final type?) ...[
        type,
      ],
      if (statusMessage != null && statusMessage.isNotEmpty) ...[statusMessage],
    ].join(' ');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            log.request?.url.toString() ?? _emptyPlaceholder,
            style: textStyles.regularBody13,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 4,
            children: [
              _SummaryField(
                label: 'Status',
                value: status.isEmpty ? _emptyPlaceholder : status,
                valueColor: isFailed ? theme.errorText : theme.successText,
              ),
              if (duration != null) ...[
                _SummaryField(label: 'Duration', value: '$duration ms'),
              ],
              if (requestTime != null) ...[
                _SummaryField(
                  label: 'Time',
                  value: DateFormat('HH:mm:ss.SSS').format(requestTime),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryField extends StatelessWidget {
  const _SummaryField({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: textStyles.regularBody12.copyWith(color: theme.textSecondary),
        children: [
          TextSpan(
            text: value,
            style: textStyles.mediumBody12.copyWith(
              color: valueColor ?? theme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestTab extends StatelessWidget {
  const _RequestTab({required this.request});

  final HttpRequestBean? request;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(label: 'Headers', data: request?.headers),
          _Section(label: 'Params', data: request?.params),
          _Section(label: 'Body', data: request?.body),
        ],
      ),
    );
  }
}

class _ResponseTab extends StatelessWidget {
  const _ResponseTab({required this.response});

  final HttpResponseBean? response;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(label: 'Headers', data: response?.headers),
          _Section(label: 'Data', data: response?.data),
        ],
      ),
    );
  }
}

class _ErrorTab extends StatelessWidget {
  const _ErrorTab({required this.error});

  final HttpErrorBean error;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            error.errorMessage ?? _emptyPlaceholder,
            style: textStyles.mediumBody14.copyWith(color: theme.errorText),
          ),
          const SizedBox(height: 16),
          _Section(label: 'Type', data: error.errorType),
          _Section(label: 'Data', data: error.errorData),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.data});

  final String label;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textStyles.mediumBody13.copyWith(color: theme.textSecondary),
          ),
          const SizedBox(height: 4),
          RequestLogJsonView(data: data),
        ],
      ),
    );
  }
}
