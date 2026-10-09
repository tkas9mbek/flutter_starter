import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';

import '../../support/pump_app.dart';

void main() {
  group('EmptyInformationBody', () {
    testWidgets('falls back to the localized "no data" text', (tester) async {
      await tester.pumpApp(const EmptyInformationBody());

      final l10n = tester.uikitL10n;

      expect(find.text(l10n.noDataAvailable), findsOneWidget);
      expect(find.text(l10n.retry), findsNothing);
    });

    testWidgets('shows custom text and fires onRetry', (tester) async {
      var retries = 0;

      await tester.pumpApp(
        EmptyInformationBody(text: 'Nothing here', onRetry: () => retries++),
      );

      final l10n = tester.uikitL10n;

      expect(find.text('Nothing here'), findsOneWidget);

      await tester.tap(find.text(l10n.retry));

      expect(retries, 1);
    });
  });
}
