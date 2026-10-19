import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/misc/input_accessory_view_wrapper.dart';

import '../../support/pump_app.dart';

void main() => group('InputAccessoryViewWrapper', () {
  late FocusNode focusNode;

  setUp(() => focusNode = FocusNode());

  tearDown(() => focusNode.dispose());

  Widget buildWrapper({required double keyboardInset}) => Builder(
    builder: (context) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(viewInsets: EdgeInsets.only(bottom: keyboardInset)),
      child: InputAccessoryViewWrapper(
        child: Align(
          alignment: Alignment.topCenter,
          child: TextField(focusNode: focusNode),
        ),
      ),
    ),
  );

  testWidgets('has no Done bar while the keyboard is hidden', (tester) async {
    await tester.pumpApp(buildWrapper(keyboardInset: 0));

    expect(find.text(tester.uikitL10n.done), findsNothing);
  });

  testWidgets('shows a Done bar over the keyboard that drops focus', (
    tester,
  ) async {
    await tester.pumpApp(buildWrapper(keyboardInset: 300));
    focusNode.requestFocus();
    await tester.pump();

    final done = find.text(tester.uikitL10n.done);

    expect(done, findsOneWidget);
    expect(focusNode.hasFocus, isTrue);

    await tester.tap(done);
    await tester.pumpAndSettle();

    expect(focusNode.hasFocus, isFalse);
  });
});
