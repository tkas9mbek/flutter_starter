import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/status/app_status_screen.dart';

import '../../support/pump_app.dart';

void main() {
  Widget buildScreen({
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
  }) => AppStatusScreen(
    icon: const SizedBox.shrink(key: Key('icon')),
    title: 'Done',
    subtitle: 'All set',
    primaryButtonLabel: 'Continue',
    onPrimaryPressed: onPrimary ?? () {},
    secondaryButtonLabel: secondaryLabel,
    onSecondaryPressed: onSecondary,
  );

  group('AppStatusScreen', () {
    testWidgets('renders the injected content and fires the primary action', (
      tester,
    ) async {
      var primaryTaps = 0;

      await tester.pumpApp(buildScreen(onPrimary: () => primaryTaps++));

      expect(find.byKey(const Key('icon')), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
      expect(find.text('All set'), findsOneWidget);

      await tester.tap(find.text('Continue'));

      expect(primaryTaps, 1);
    });

    testWidgets('shows the secondary action only when a label is given', (
      tester,
    ) async {
      await tester.pumpApp(buildScreen());

      expect(find.byType(OutlinedButton), findsNothing);
      expect(find.text('Cancel'), findsNothing);
    });

    testWidgets('fires the secondary action', (tester) async {
      var secondaryTaps = 0;

      await tester.pumpApp(
        buildScreen(
          secondaryLabel: 'Cancel',
          onSecondary: () => secondaryTaps++,
        ),
      );
      await tester.tap(find.text('Cancel'));

      expect(secondaryTaps, 1);
    });
  });
}
