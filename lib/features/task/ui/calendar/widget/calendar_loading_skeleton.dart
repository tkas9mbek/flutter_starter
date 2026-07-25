import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Loading placeholder mirroring [TasksTimelineList]'s
/// time-column + dot-and-line + content-card layout.
class CalendarLoadingSkeleton extends StatelessWidget {
  const CalendarLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerText(width: 36, height: 12),
                    SizedBox(height: 6),
                    AppShimmerText(width: 28, height: 10),
                  ],
                ),
              ),
              Column(
                children: [
                  AppShimmerCircle(size: 12),
                  SizedBox(height: 4),
                  AppShimmerBox(width: 2, height: 56),
                ],
              ),
              SizedBox(width: 16),
              Expanded(child: AppShimmerBox(height: 64, radius: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
