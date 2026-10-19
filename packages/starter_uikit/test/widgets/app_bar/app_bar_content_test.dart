import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/app_bar/app_bar_content.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

import '../../support/pump_app.dart';

void main() {
  final backChevron = find.byWidgetPredicate(
    (widget) => widget is SvgIcon && widget.icon == UiSvgIcons.chevronLeft,
  );

  Widget pushingButton(Widget content) => Builder(
    builder: (context) => TextButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => Scaffold(body: SizedBox(height: 52, child: content)),
        ),
      ),
      child: const Text('Open'),
    ),
  );

  group('AppBarContent', () {
    testWidgets('shows the title, subtitle and actions', (tester) async {
      var actionTaps = 0;

      await tester.pumpApp(
        SizedBox(
          height: 52,
          child: AppBarContent(
            title: 'Profile',
            subtitle: const Text('Edit mode'),
            actions: [
              TextButton(
                onPressed: () => actionTaps++,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Save'));

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Edit mode'), findsOneWidget);
      expect(actionTaps, 1);
    });

    testWidgets('has no back chevron on a route that cannot pop', (
      tester,
    ) async {
      await tester.pumpApp(
        const SizedBox(height: 52, child: AppBarContent(title: 'Home')),
      );

      expect(backChevron, findsNothing);
    });

    testWidgets('shows a back chevron on a pushed route that pops it', (
      tester,
    ) async {
      await tester.pumpApp(
        pushingButton(const AppBarContent(title: 'Details')),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(backChevron, findsOneWidget);

      await tester.tap(backChevron);
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsNothing);
      expect(find.text('Open'), findsOneWidget);
    });

    testWidgets('automaticallyImplyLeading: false hides the back chevron', (
      tester,
    ) async {
      await tester.pumpApp(
        pushingButton(
          const AppBarContent(
            title: 'Details',
            automaticallyImplyLeading: false,
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);
      expect(backChevron, findsNothing);
    });
  });
}
