import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_uikit/example/cubit/theme_cubit.dart';
import 'package:starter_uikit/example/router/example_router.dart';
import 'package:starter_uikit/example/widgets/example_tile.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class UikitMenuScreen extends StatelessWidget {
  const UikitMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: TitleAppBar(
        title: localizer.uiKit,
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) => IconButton(
              icon: Icon(
                themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExampleTile(
              title: localizer.buttons,
              subtitle: localizer.buttonsDescription,
              icon: Icons.smart_button,
              onTap: () => context.router.push(const ButtonsExampleRoute()),
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: localizer.formFields,
              subtitle: localizer.formFieldsDescription,
              icon: Icons.edit_note,
              onTap: () => context.router.push(FormFieldsExampleRoute()),
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: localizer.statusWidgets,
              subtitle: localizer.statusWidgetsDescription,
              icon: Icons.error_outline,
              onTap: () => context.router.push(const StatusWidgetsExampleRoute()),
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: localizer.appBars,
              subtitle: localizer.appBarsDescription,
              icon: Icons.web_asset,
              onTap: () => context.router.push(const AppBarsExampleRoute()),
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: localizer.dialogs,
              subtitle: localizer.dialogsDescription,
              icon: Icons.open_in_new,
              onTap: () => context.router.push(const DialogsExampleRoute()),
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: localizer.textWidgets,
              subtitle: localizer.textWidgetsDescription,
              icon: Icons.text_fields,
              onTap: () => context.router.push(const TextWidgetsExampleRoute()),
            ),
            const SizedBox(height: 8),
            ExampleTile(
              title: localizer.miscWidgets,
              subtitle: localizer.miscWidgetsDescription,
              icon: Icons.widgets,
              onTap: () => context.router.push(const MiscWidgetsExampleRoute()),
            ),
            const Divider(height: 48),
            Text(
              localizer.aboutUIKit,
              style: textStyles.mediumTitle18,
            ),
            const SizedBox(height: 16),
            Text(
              localizer.uiKitDescription,
              style: textStyles.regularBody14,
            ),
          ],
        ),
      ),
    );
  }
}
