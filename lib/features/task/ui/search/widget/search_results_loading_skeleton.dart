import 'package:flutter/material.dart';
import 'package:starter/features/task/ui/list/widget/task_tile_skeleton.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

/// Loading placeholder mirroring [SearchResultsList]'s `Card`-wrapped,
/// separated tile layout.
class SearchResultsLoadingSkeleton extends StatelessWidget {
  const SearchResultsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => const Card(
        margin: EdgeInsets.zero,
        child: AppShimmer(child: TaskTileSkeleton()),
      ),
    );
  }
}
