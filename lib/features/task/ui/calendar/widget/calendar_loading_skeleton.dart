import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Loading placeholder mirroring [TasksTimelineList]'s
/// time-column + dot-and-rail + content-card layout.
class CalendarLoadingSkeleton extends StatelessWidget {
  const CalendarLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return AppShimmer(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 56,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerText(width: 36, style: textStyles.mediumBody13),
                    const SizedBox(height: 2),
                    AppShimmerText(width: 28, style: textStyles.regularBody12),
                  ],
                ),
              ),
              const Column(
                children: [
                  AppShimmerCircle(size: 12),
                  AppShimmerBox(width: 1, height: 60),
                ],
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: AppShimmerBox(height: 72, radius: AppRadii.md),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
