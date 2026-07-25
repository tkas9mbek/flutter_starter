/// Load lifecycle of a BLoC: initial, loading, loaded or failure.
enum BlocLoadState {
  initial,
  loading,
  loaded,
  failure;

  bool get isLoading => this == BlocLoadState.loading;
}
