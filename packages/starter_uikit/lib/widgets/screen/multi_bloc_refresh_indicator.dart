import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starter_toolkit/utils/bloc/refreshable_bloc.dart';

/// Wraps [child] with a [RefreshIndicator] that coordinates multiple BLoCs.
///
/// On pull, sets `refreshing` to true on all [blocs], calls [onRefresh]
/// (dispatch the reload events there), then keeps the indicator visible until
/// every bloc's refreshing state is false again.
class MultiBlocRefreshIndicator extends StatefulWidget {
  const MultiBlocRefreshIndicator({
    required this.child,
    required this.blocs,
    required this.onRefresh,
    this.displacement = 60,
    this.edgeOffset = 0,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
    this.color,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final List<RefreshableBloc> blocs;
  final Future<void> Function() onRefresh;
  final double displacement;
  final double edgeOffset;
  final Color? color;
  final Color? backgroundColor;
  final ScrollNotificationPredicate notificationPredicate;
  final RefreshIndicatorTriggerMode triggerMode;

  @override
  State<MultiBlocRefreshIndicator> createState() =>
      _MultiBlocRefreshIndicatorState();
}

class _MultiBlocRefreshIndicatorState extends State<MultiBlocRefreshIndicator> {
  void checkBlocsRefreshing(Completer<void> completer) {
    if (widget.blocs.every((bloc) => !bloc.refreshing) &&
        !completer.isCompleted) {
      completer.complete();
    }
  }

  Future<void> handleRefresh() async {
    for (final bloc in widget.blocs) {
      bloc.refreshing = true;
    }

    await widget.onRefresh();

    final completer = Completer<void>();
    final subscriptions = <StreamSubscription<bool>>[];

    for (final bloc in widget.blocs) {
      subscriptions.add(
        bloc.refreshingStream.listen((_) => checkBlocsRefreshing(completer)),
      );
    }

    checkBlocsRefreshing(completer);

    await completer.future;

    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: handleRefresh,
      displacement: widget.displacement,
      edgeOffset: widget.edgeOffset,
      color: widget.color,
      backgroundColor: widget.backgroundColor,
      notificationPredicate: widget.notificationPredicate,
      triggerMode: widget.triggerMode,
      child: widget.child,
    );
  }
}
