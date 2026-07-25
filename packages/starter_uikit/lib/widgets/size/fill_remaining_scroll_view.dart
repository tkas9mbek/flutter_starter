import 'package:flutter/material.dart';

/// Wraps content in a scrollable view that fills the remaining space, so
/// pull-to-refresh works on error/empty states that don't scroll on their own.
class FillRemainingScrollView extends StatelessWidget {
  const FillRemainingScrollView({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: child,
        ),
      ],
    );
  }
}
