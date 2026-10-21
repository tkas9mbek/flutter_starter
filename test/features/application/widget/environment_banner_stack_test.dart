import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/switcher/bloc/environment_cubit.dart';
import 'package:starter/features/application/environment/ui/switcher/widget/environment_banner_stack.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class _FakeEnvironmentCubit extends MockCubit<AppEnvironment>
    implements EnvironmentCubit {}

void main() {
  const statusBar = EdgeInsets.only(top: 50);

  Future<double> pumpBanner(WidgetTester tester, AppEnvironment env) async {
    final cubit = _FakeEnvironmentCubit();
    whenListen(cubit, const Stream<AppEnvironment>.empty(), initialState: env);
    var contentTopInset = -1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(padding: statusBar),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: BlocProvider<EnvironmentCubit>.value(
            value: cubit,
            child: ThemeProvider(
              child: EnvironmentBannerStack(
                navigatorKey: GlobalKey<NavigatorState>(),
                child: Builder(
                  builder: (context) {
                    contentTopInset = MediaQuery.paddingOf(context).top;

                    return const Text('content');
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return contentTopInset;
  }

  testWidgets('puts the banner above the content and takes the status inset', (
    tester,
  ) async {
    final contentTopInset = await pumpBanner(tester, AppEnvironment.mock());

    expect(find.text('mock'), findsOneWidget);
    expect(contentTopInset, 0);
    expect(
      tester.getBottomLeft(find.text('mock')).dy,
      lessThanOrEqualTo(tester.getTopLeft(find.text('content')).dy),
    );
  });

  testWidgets('shows no banner and keeps the status inset when hidden', (
    tester,
  ) async {
    final contentTopInset = await pumpBanner(tester, AppEnvironment.prod());

    expect(find.text('prod'), findsNothing);
    expect(contentTopInset, statusBar.top);
  });
}
