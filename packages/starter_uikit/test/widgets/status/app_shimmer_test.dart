import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';

import '../../support/pump_app.dart';

void main() {
  final theme = AppTheme.light();

  BoxDecoration decorationOf(WidgetTester tester, Type shape) =>
      tester
              .widget<Container>(
                find.descendant(
                  of: find.byType(shape),
                  matching: find.byType(Container),
                ),
              )
              .decoration!
          as BoxDecoration;

  group('AppShimmer', () {
    testWidgets('animated mode runs one themed shimmer for the group', (
      tester,
    ) async {
      await tester.pumpApp(
        const AppShimmer(
          child: Column(
            children: [
              AppShimmerBox(width: 100, height: 20),
              AppShimmerCircle(size: 40),
            ],
          ),
        ),
        settle: false,
      );

      final shimmer = tester.widget<Shimmer>(find.byType(Shimmer));

      expect(find.byType(Shimmer), findsOneWidget);
      expect(shimmer.enabled, isTrue);
      expect(shimmer.gradient.colors, contains(theme.shimmerBase));
      expect(shimmer.gradient.colors, contains(theme.shimmerHighlight));
    });

    testWidgets('static mode keeps the skeleton but stops the sweep', (
      tester,
    ) async {
      await tester.pumpApp(
        const AppShimmer(mode: AppShimmerMode.static, child: AppShimmerText()),
      );

      expect(tester.widget<Shimmer>(find.byType(Shimmer)).enabled, isFalse);
    });

    testWidgets('disabled mode shows the child without a shimmer', (
      tester,
    ) async {
      await tester.pumpApp(
        const AppShimmer(mode: AppShimmerMode.disabled, child: Text('real')),
      );

      expect(find.byType(Shimmer), findsNothing);
      expect(find.text('real'), findsOneWidget);
    });

    testWidgets('pauses when platform animations are disabled', (tester) async {
      await tester.pumpApp(
        Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: const AppShimmer(child: AppShimmerText()),
          ),
        ),
      );

      expect(tester.widget<Shimmer>(find.byType(Shimmer)).enabled, isFalse);
    });

    testWidgets('pauses in the background and resumes in the foreground', (
      tester,
    ) async {
      addTearDown(
        () => tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        ),
      );

      await tester.pumpApp(
        const AppShimmer(child: AppShimmerText()),
        settle: false,
      );

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump();

      expect(tester.widget<Shimmer>(find.byType(Shimmer)).enabled, isFalse);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      expect(tester.widget<Shimmer>(find.byType(Shimmer)).enabled, isTrue);
    });
  });

  group('AppShimmer shapes', () {
    testWidgets('AppShimmerBox is a shimmerBase box of the given size', (
      tester,
    ) async {
      await tester.pumpApp(
        const Center(child: AppShimmerBox(width: 100, height: 20)),
      );

      final decoration = decorationOf(tester, AppShimmerBox);

      expect(tester.getSize(find.byType(AppShimmerBox)), const Size(100, 20));
      expect(decoration.color, theme.shimmerBase);
      expect(decoration.borderRadius, BorderRadius.circular(AppRadii.md));
    });

    testWidgets('AppShimmerCircle is a shimmerBase circle of size', (
      tester,
    ) async {
      await tester.pumpApp(const Center(child: AppShimmerCircle(size: 40)));

      final decoration = decorationOf(tester, AppShimmerCircle);

      expect(tester.getSize(find.byType(AppShimmerCircle)), const Size(40, 40));
      expect(decoration.color, theme.shimmerBase);
      expect(decoration.shape, BoxShape.circle);
    });

    testWidgets('AppShimmerText uses height, or the line height of style', (
      tester,
    ) async {
      await tester.pumpApp(
        const Center(child: AppShimmerText(width: 120, height: 14)),
      );

      expect(tester.getSize(find.byType(AppShimmerText)), const Size(120, 14));

      final style = AppTextStyles(theme).regularBody16;

      await tester.pumpApp(
        Center(child: AppShimmerText(width: 300, style: style)),
      );

      expect(
        tester.getSize(find.byType(AppShimmerText)).height,
        closeTo(style.fontSize! * style.height!, 0.5),
      );
    });
  });
}
