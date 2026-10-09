import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

import '../../support/pump_app.dart';

void main() {
  Widget buildButton({
    VoidCallback? onPressed,
    bool enabled = true,
    bool loading = false,
  }) => Builder(
    builder: (context) => AppOutlinedButton.big(
      context: context,
      text: 'Go',
      onPressed: onPressed,
      enabled: enabled,
      loading: loading,
    ),
  );

  group('AppOutlinedButton', () {
    testWidgets('fires onPressed on tap and shows its label', (tester) async {
      var taps = 0;

      await tester.pumpApp(buildButton(onPressed: () => taps++));
      await tester.tap(find.text('Go'));

      expect(taps, 1);
      expect(find.byType(CustomCircularProgressIndicator), findsNothing);
    });

    testWidgets('does not fire onPressed when enabled is false', (
      tester,
    ) async {
      var taps = 0;

      await tester.pumpApp(
        buildButton(onPressed: () => taps++, enabled: false),
      );
      await tester.tap(find.text('Go'));

      expect(taps, 0);
    });

    testWidgets('loading swaps the label for a progress indicator and '
        'blocks taps', (tester) async {
      var taps = 0;

      await tester.pumpApp(
        buildButton(onPressed: () => taps++, loading: true),
        settle: false,
      );
      await tester.tap(find.byType(ElevatedButton));

      expect(find.text('Go'), findsNothing);
      expect(find.byType(CustomCircularProgressIndicator), findsOneWidget);
      expect(taps, 0);
    });
  });
}
