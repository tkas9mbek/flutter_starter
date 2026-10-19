import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/example/widgets/example_section.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';
import 'package:starter_uikit/widgets/status/app_status_screen.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

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
            ExampleSection(
              title: localizer.loadingState,
              children: const [
                SizedBox(
                  height: 48,
                  child: CustomCircularProgressIndicator.adaptive(),
                ),
                _ShimmerDemo(),
              ],
            ),
            ExampleSection(
              title: localizer.emptyState,
              children: [
                AppCard(
                  child: EmptyInformationBody(
                    text: localizer.noDataAvailable,
                    onRetry: () {},
                  ),
                ),
              ],
            ),
            ExampleSection(
              title: localizer.failureState,
              children: [
                AppCard(
                  child: SizedBox(
                    height: 260,
                    child: FailureWidget.large(
                      exception: const NoInternetException(),
                      onRetry: () {},
                    ),
                  ),
                ),
                AppCard(
                  child: FailureWidget.small(
                    exception: const NoInternetException(),
                    onRetry: () {},
                  ),
                ),
              ],
            ),
            const _SnackBarDemo(),
            const _StatusScreenDemo(),
          ],
        ),
      ),
    );
  }
}

class _ShimmerDemo extends StatelessWidget {
  const _ShimmerDemo();

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: AppShimmer(
        child: Row(
          children: [
            const AppShimmerCircle(size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerText(width: 160, style: textStyles.mediumBody16),
                  const SizedBox(height: 8),
                  AppShimmerText(width: 96, style: textStyles.regularBody13),
                ],
              ),
            ),
            const AppShimmerBox(width: 56, height: 24),
          ],
        ),
      ),
    );
  }
}

class _SnackBarDemo extends StatelessWidget {
  const _SnackBarDemo();

  @override
  Widget build(BuildContext context) {
    return ExampleSection(
      title: 'Notification snack bar',
      children: [
        AppOutlinedButton.medium(
          context: context,
          text: 'Success',
          onPressed: () => NotificationSnackBar.show(
            context,
            NotificationSnackBar.success(text: 'Changes saved'),
          ),
        ),
        AppOutlinedButton.medium(
          context: context,
          text: 'Error',
          onPressed: () => NotificationSnackBar.showExceptionMessage(
            context,
            exception: const NoInternetException(),
          ),
        ),
        AppOutlinedButton.medium(
          context: context,
          text: 'Information',
          onPressed: () => NotificationSnackBar.show(
            context,
            NotificationSnackBar.information(text: 'A new version is ready'),
          ),
        ),
      ],
    );
  }
}

class _StatusScreenDemo extends StatelessWidget {
  const _StatusScreenDemo();

  void pushSuccess(BuildContext context, Color iconColor) => unawaited(
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (routeContext) => Scaffold(
          appBar: const TitleAppBar(title: 'Success'),
          body: AppStatusScreen(
            icon: SvgIcon(UiSvgIcons.checkMark, size: 48, color: iconColor),
            title: 'All done',
            subtitle: 'Your changes were saved successfully.',
            primaryButtonLabel: 'Continue',
            onPrimaryPressed: () => Navigator.of(routeContext).pop(),
          ),
        ),
      ),
    ),
  );

  void pushError(BuildContext context, Color iconColor) => unawaited(
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (routeContext) => Scaffold(
          appBar: const TitleAppBar(title: 'Error'),
          body: AppStatusScreen(
            icon: SvgIcon(UiSvgIcons.closeMark, size: 48, color: iconColor),
            title: 'Something went wrong',
            subtitle: "We couldn't complete this action. Please try again.",
            primaryButtonLabel: 'Retry',
            onPrimaryPressed: () => Navigator.of(routeContext).pop(),
            secondaryButtonLabel: 'Cancel',
            onSecondaryPressed: () => Navigator.of(routeContext).pop(),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return ExampleSection(
      title: 'Full-screen status (AppStatusScreen)',
      children: [
        AppOutlinedButton.medium(
          context: context,
          text: 'Show success variant',
          onPressed: () => pushSuccess(context, theme.successText),
        ),
        AppOutlinedButton.medium(
          context: context,
          text: 'Show error variant',
          onPressed: () => pushError(context, theme.errorText),
        ),
      ],
    );
  }
}
