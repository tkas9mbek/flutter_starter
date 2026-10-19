import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/screen/stack_animated_switcher.dart';

import '../../support/pump_app.dart';

void main() {
  Future<void> switchTo(WidgetTester tester, Widget child) =>
      tester.pumpApp(StackAnimatedSwitcher(child: child), settle: false);

  group('StackAnimatedSwitcher', () {
    testWidgets('cross-fades between children of different types', (
      tester,
    ) async {
      await tester.pumpApp(const StackAnimatedSwitcher(child: Text('loading')));
      await switchTo(tester, const Center(child: Text('loaded')));

      expect(find.text('loading'), findsOneWidget);
      expect(find.text('loaded'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('loading'), findsNothing);
      expect(find.text('loaded'), findsOneWidget);
    });

    testWidgets('updates a same-type child in place without a transition', (
      tester,
    ) async {
      await tester.pumpApp(const StackAnimatedSwitcher(child: Text('page 1')));
      await switchTo(tester, const Text('page 2'));

      expect(find.text('page 1'), findsNothing);
      expect(find.text('page 2'), findsOneWidget);
    });

    testWidgets('explicit keys make same-type children animate', (
      tester,
    ) async {
      await tester.pumpApp(
        const StackAnimatedSwitcher(child: Text('empty', key: Key('empty'))),
      );
      await switchTo(tester, const Text('failure', key: Key('failure')));

      expect(find.text('empty'), findsOneWidget);
      expect(find.text('failure'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('empty'), findsNothing);
    });
  });
}
