import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/app_bar/app_bar_back_button.dart';

import '../../support/pump_app.dart';

void main() => group('AppBarBackButton', () {
  testWidgets('fires onTap when provided', (tester) async {
    var taps = 0;

    await tester.pumpApp(AppBarBackButton(onTap: () => taps++));
    await tester.tap(find.byType(AppBarBackButton));

    expect(taps, 1);
  });

  testWidgets('pops the current route by default', (tester) async {
    await tester.pumpApp(
      Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const Scaffold(body: AppBarBackButton()),
            ),
          ),
          child: const Text('Open'),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(AppBarBackButton), findsOneWidget);

    await tester.tap(find.byType(AppBarBackButton));
    await tester.pumpAndSettle();

    expect(find.byType(AppBarBackButton), findsNothing);
    expect(find.text('Open'), findsOneWidget);
  });
});
