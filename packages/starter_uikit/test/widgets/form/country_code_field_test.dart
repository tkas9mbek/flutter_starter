import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/country/country_code.dart';
import 'package:starter_uikit/widgets/form/country/country_code_field.dart';

import '../../support/pump_app.dart';

void main() {
  const kg = CountryCode(name: 'Kyrgyzstan', dialCode: '+996', flag: 'KG');
  const kz = CountryCode(name: 'Kazakhstan', dialCode: '+7', flag: 'KZ');

  group('CountryCodeField', () {
    testWidgets('shows the selected dial code and reports the picked one', (
      tester,
    ) async {
      final picked = <CountryCode>[];

      await tester.pumpApp(
        CountryCodeField(
          countries: const [kg, kz],
          selected: kg,
          onChanged: picked.add,
        ),
      );

      expect(find.text('+996'), findsOneWidget);

      await tester.tap(find.text('+996'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Kazakhstan'));
      await tester.pumpAndSettle();

      expect(picked, [kz]);
    });
  });
}
