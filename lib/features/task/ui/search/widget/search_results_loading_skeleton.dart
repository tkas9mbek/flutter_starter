import 'package:flutter/material.dart';
import 'package:starter/features/task/ui/list/widget/task_tile_skeleton.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Loading placeholder mirroring [SearchResultsList]'s separated,
/// card-wrapped task rows.
class SearchResultsLoadingSkeleton extends StatelessWidget {
  const SearchResultsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: 6,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) =>
          const AppCard(child: AppShimmer(child: TaskTileSkeleton())),
    );
  }
}
