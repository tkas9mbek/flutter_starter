import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/bloc/refreshable_bloc.dart';

class _Refreshable with RefreshableBloc {}

void main() {
  test('refreshing updates the flag and broadcasts each change', () async {
    final bloc = _Refreshable();
    final emitted = <bool>[];
    final subscription = bloc.refreshingStream.listen(emitted.add);

    expect(bloc.refreshing, isFalse);

    bloc.refreshing = true;
    expect(bloc.refreshing, isTrue);
    bloc.refreshing = false;
    await Future<void>.delayed(Duration.zero);

    expect(emitted, [true, false]);

    await subscription.cancel();
    bloc.dispose();
  });

  test('dispose closes the stream for waiting listeners', () async {
    final bloc = _Refreshable();
    final done = bloc.refreshingStream.toList();

    bloc.dispose();

    expect(await done, isEmpty);
  });
}
