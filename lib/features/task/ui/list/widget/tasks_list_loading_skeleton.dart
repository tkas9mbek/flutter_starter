import 'package:flutter/material.dart';
import 'package:starter/features/task/ui/list/widget/task_tile_skeleton.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Loading placeholder mirroring [TaskDateGroupCard]'s date-header +
/// rounded-surface-of-tiles layout.
class TasksListLoadingSkeleton extends StatelessWidget {
  const TasksListLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 12),
              child: Row(
                children: [
                  AppShimmerText(width: 100, height: 16),
                  SizedBox(width: 8),
                  AppShimmerText(width: 50, height: 14),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackText.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: AppShimmer(
                child: Column(
                  children: [
                    const TaskTileSkeleton(),
                    Divider(height: 1, color: theme.border),
                    const TaskTileSkeleton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
