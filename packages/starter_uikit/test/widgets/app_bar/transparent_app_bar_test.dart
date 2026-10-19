import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/app_bar/transparent_app_bar.dart';

import '../../support/pump_app.dart';

void main() {
  Widget buildScreen(ScrollController controller) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: TransparentAppBar(
      title: 'Profile',
      scrollController: controller,
      transparentHeight: 100,
    ),
    body: ListView(
      controller: controller,
      children: [
        for (var i = 0; i < 40; i++) ...[
          SizedBox(height: 50, child: Text('row $i')),
        ],
      ],
    ),
  );

  group('TransparentAppBar', () {
    testWidgets('stays transparent until scrolled past transparentHeight', (
      tester,
    ) async {
      final controller = ScrollController();
      addTearDown(controller.dispose);

      await tester.pumpApp(buildScreen(controller));

      expect(find.text('Profile'), findsOneWidget);
      expect(find.byType(TitleAppBar), findsNothing);

      controller.jumpTo(80);
      await tester.pumpAndSettle();

      expect(find.byType(TitleAppBar), findsNothing);

      controller.jumpTo(150);
      await tester.pumpAndSettle();

      expect(find.byType(TitleAppBar), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('turns transparent again when scrolled back up', (
      tester,
    ) async {
      final controller = ScrollController();
      addTearDown(controller.dispose);

      await tester.pumpApp(buildScreen(controller));
      controller.jumpTo(150);
      await tester.pumpAndSettle();

      expect(find.byType(TitleAppBar), findsOneWidget);

      controller.jumpTo(0);
      await tester.pumpAndSettle();

      expect(find.byType(TitleAppBar), findsNothing);
    });

    testWidgets('starts solid when the list opens already scrolled', (
      tester,
    ) async {
      final controller = ScrollController(initialScrollOffset: 300);
      addTearDown(controller.dispose);

      await tester.pumpApp(buildScreen(controller));

      expect(find.byType(TitleAppBar), findsOneWidget);
    });
  });
}
