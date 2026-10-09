import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:request_logger/controller/request_logger.dart';
import 'package:request_logger/data/http_log_manager.dart';
import 'package:request_logger/screen/request_log_details_screen.dart';
import 'package:request_logger/screen/request_log_list_screen.dart';
import 'package:request_logger/widget/request_logger_button.dart';
import 'package:starter_toolkit/data/interceptor/app_error_interceptor.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

import 'support/fake_adapter.dart';

Widget _app(Widget home, {GlobalKey<NavigatorState>? navigatorKey}) =>
    ThemeProvider(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        locale: const Locale('en'),
        localizationsDelegates: const [
          UikitLocalizer.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: UikitLocalizer.delegate.supportedLocales,
        home: home,
      ),
    );

Future<void> _logCall(String path, {int status = 200}) async {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))
    ..httpClientAdapter = FakeAdapter(
      (_) async => FakeAdapter.json({'ok': status < 400}, status: status),
    )
    ..interceptors.add(RequestLogger.dioInterceptor());

  try {
    await dio.get<dynamic>(path);
  } on DioException {
    // The failing call is still captured by the interceptor.
  }
}

Future<void> _logConnectionFailure(String path) async {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))
    ..httpClientAdapter = FakeAdapter(
      (options) async => throw DioException.connectionError(
        requestOptions: options,
        reason: 'Failed host lookup',
      ),
    )
    ..interceptors.addAll([
      const AppErrorInterceptor(),
      RequestLogger.dioInterceptor(),
    ]);

  try {
    await dio.get<dynamic>(path);
  } on DioException {
    // Captured by the interceptor.
  }
}

void main() {
  setUp(HttpLogManager.instance.cleanHTTP);

  testWidgets('shows the empty state when nothing was logged', (tester) async {
    await tester.pumpWidget(_app(const RequestLogListScreen()));
    await tester.pumpAndSettle();

    expect(find.text('No requests logged yet'), findsOneWidget);
  });

  testWidgets('lists captured calls newest first and live-updates', (
    tester,
  ) async {
    await tester.runAsync(() => _logCall('/profile'));
    await tester.pumpWidget(_app(const RequestLogListScreen()));
    await tester.pumpAndSettle();

    expect(find.text('/profile'), findsOneWidget);
    expect(find.text('GET'), findsOneWidget);

    await tester.runAsync(() => _logCall('/tasks', status: 500));
    await tester.pumpAndSettle();

    expect(find.text('/tasks'), findsOneWidget);
    final newest = tester.getTopLeft(find.text('/tasks')).dy;
    final oldest = tester.getTopLeft(find.text('/profile')).dy;
    expect(newest, lessThan(oldest));
  });

  testWidgets('the trash action clears the list', (tester) async {
    await tester.runAsync(() => _logCall('/profile'));
    await tester.pumpWidget(_app(const RequestLogListScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.text('No requests logged yet'), findsOneWidget);
    expect(HttpLogManager.instance.logValues(), isEmpty);
  });

  testWidgets('the environment pill opens the log list', (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      _app(
        Stack(
          children: [
            const SizedBox.expand(),
            Align(
              alignment: Alignment.topRight,
              child: RequestLoggerButton(
                label: 'mock',
                navigatorKey: navigatorKey,
              ),
            ),
          ],
        ),
        navigatorKey: navigatorKey,
      ),
    );

    await tester.tap(find.text('mock'));
    await tester.pumpAndSettle();

    expect(find.byType(RequestLogListScreen), findsOneWidget);
  });

  testWidgets('a failed call shows its error type and message', (tester) async {
    await tester.runAsync(() => _logConnectionFailure('/tasks'));
    await tester.pumpWidget(_app(const RequestLogListScreen()));
    await tester.pumpAndSettle();

    expect(find.text('connectionError'), findsOneWidget);

    await tester.tap(find.text('/tasks'));
    await tester.pumpAndSettle();
    expect(find.byType(RequestLogDetailsScreen), findsOneWidget);
    expect(
      find.textContaining('connectionError', findRichText: true),
      findsWidgets,
    );

    await tester.tap(find.text('Error'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Failed host lookup'), findsWidgets);
    expect(find.textContaining('Instance of'), findsNothing);
  });
}
