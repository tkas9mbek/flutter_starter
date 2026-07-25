import 'package:flutter/material.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

/// Scrollable list that renders paginated [data] and triggers [onLoadMore] as
/// the user reaches the end, showing a trailing loading or error indicator.
///
/// [status] is the load-more state: `initial`/`loaded` request the next page
/// once the trailing slot becomes visible, `loading` shows the indicator, and
/// `failure` shows [errorWidget].
class PaginatedListView<T> extends StatelessWidget {
  const PaginatedListView({
    required this.data,
    required this.status,
    required this.itemBuilder,
    required this.onLoadMore,
    this.shrinkWrap = false,
    this.loadingIndicator,
    this.errorWidget,
    this.controller,
    this.padding,
    this.physics,
    this.separator,
    super.key,
  });

  final PaginatedData<T> data;
  final BlocLoadState status;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final VoidCallback onLoadMore;
  final Widget? loadingIndicator;
  final Widget? errorWidget;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    final itemCount = data.length + (data.canLoadMore ? 1 : 0);

    if (separator != null) {
      return ListView.separated(
        controller: controller,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        separatorBuilder: (context, index) =>
            data.canLoadMore && index == data.length - 1
            ? const SizedBox.shrink()
            : separator!,
        itemBuilder: buildItem,
      );
    }

    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: buildItem,
    );
  }

  Widget buildItem(BuildContext context, int index) {
    if (index >= data.length) {
      return _LoadMoreIndicator(
        status: status,
        onLoadMore: onLoadMore,
        loadingIndicator: loadingIndicator,
        errorWidget: errorWidget,
      );
    }

    return itemBuilder(context, data.items[index], index);
  }
}

/// Sliver variant of [PaginatedListView] for use inside a [CustomScrollView].
class SliverPaginatedListView<T> extends StatelessWidget {
  const SliverPaginatedListView({
    required this.data,
    required this.status,
    required this.itemBuilder,
    required this.onLoadMore,
    this.loadingIndicator,
    this.errorWidget,
    super.key,
  });

  final PaginatedData<T> data;
  final BlocLoadState status;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final VoidCallback onLoadMore;
  final Widget? loadingIndicator;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final itemCount = data.length + (data.canLoadMore ? 1 : 0);

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index >= data.length) {
          return _LoadMoreIndicator(
            status: status,
            onLoadMore: onLoadMore,
            loadingIndicator: loadingIndicator,
            errorWidget: errorWidget,
          );
        }

        return itemBuilder(context, data.items[index], index);
      }, childCount: itemCount),
    );
  }
}

/// Trailing slot after the last item: requests the next page once when it
/// enters the tree (or its status settles) in a non-loading state, otherwise
/// renders the loading or error indicator.
class _LoadMoreIndicator extends StatefulWidget {
  const _LoadMoreIndicator({
    required this.status,
    required this.onLoadMore,
    this.loadingIndicator,
    this.errorWidget,
  });

  final BlocLoadState status;
  final VoidCallback onLoadMore;
  final Widget? loadingIndicator;
  final Widget? errorWidget;

  @override
  State<_LoadMoreIndicator> createState() => _LoadMoreIndicatorState();
}

class _LoadMoreIndicatorState extends State<_LoadMoreIndicator> {
  @override
  void initState() {
    super.initState();
    _maybeRequestNextPage();
  }

  @override
  void didUpdateWidget(_LoadMoreIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      _maybeRequestNextPage();
    }
  }

  void _maybeRequestNextPage() {
    if (widget.status == BlocLoadState.initial ||
        widget.status == BlocLoadState.loaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onLoadMore();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.status) {
      BlocLoadState.loading =>
        widget.loadingIndicator ?? const _DefaultLoadingIndicator(),
      BlocLoadState.failure => widget.errorWidget ?? const SizedBox.shrink(),
      BlocLoadState.initial || BlocLoadState.loaded => const SizedBox.shrink(),
    };
  }
}

class _DefaultLoadingIndicator extends StatelessWidget {
  const _DefaultLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: CustomCircularProgressIndicator.adaptive(),
    );
  }
}
