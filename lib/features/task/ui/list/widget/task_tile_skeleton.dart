import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Shape-only placeholder mirroring [TaskListItemTile]'s title, time-range
/// subtitle and trailing status pill; wrap it in an [AppShimmer].
class TaskTileSkeleton extends StatelessWidget {
  const TaskTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerText(width: 160, style: textStyles.mediumBody16),
                  const SizedBox(height: 2),
                  AppShimmerText(width: 96, style: textStyles.regularBody13),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const AppShimmerBox(width: 88, height: 20, radius: AppRadii.sm),
          ],
        ),
      ),
    );
  }
}
