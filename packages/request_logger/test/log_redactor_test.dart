import 'package:flutter_test/flutter_test.dart';
import 'package:request_logger/interceptor/log_redactor.dart';

void main() {
  const redactor = LogRedactor(
    hiddenHeaders: ['Authorization'],
    hiddenFields: ['accessToken'],
  );

  group('headers', () {
    test(
      'hides a configured header and keeps the rest',
      () => expect(
        redactor.headers({'Authorization': 'Bearer abc', 'Accept': 'json'}),
        {'Authorization': 'Hidden', 'Accept': 'json'},
      ),
    );

    test(
      'matches header names case-sensitively',
      () => expect(redactor.headers({'authorization': 'Bearer abc'}), {
        'authorization': 'Bearer abc',
      }),
    );
  });

  group('fields', () {
    test('passes null through', () => expect(redactor.fields(null), isNull));

    test(
      'hides a configured query field',
      () => expect(redactor.fields({'accessToken': 'secret', 'page': 1}), {
        'accessToken': 'Hidden',
        'page': 1,
      }),
    );
  });

  group('body', () {
    test('hides fields in nested maps and in lists of maps', () {
      final body = redactor.body({
        'user': {'accessToken': 'nested-secret', 'name': 'John'},
        'sessions': [
          {'accessToken': 'list-secret', 'id': 1},
          'plain',
        ],
      });

      expect(body, {
        'user': {'accessToken': 'Hidden', 'name': 'John'},
        'sessions': [
          {'accessToken': 'Hidden', 'id': 1},
          'plain',
        ],
      });
    });

    test(
      'stringifies non-string map keys',
      () => expect(redactor.body({1: 'one'}), {'1': 'one'}),
    );

    test('leaves a non-Map body untouched', () {
      expect(redactor.body('accessToken=secret'), 'accessToken=secret');
      expect(redactor.body(null), isNull);
    });
  });
}
