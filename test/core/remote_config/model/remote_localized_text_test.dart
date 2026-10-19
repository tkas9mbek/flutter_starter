import 'package:flutter_test/flutter_test.dart';
import 'package:starter/core/remote_config/model/remote_localized_text.dart';

void main() {
  const cases = <String, (Map<String, String>, String, String)>{
    'requested language': ({'en': 'EN', 'ru': 'RU', 'ky': 'KY'}, 'ky', 'KY'),
    'falls back to en': ({'en': 'EN', 'ru': 'RU'}, 'ky', 'EN'),
    'falls back to ru without en': ({'ru': 'RU', 'kk': 'KK'}, 'ky', 'RU'),
    'falls back to the first value': ({'kk': 'KK'}, 'ky', 'KK'),
    'empty without translations': ({}, 'ky', ''),
  };

  cases.forEach(
    (name, testCase) => test('resolve: $name', () {
      final (values, languageCode, expected) = testCase;

      expect(RemoteLocalizedText(values).resolve(languageCode), expected);
    }),
  );

  test('fromJson stringifies values and equality ignores key order', () {
    final text = RemoteLocalizedText.fromJson(const {'en': 'One', 'ru': 1});

    expect(text.values, {'en': 'One', 'ru': '1'});
    expect(text, const RemoteLocalizedText({'ru': '1', 'en': 'One'}));
    expect(
      text.hashCode,
      const RemoteLocalizedText({'ru': '1', 'en': 'One'}).hashCode,
    );
  });
}
