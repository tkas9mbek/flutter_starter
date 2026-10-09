import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

import '../../support/pump_app.dart';

void main() {
  Widget buildTrigger(void Function(BuildContext context) onTap) => Builder(
    builder: (context) => ElevatedButton(
      onPressed: () => onTap(context),
      child: const Text('trigger'),
    ),
  );

  // The bar renders its message inside a RichText next to a WidgetSpan icon, so match by substring.
  Finder findBarText(String text) =>
      find.textContaining(text, findRichText: true);

  Future<void> trigger(WidgetTester tester) async {
    await tester.tap(find.text('trigger'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  // The overlay entry removes itself after its 2s timer and slide-out.
  Future<void> dismissAfterTimeout(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  }

  group('NotificationSnackBar', () {
    testWidgets('show displays the message and auto-dismisses', (tester) async {
      await tester.pumpApp(
        buildTrigger(
          (context) => NotificationSnackBar.show(
            context,
            NotificationSnackBar.success(text: 'Saved'),
          ),
        ),
      );
      await trigger(tester);

      expect(findBarText('Saved'), findsOneWidget);

      await dismissAfterTimeout(tester);

      expect(findBarText('Saved'), findsNothing);
    });

    testWidgets('tapping the bar dismisses it early', (tester) async {
      await tester.pumpApp(
        buildTrigger(
          (context) => NotificationSnackBar.show(
            context,
            NotificationSnackBar.information(text: 'Heads up'),
          ),
        ),
      );
      await trigger(tester);
      await tester.tap(findBarText('Heads up'));
      await tester.pumpAndSettle();

      expect(findBarText('Heads up'), findsNothing);
    });

    testWidgets('showExceptionMessage shows the localized exception text', (
      tester,
    ) async {
      await tester.pumpApp(
        buildTrigger(
          (context) => NotificationSnackBar.showExceptionMessage(
            context,
            exception: const NoInternetException(),
          ),
        ),
      );
      await trigger(tester);

      final l10n = tester.uikitL10n;

      expect(findBarText(l10n.errorMessageNoConnection), findsOneWidget);

      await dismissAfterTimeout(tester);
    });
  });
}
