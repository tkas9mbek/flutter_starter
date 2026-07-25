import 'dart:async';

/// Mixin that broadcasts a `refreshing` flag so UI (e.g. a pull-to-refresh
/// indicator) can wait for one or more BLoCs to finish reloading.
///
/// Set [refreshing] to `true` when a refresh starts and back to `false` when
/// the handler completes. Call [dispose] from the bloc's `close()` to release
/// the stream.
mixin RefreshableBloc {
  final StreamController<bool> _refreshingController =
      StreamController<bool>.broadcast();
  bool _refreshing = false;

  /// Current refreshing state.
  bool get refreshing => _refreshing;

  /// Stream of refreshing state changes.
  Stream<bool> get refreshingStream => _refreshingController.stream;

  set refreshing(bool value) {
    _refreshing = value;
    _refreshingController.add(value);
  }

  /// Closes the underlying stream controller.
  void dispose() => _refreshingController.close();
}
