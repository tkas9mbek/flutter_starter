import 'package:flutter_test/flutter_test.dart';
import 'package:starter/core/notifications/model/push_message.dart';
import 'package:starter/core/notifications/push_navigation_resolver.dart';

void main() {
  const message = PushMessage(data: {'taskId': '42'}, wasOpened: true);

  test('forwards a resolved message to the assigned handler', () {
    final resolver = PushNavigationResolver();
    final received = <PushMessage>[];
    resolver
      ..onOpened = received.add
      ..resolve(message);

    expect(received, [message]);
  });

  test('ignores a message while no handler is assigned', () {
    final resolver = PushNavigationResolver();
    final received = <PushMessage>[];
    resolver
      ..onOpened = received.add
      ..onOpened = null;

    expect(() => resolver.resolve(message), returnsNormally);
    expect(received, isEmpty);
  });
}
