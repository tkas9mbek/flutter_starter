import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/widgets/form/country/country_code.dart';

void main() => group('CountryCode', () {
  test('equality is by name and dial code, ignoring the flag', () {
    const kg = CountryCode(name: 'Kyrgyzstan', dialCode: '+996', flag: 'KG');
    const sameWithOtherFlag = CountryCode(
      name: 'Kyrgyzstan',
      dialCode: '+996',
      flag: 'kg',
    );

    expect(kg, sameWithOtherFlag);
    expect(kg.hashCode, sameWithOtherFlag.hashCode);
  });

  test('countries sharing a dial code stay distinct by name', () {
    const kz = CountryCode(name: 'Kazakhstan', dialCode: '+7', flag: 'KZ');
    const ru = CountryCode(name: 'Russia', dialCode: '+7', flag: 'RU');

    expect(kz, isNot(ru));
    expect({kz, ru}, hasLength(2));
  });
});
