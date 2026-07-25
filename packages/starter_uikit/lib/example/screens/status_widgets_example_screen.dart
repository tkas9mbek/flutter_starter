import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class StatusWidgetsExampleScreen extends StatelessWidget {
  const StatusWidgetsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.statusWidgets),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              localizer.loadingState,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const SizedBox(
              height: 100,
              child: CustomCircularProgressIndicator.adaptive(),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.emptyState,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: Center(
                child: EmptyInformationBody(text: localizer.noDataAvailable),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.failureState,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            FailureWidget.large(
              exception: const ServerException(statusCode: 500),
              onRetry: () {},
            ),
            const SizedBox(height: 16),
            FailureWidget.small(
              exception: const NoInternetException(),
              onRetry: () {},
            ),
          ],
        ),
      ),
    );
  }
}
