/// Keyed, time-based cache collaborator for repository methods.
///
/// Injected into repositories that cache (a sibling of the repository's
/// executor), not part of the executor pipeline: caching needs a key per call
/// and holds cross-call state, so it does not fit `execute(fn)`.
abstract class RepositoryCache {
  const RepositoryCache();

  /// Returns the cached value for [key] if present and not expired;
  /// otherwise runs [fetch], stores the result for [ttl], and returns it.
  Future<T> getOrFetch<T>(
    Future<T> Function() fetch, {
    required String key,
    Duration? ttl,
  });

  /// Removes [key], or all entries when [key] is null.
  void invalidate([String? key]);
}
