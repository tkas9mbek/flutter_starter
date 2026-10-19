import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/global/core_consts.dart';
import 'package:starter/core/global/storage_keys.dart';
import 'package:starter/features/settings/data/local_settings_data_source.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/features/settings/ui/menu/screen/settings_screen.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';

import '../../../support/pump.dart';

void main() {
  late SettingsRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKeys.themeMode: 'light',
      SharedPreferencesKeys.languageCode: 'en',
    });
    repository = SettingsRepository(
      LocalSettingsDataSource(await SharedPreferences.getInstance()),
    );
  });

  Future<Localizer> pumpSettings(WidgetTester tester) async {
    // The pickers open on a new route, so the theme must sit above the app.
    await tester.pumpWidget(
      ThemeProvider(
        child: wrapApp(
          MultiBlocProvider(
            providers: [
              BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(repository)),
              BlocProvider<LanguageCubit>(
                create: (_) => LanguageCubit(repository),
              ),
            ],
            child: const SettingsScreen(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    return Localizer.of(tester.element(find.byType(SettingsScreen)));
  }

  testWidgets('rows show the current theme, language and version', (
    tester,
  ) async {
    final localizer = await pumpSettings(tester);

    expect(tester.takeException(), isNull);
    expect(find.widgetWithText(AppListTile, localizer.light), findsOneWidget);
    expect(find.widgetWithText(AppListTile, 'English'), findsOneWidget);
    expect(
      find.widgetWithText(AppListTile, CoreConsts.appVersion),
      findsOneWidget,
    );
  });

  testWidgets('tapping the theme row opens the theme picker', (tester) async {
    final localizer = await pumpSettings(tester);

    await tester.tap(find.widgetWithText(AppListTile, localizer.theme));
    await tester.pumpAndSettle();

    expect(find.byType(DropdownBottomSheet<ThemeModeOption>), findsOneWidget);
  });

  testWidgets('tapping the language row opens the language picker', (
    tester,
  ) async {
    final localizer = await pumpSettings(tester);

    await tester.tap(find.widgetWithText(AppListTile, localizer.language));
    await tester.pumpAndSettle();

    expect(find.byType(DropdownBottomSheet<LanguageOption>), findsOneWidget);
  });
}
