import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';

import '../../support/pump_app.dart';

void main() {
  const retryable = NoInternetException();
  const notRetryable = UnauthorizedException();

  group('FailureWidget.large', () {
    testWidgets('shows the description and fires onRetry on the retry label', (
      tester,
    ) async {
      var retries = 0;

      await tester.pumpApp(
        FailureWidget.large(exception: retryable, onRetry: () => retries++),
      );

      final l10n = tester.uikitL10n;

      expect(find.text(l10n.errorMessageCouldNotConnectServer), findsOneWidget);
      expect(find.text(l10n.tryRefreshPage), findsOneWidget);

      await tester.tap(find.text(l10n.retry));

      expect(retries, 1);
    });

    testWidgets('hides retry when onRetry is null', (tester) async {
      await tester.pumpApp(const FailureWidget.large(exception: retryable));

      final l10n = tester.uikitL10n;

      expect(find.text(l10n.retry), findsNothing);
    });

    testWidgets('hides retry when the exception cannot be retried', (
      tester,
    ) async {
      await tester.pumpApp(
        FailureWidget.large(exception: notRetryable, onRetry: () {}),
      );

      final l10n = tester.uikitL10n;

      expect(find.text(l10n.retry), findsNothing);
    });
  });

  group('FailureWidget.small', () {
    testWidgets('shows the message and a tappable retry icon', (tester) async {
      var retries = 0;

      await tester.pumpApp(
        FailureWidget.small(
          exception: const ServerException(statusCode: 500, message: 'Oops'),
          onRetry: () => retries++,
        ),
      );

      expect(find.text('Oops'), findsOneWidget);

      await tester.tap(find.byType(SvgPicture));

      expect(retries, 1);
    });

    testWidgets('hides the retry icon when onRetry is null', (tester) async {
      await tester.pumpApp(
        const FailureWidget.small(
          exception: ServerException(statusCode: 500, message: 'Oops'),
        ),
      );

      expect(find.byType(SvgPicture), findsNothing);
    });
  });
}
