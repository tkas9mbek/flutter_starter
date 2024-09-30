enum OperationState {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == OperationState.loading;
}
