import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/misc/unfocus_area.dart';

import '../../support/pump_app.dart';

void main() => group('UnfocusArea', () {
  late FocusNode focusNode;
  late List<bool> focusChanges;

  setUp(() {
    focusNode = FocusNode();
    focusChanges = [];
    focusNode.addListener(() => focusChanges.add(focusNode.hasFocus));
  });

  tearDown(() => focusNode.dispose());

  Widget buildArea() => UnfocusArea(
    child: Column(
      children: [
        TextField(focusNode: focusNode),
        const Expanded(child: SizedBox.expand(key: Key('outside'))),
      ],
    ),
  );

  testWidgets('a tap outside any field drops the focus', (tester) async {
    await tester.pumpApp(buildArea());
    await tester.tap(find.byType(TextField));
    await tester.pump();

    expect(focusNode.hasFocus, isTrue);

    await tester.tap(find.byKey(const Key('outside')));
    await tester.pump();

    expect(focusNode.hasFocus, isFalse);
  });

  testWidgets('a tap on the focused field keeps the focus untouched', (
    tester,
  ) async {
    await tester.pumpApp(buildArea());
    await tester.tap(find.byType(TextField));
    await tester.pump();
    focusChanges.clear();

    await tester.tap(find.byType(TextField));
    await tester.pump();

    expect(focusNode.hasFocus, isTrue);
    expect(focusChanges, isEmpty);
  });
});
