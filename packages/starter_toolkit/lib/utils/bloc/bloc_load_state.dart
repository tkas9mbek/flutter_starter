enum BlocLoadState {
  initial,
  loading,
  loaded,
  failure;

  bool get isLoading => this == BlocLoadState.loading;
}
