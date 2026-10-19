import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/size/fill_remaining_scroll_view.dart';

import '../../support/pump_app.dart';

void main() => group(
  'FillRemainingScrollView',
  () => testWidgets(
    'lets pull-to-refresh fire on content that does not scroll',
    (tester) async {
      var refreshes = 0;

      await tester.pumpApp(
        RefreshIndicator(
          onRefresh: () async => refreshes++,
          child: const FillRemainingScrollView(child: Text('Nothing here')),
        ),
      );

      expect(find.text('Nothing here'), findsOneWidget);

      await tester.fling(find.text('Nothing here'), const Offset(0, 300), 1000);
      await tester.pumpAndSettle();

      expect(refreshes, 1);
    },
  ),
);
