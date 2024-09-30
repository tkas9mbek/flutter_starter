enum LoadState {
  initial,
  loading,
  loaded,
  failure;

  bool get isLoading => this == LoadState.loading;
}
