import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

import '../../support/pump_app.dart';

void main() {
  group('CustomCircularProgressIndicator', () {
    testWidgets(
      'adaptive builds a Material spinner on Android',
      (tester) async {
        await tester.pumpApp(
          const CustomCircularProgressIndicator.adaptive(),
          settle: false,
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(CupertinoActivityIndicator), findsNothing);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.android),
    );

    testWidgets(
      'adaptive builds a Cupertino spinner on iOS',
      (tester) async {
        await tester.pumpApp(
          const CustomCircularProgressIndicator.adaptive(),
          settle: false,
        );

        expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );

    testWidgets(
      'non-adaptive always builds a Material spinner',
      (tester) async {
        await tester.pumpApp(
          const CustomCircularProgressIndicator(),
          settle: false,
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );
  });
}
