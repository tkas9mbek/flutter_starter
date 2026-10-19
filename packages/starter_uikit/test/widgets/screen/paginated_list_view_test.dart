import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';
import 'package:starter_uikit/widgets/screen/paginated_list_view.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

import '../../support/pump_app.dart';

void main() {
  PaginatedData<int> pageOf({required int page, required int pagesCount}) =>
      PaginatedData(
        page: page,
        pagesCount: pagesCount,
        items: const [1, 2, 3],
        itemsCount: 6,
        perPage: 3,
      );

  Widget buildList({
    required PaginatedData<int> data,
    required BlocLoadState status,
    required VoidCallback onLoadMore,
    Widget? errorWidget,
  }) => PaginatedListView<int>(
    data: data,
    status: status,
    onLoadMore: onLoadMore,
    errorWidget: errorWidget,
    itemBuilder: (context, item, index) =>
        SizedBox(height: 40, child: Text('item $item')),
  );

  group('PaginatedListView', () {
    testWidgets('requests the next page once the trailing slot is reached', (
      tester,
    ) async {
      var loadMoreCalls = 0;

      await tester.pumpApp(
        buildList(
          data: pageOf(page: 1, pagesCount: 2),
          status: BlocLoadState.loaded,
          onLoadMore: () => loadMoreCalls++,
        ),
      );

      expect(find.text('item 1'), findsOneWidget);
      expect(loadMoreCalls, 1);
    });

    testWidgets('shows the loader and does not re-request while loading', (
      tester,
    ) async {
      var loadMoreCalls = 0;

      await tester.pumpApp(
        buildList(
          data: pageOf(page: 1, pagesCount: 2),
          status: BlocLoadState.loading,
          onLoadMore: () => loadMoreCalls++,
        ),
        settle: false,
      );

      expect(find.byType(CustomCircularProgressIndicator), findsOneWidget);
      expect(loadMoreCalls, 0);
    });

    testWidgets('shows errorWidget on failure without requesting more', (
      tester,
    ) async {
      var loadMoreCalls = 0;

      await tester.pumpApp(
        buildList(
          data: pageOf(page: 1, pagesCount: 2),
          status: BlocLoadState.failure,
          onLoadMore: () => loadMoreCalls++,
          errorWidget: const Text('load failed'),
        ),
      );

      expect(find.text('load failed'), findsOneWidget);
      expect(loadMoreCalls, 0);
    });

    testWidgets('requests again once a failed load is retried', (tester) async {
      var loadMoreCalls = 0;
      Widget build(BlocLoadState status) => buildList(
        data: pageOf(page: 1, pagesCount: 2),
        status: status,
        onLoadMore: () => loadMoreCalls++,
        errorWidget: TextButton(
          onPressed: () => loadMoreCalls++,
          child: const Text('retry'),
        ),
      );

      await tester.pumpApp(build(BlocLoadState.failure));
      await tester.tap(find.text('retry'));

      expect(loadMoreCalls, 1);

      await tester.pumpApp(build(BlocLoadState.loading), settle: false);
      await tester.pumpApp(build(BlocLoadState.loaded));

      expect(find.text('retry'), findsNothing);
      expect(loadMoreCalls, 2);
    });

    testWidgets('shows a custom loadingIndicator instead of the default', (
      tester,
    ) async {
      await tester.pumpApp(
        PaginatedListView<int>(
          data: pageOf(page: 1, pagesCount: 2),
          status: BlocLoadState.loading,
          onLoadMore: () {},
          loadingIndicator: const Text('more…'),
          itemBuilder: (context, item, index) => Text('item $item'),
        ),
      );

      expect(find.text('more…'), findsOneWidget);
      expect(find.byType(CustomCircularProgressIndicator), findsNothing);
    });

    testWidgets('puts separators only between items, not before the footer', (
      tester,
    ) async {
      await tester.pumpApp(
        PaginatedListView<int>(
          data: pageOf(page: 1, pagesCount: 2),
          status: BlocLoadState.failure,
          onLoadMore: () {},
          separator: const Text('---'),
          itemBuilder: (context, item, index) => Text('item $item'),
        ),
      );

      expect(find.text('---'), findsNWidgets(2));
    });

    testWidgets('the sliver variant renders items and requests more', (
      tester,
    ) async {
      var loadMoreCalls = 0;

      await tester.pumpApp(
        CustomScrollView(
          slivers: [
            SliverPaginatedListView<int>(
              data: pageOf(page: 1, pagesCount: 2),
              status: BlocLoadState.loaded,
              onLoadMore: () => loadMoreCalls++,
              itemBuilder: (context, item, index) => Text('item $item'),
            ),
          ],
        ),
      );

      expect(find.text('item 3'), findsOneWidget);
      expect(loadMoreCalls, 1);
    });

    testWidgets('has no trailing slot after the last page', (tester) async {
      var loadMoreCalls = 0;

      await tester.pumpApp(
        buildList(
          data: pageOf(page: 2, pagesCount: 2),
          status: BlocLoadState.loaded,
          onLoadMore: () => loadMoreCalls++,
        ),
      );

      expect(find.byType(CustomCircularProgressIndicator), findsNothing);
      expect(loadMoreCalls, 0);
    });
  });
}
