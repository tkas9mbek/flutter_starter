import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/task/ui/calendar/widget/task_timeline_item_card.dart';
import 'package:starter/features/task/ui/details/widget/delete_task_dialog.dart';
import 'package:starter/features/task/ui/details/widget/task_details_content.dart';
import 'package:starter/features/task/ui/list/widget/task_date_group_card.dart';
import 'package:starter/features/task/ui/search/widget/recent_queries_list.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

import '../model/task_mock_models.dart';

Widget _app(String language, Widget child) => MaterialApp(
  locale: Locale(language),
  localizationsDelegates: const [
    Localizer.delegate,
    UikitLocalizer.delegate,
    ToolkitLocalizer.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: Localizer.delegate.supportedLocales,
  home: ThemeProvider(child: Scaffold(body: child)),
);

void main() {
  group('TaskDetailsContent', () {
    // task1 is on 2025-01-15.
    for (final (language, date) in [
      ('en', '15 January 2025'),
      ('ru', '15 января 2025'),
    ]) {
      testWidgets('shows the date in $language', (tester) async {
        await tester.pumpWidget(
          _app(language, TaskDetailsContent(task: TaskMockModels.task1)),
        );
        await tester.pumpAndSettle();

        expect(find.text(date), findsOneWidget);
      });
    }
  });

  group('DeleteTaskDialog', () {
    Future<bool?> openAndTap(WidgetTester tester, String button) async {
      bool? result;
      await tester.pumpWidget(
        _app(
          'en',
          Builder(
            builder: (context) => TextButton(
              onPressed: () async =>
                  result = await DeleteTaskDialog.confirm(context),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(button));
      await tester.pumpAndSettle();

      return result;
    }

    testWidgets('resolves true when the user confirms', (tester) async {
      expect(await openAndTap(tester, 'Delete'), isTrue);
    });

    testWidgets('resolves false when the user cancels', (tester) async {
      expect(await openAndTap(tester, 'Cancel'), isFalse);
    });
  });

  group('RecentQueriesList', () {
    testWidgets('reports the tapped query', (tester) async {
      String? selected;

      await tester.pumpWidget(
        _app(
          'en',
          RecentQueriesList(
            queries: const ['code', 'plan'],
            onSelected: (query) => selected = query,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('plan'));

      expect(selected, 'plan');
    });
  });

  group('large accessibility text', () {
    Widget scaled(Widget child) => MediaQuery(
      data: const MediaQueryData(textScaler: TextScaler.linear(3)),
      child: _app('en', SingleChildScrollView(child: child)),
    );

    testWidgets('the calendar card does not overflow', (tester) async {
      await tester.pumpWidget(
        scaled(TaskTimelineItemCard(task: TaskMockModels.task1)),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text(TaskMockModels.task1.title), findsOneWidget);
    });

    testWidgets('the date group header does not overflow', (tester) async {
      await tester.pumpWidget(
        scaled(
          TaskDateGroupCard(
            date: DateTime(2030, 5, 10),
            tasks: [TaskMockModels.task1, TaskMockModels.task2],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
