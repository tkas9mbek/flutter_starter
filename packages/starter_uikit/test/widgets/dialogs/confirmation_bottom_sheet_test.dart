import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/dialogs/confirmation_bottom_sheet.dart';

import '../../support/pump_app.dart';
import 'show_sheet.dart';

void main() => group('ConfirmationBottomSheet', () {
  testWidgets('shows title and text, and pops true on confirm', (tester) async {
    final result = await tester.showSheet<bool>(
      const ConfirmationBottomSheet(
        title: 'Delete?',
        text: 'This cannot be undone',
        buttonText: 'Delete',
      ),
    );

    expect(find.text('Delete?'), findsOneWidget);
    expect(find.text('This cannot be undone'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(result(), isTrue);
  });

  testWidgets('the close button dismisses with null', (tester) async {
    final result = await tester.showSheet<bool>(
      const ConfirmationBottomSheet(title: 'Delete?', buttonText: 'Delete'),
    );

    await tester.tap(find.text(tester.uikitL10n.back));
    await tester.pumpAndSettle();

    expect(result(), isNull);
    expect(find.byType(ConfirmationBottomSheet), findsNothing);
  });
});
