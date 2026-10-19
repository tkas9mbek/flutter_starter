import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';

/// An [AppCard] stacking rows with thin dividers between them.
class GroupedRowsCard extends StatelessWidget {
  const GroupedRowsCard({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i != 0) ...[const ThinHorizontalDivider()],
            children[i],
          ],
        ],
      ),
    );
  }
}
