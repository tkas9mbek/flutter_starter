import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

import '../../support/pump_app.dart';

void main() {
  final backChevron = find.byWidgetPredicate(
    (widget) => widget is SvgIcon && widget.icon == UiSvgIcons.chevronLeft,
  );

  Widget pushing(TitleAppBar appBar) => Builder(
    builder: (context) => TextButton(
      onPressed: () => Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => Scaffold(appBar: appBar))),
      child: const Text('Open'),
    ),
  );

  group('TitleAppBar', () {
    testWidgets('renders title, subtitle, actions and bottom', (tester) async {
      // An unstyled subtitle inherits the 20px app bar title style and
      // overflows the default 52px height, so it gets the small body style.
      final subtitleStyle = AppTextStyles(AppTheme.light()).regularBody12;

      await tester.pumpApp(
        Scaffold(
          appBar: TitleAppBar(
            title: 'Settings',
            subtitle: Text('Account', style: subtitleStyle),
            actions: const [Text('Edit')],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Text('Tabs'),
            ),
          ),
        ),
      );

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Tabs'), findsOneWidget);
      expect(backChevron, findsNothing);
    });

    testWidgets('a pushed screen gets a back chevron that pops it', (
      tester,
    ) async {
      await tester.pumpApp(pushing(const TitleAppBar(title: 'Details')));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(backChevron, findsOneWidget);

      await tester.tap(backChevron);
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsNothing);
    });

    testWidgets('automaticallyImplyLeading: false drops the back chevron', (
      tester,
    ) async {
      await tester.pumpApp(
        pushing(
          const TitleAppBar(title: 'Details', automaticallyImplyLeading: false),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);
      expect(backChevron, findsNothing);
      expect(find.byType(BackButton), findsNothing);
    });

    test('preferredSize is height plus the bottom height', () {
      const bar = TitleAppBar(
        title: 'T',
        height: 60,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: SizedBox(),
        ),
      );

      expect(bar.preferredSize.height, 90);
    });
  });
}
