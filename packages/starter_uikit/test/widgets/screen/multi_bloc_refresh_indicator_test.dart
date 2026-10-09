import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/bloc/refreshable_bloc.dart';
import 'package:starter_uikit/widgets/screen/multi_bloc_refresh_indicator.dart';

import '../../support/pump_app.dart';

class _FakeRefreshableBloc with RefreshableBloc {}

void main() {
  Widget buildIndicator({
    required List<RefreshableBloc> blocs,
    required Future<void> Function() onRefresh,
  }) => MultiBlocRefreshIndicator(
    blocs: blocs,
    onRefresh: onRefresh,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [SizedBox(height: 100, child: Text('row'))],
    ),
  );

  // StreamSubscription.cancel() inside the widget only resolves on the real
  // event loop, so the fake-async clock alone never lets the refresh finish.
  Future<void> finishRefresh(
    WidgetTester tester,
    List<_FakeRefreshableBloc> blocs,
  ) async {
    for (final bloc in blocs) {
      bloc.refreshing = false;
    }

    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();
  }

  group('MultiBlocRefreshIndicator', () {
    testWidgets('pull-to-refresh calls onRefresh and flags every bloc', (
      tester,
    ) async {
      final blocs = <_FakeRefreshableBloc>[
        _FakeRefreshableBloc(),
        _FakeRefreshableBloc(),
      ];
      var refreshCalls = 0;
      var refreshingWhenCalled = false;

      await tester.pumpApp(
        buildIndicator(
          blocs: blocs,
          onRefresh: () async {
            refreshCalls++;
            refreshingWhenCalled = blocs.every((bloc) => bloc.refreshing);
          },
        ),
      );
      await tester.fling(find.text('row'), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(refreshCalls, 1);
      expect(refreshingWhenCalled, isTrue);

      await finishRefresh(tester, blocs);

      expect(find.byType(RefreshProgressIndicator), findsNothing);
    });

    testWidgets('stays refreshing until every bloc finishes', (tester) async {
      final blocs = <_FakeRefreshableBloc>[
        _FakeRefreshableBloc(),
        _FakeRefreshableBloc(),
      ];

      await tester.pumpApp(
        buildIndicator(blocs: blocs, onRefresh: () async {}),
      );
      await tester.fling(find.text('row'), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(RefreshProgressIndicator), findsOneWidget);

      blocs.first.refreshing = false;
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(RefreshProgressIndicator), findsOneWidget);

      await finishRefresh(tester, [blocs.last]);

      expect(find.byType(RefreshProgressIndicator), findsNothing);
    });
  });
}
