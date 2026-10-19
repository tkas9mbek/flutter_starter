import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

extension PumpLocalizedX on WidgetTester {
  /// Pumps a bare [Localizations] scope with [ToolkitLocalizer] for [locale]
  /// and returns a context below it, for helpers that take a [BuildContext].
  Future<BuildContext> pumpLocalizedContext({
    Locale locale = const Locale('en'),
  }) async {
    late BuildContext captured;

    await pumpWidget(
      Localizations(
        locale: locale,
        delegates: const [
          ToolkitLocalizer.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            captured = context;

            return const SizedBox.shrink();
          },
        ),
      ),
    );
    await pumpAndSettle();

    return captured;
  }
}
