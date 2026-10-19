import 'package:flutter/material.dart';
import 'package:starter/features/task/ui/list/widget/task_tile_skeleton.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Loading placeholder mirroring [TaskDateGroupCard]'s date header over a
/// grouped card of task rows.
class TasksListLoadingSkeleton extends StatelessWidget {
  const TasksListLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: AppShimmer(
                child: AppShimmerText(
                  width: 120,
                  style: textStyles.mediumBody13,
                ),
              ),
            ),
            // Shimmer per row so the card border and dividers stay unmasked.
            const GroupedRowsCard(
              children: [
                AppShimmer(child: TaskTileSkeleton()),
                AppShimmer(child: TaskTileSkeleton()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
