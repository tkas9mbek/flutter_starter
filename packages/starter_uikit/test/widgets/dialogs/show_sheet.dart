import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';

import '../../support/pump_app.dart';

extension ShowSheetX on WidgetTester {
  /// Opens [sheet] through `BottomSheetScreen.show`, the way the app does,
  /// and returns a getter for the value it pops with.
  Future<T? Function()> showSheet<T>(Widget sheet) async {
    T? result;

    await pumpApp(
      Builder(
        builder: (context) => TextButton(
          onPressed: () async => result = await BottomSheetScreen.show<T>(
            context: context,
            builder: (_) => sheet,
          ),
          child: const Text('Open'),
        ),
      ),
    );
    await tap(find.text('Open'));
    await pumpAndSettle();

    return () => result;
  }
}
