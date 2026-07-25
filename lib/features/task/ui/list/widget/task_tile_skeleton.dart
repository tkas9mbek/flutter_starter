import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Text-line placeholder mirroring [TaskListItemTile]'s title, description,
/// and time-range rows.
class TaskTileSkeleton extends StatelessWidget {
  const TaskTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmerText(width: 160, height: 14),
          SizedBox(height: 8),
          AppShimmerText(width: 220, height: 12),
          SizedBox(height: 4),
          AppShimmerText(width: 140, height: 12),
          SizedBox(height: 8),
          AppShimmerText(width: 70, height: 12),
        ],
      ),
    );
  }
}
