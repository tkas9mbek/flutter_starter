import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';

import 'show_sheet.dart';

void main() {
  final tick = find.byWidgetPredicate(
    (widget) => widget is SvgIcon && widget.icon == UiSvgIcons.tickMark,
  );

  group('DropdownBottomSheet', () {
    testWidgets('lists the options and marks only the selected one', (
      tester,
    ) async {
      await tester.showSheet<String>(
        const DropdownBottomSheet<String>(
          title: 'Pick one',
          options: ['Apple', 'Pear'],
          selected: 'Pear',
        ),
      );

      final pearCard = tester.widget<AppCard>(
        find.ancestor(of: find.text('Pear'), matching: find.byType(AppCard)),
      );

      expect(find.text('Pick one'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(tick, findsOneWidget);
      expect(pearCard.selected, isTrue);
    });

    testWidgets('pops with the tapped option', (tester) async {
      final result = await tester.showSheet<String>(
        const DropdownBottomSheet<String>(options: ['Apple', 'Pear']),
      );

      expect(tick, findsNothing);

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      expect(result(), 'Apple');
      expect(find.byType(DropdownBottomSheet<String>), findsNothing);
    });
  });
}
