import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/app_bar/base_app_bar.dart';

import '../../support/pump_app.dart';

void main() {
  const bottom = PreferredSize(
    preferredSize: Size.fromHeight(30),
    child: Text('Tabs'),
  );

  group('BaseAppBar', () {
    testWidgets('hosts its child and bottom', (tester) async {
      await tester.pumpApp(
        const Scaffold(
          appBar: BaseAppBar(height: 52, bottom: bottom, child: Text('Custom')),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
      expect(find.text('Tabs'), findsOneWidget);
    });

    testWidgets('never adds an implicit back button on a pushed route', (
      tester,
    ) async {
      await tester.pumpApp(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const Scaffold(
                  appBar: BaseAppBar(height: 52, child: Text('Custom')),
                ),
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Custom'), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
    });

    test('preferredSize adds the bottom height', () {
      expect(
        const BaseAppBar(height: 52, child: SizedBox()).preferredSize.height,
        52,
      );
      expect(
        const BaseAppBar(
          height: 52,
          bottom: bottom,
          child: SizedBox(),
        ).preferredSize.height,
        82,
      );
    });
  });
}
