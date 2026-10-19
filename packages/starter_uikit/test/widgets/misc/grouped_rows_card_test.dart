import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';

import '../../support/pump_app.dart';

void main() => group('GroupedRowsCard', () {
  testWidgets('separates rows with dividers only between them', (tester) async {
    await tester.pumpApp(
      const GroupedRowsCard(
        children: [
          AppListTile(title: 'First'),
          AppListTile(title: 'Second'),
          AppListTile(title: 'Third'),
        ],
      ),
    );

    expect(find.text('First'), findsOneWidget);
    expect(find.text('Third'), findsOneWidget);
    expect(find.byType(ThinHorizontalDivider), findsNWidgets(2));
  });

  testWidgets('routes taps to the tapped row', (tester) async {
    final tapped = <String>[];

    await tester.pumpApp(
      GroupedRowsCard(
        children: [
          AppListTile(title: 'First', onTap: () => tapped.add('First')),
          AppListTile(title: 'Second', onTap: () => tapped.add('Second')),
        ],
      ),
    );
    await tester.tap(find.text('Second'));

    expect(tapped, ['Second']);
  });
});
