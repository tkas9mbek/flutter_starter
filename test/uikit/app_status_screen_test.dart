import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/status/app_status_screen.dart';

import '../support/pump.dart';

void main() {
  testWidgets('tapping the primary button invokes onPrimaryPressed', (
    tester,
  ) async {
    var primaryTapped = false;

    await tester.pumpWidget(
      wrapApp(
        AppStatusScreen(
          icon: const Icon(Icons.check),
          title: 'Title',
          subtitle: 'Subtitle',
          primaryButtonLabel: 'Continue',
          onPrimaryPressed: () => primaryTapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(primaryTapped, isTrue);
  });

  testWidgets('tapping the secondary button invokes onSecondaryPressed', (
    tester,
  ) async {
    var secondaryTapped = false;

    await tester.pumpWidget(
      wrapApp(
        AppStatusScreen(
          icon: const Icon(Icons.error),
          title: 'Title',
          subtitle: 'Subtitle',
          primaryButtonLabel: 'Retry',
          onPrimaryPressed: () {},
          secondaryButtonLabel: 'Cancel',
          onSecondaryPressed: () => secondaryTapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(secondaryTapped, isTrue);
  });

  testWidgets('omitting secondaryButtonLabel renders no secondary button', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapApp(
        AppStatusScreen(
          icon: const Icon(Icons.check),
          title: 'Title',
          subtitle: 'Subtitle',
          primaryButtonLabel: 'Continue',
          onPrimaryPressed: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AppOutlinedButton), findsNothing);
  });
}
