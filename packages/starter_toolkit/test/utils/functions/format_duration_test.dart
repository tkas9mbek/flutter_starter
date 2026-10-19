import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/functions/format_duration.dart';

import '../../support/pump_localized.dart';

void main() {
  testWidgets('shows minutes only below an hour', (tester) async {
    final context = await tester.pumpLocalizedContext();

    expect(formatDuration(context, const Duration(minutes: 45)), '45 min');
    expect(formatDuration(context, const Duration(seconds: 59)), '0 min');
  });

  testWidgets('shows hours and the remaining minutes from an hour on', (
    tester,
  ) async {
    final context = await tester.pumpLocalizedContext(
      locale: const Locale('ru'),
    );

    expect(
      formatDuration(context, const Duration(hours: 2, minutes: 5)),
      '2 ч. 5 мин.',
    );
    expect(formatDuration(context, const Duration(hours: 1)), '1 ч. 0 мин.');
  });
}
