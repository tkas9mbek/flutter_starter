import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';

void main() => test(
  'only the loading state reports isLoading',
  () => expect(BlocLoadState.values.where((state) => state.isLoading), [
    BlocLoadState.loading,
  ]),
);
