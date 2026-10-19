import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/status_pill.dart';

import '../../support/pump_app.dart';

void main() => testWidgets('StatusPill shows its label in the onStatus color', (
  tester,
) async {
  await tester.pumpApp(
    Builder(
      builder: (context) => StatusPill(
        label: 'Done',
        color: ThemeProvider.of(context).theme.success,
      ),
    ),
  );

  final theme = ThemeProvider.of(tester.element(find.text('Done'))).theme;

  expect(find.text('Done'), findsOneWidget);
  expect(tester.widget<Text>(find.text('Done')).style?.color, theme.onStatus);
});
