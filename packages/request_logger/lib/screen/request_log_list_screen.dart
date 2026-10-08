import 'dart:async';

import 'package:flutter/material.dart';
import 'package:request_logger/data/http_bean.dart';
import 'package:request_logger/data/http_log_manager.dart';
import 'package:request_logger/screen/request_log_details_screen.dart';
import 'package:request_logger/widget/request_log_list_item.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';

/// Lists every captured HTTP request, newest first.
class RequestLogListScreen extends StatefulWidget {
  const RequestLogListScreen({super.key});

  @override
  State<RequestLogListScreen> createState() => _RequestLogListScreenState();
}

class _RequestLogListScreenState extends State<RequestLogListScreen> {
  var _logs = <HttpBean>[];

  @override
  void initState() {
    super.initState();
    _logs = _currentLogs();
    HttpLogManager.instance.updateHttpPage = _refresh;
  }

  @override
  void dispose() {
    HttpLogManager.instance.updateHttpPage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: TitleAppBar(
        title: 'Requests',
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: theme.textPrimary),
            onPressed: HttpLogManager.instance.cleanHTTP,
          ),
        ],
      ),
      body: _logs.isEmpty
          ? const EmptyInformationBody(text: 'No requests logged yet')
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _logs.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: theme.border),
              itemBuilder: (context, index) {
                final log = _logs[index];

                return RequestLogListItem(
                  log: log,
                  onTap: () => _openDetails(log),
                );
              },
            ),
    );
  }

  List<HttpBean> _currentLogs() =>
      HttpLogManager.instance.logValues().reversed.toList();

  void _refresh() {
    if (!mounted) {
      return;
    }

    setState(() {
      _logs = _currentLogs();
    });
  }

  void _openDetails(HttpBean log) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => RequestLogDetailsScreen(log: log),
        ),
      ),
    );
  }
}
