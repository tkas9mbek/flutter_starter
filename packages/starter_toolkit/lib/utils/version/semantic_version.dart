import 'dart:math';

/// Parses and compares dotted numeric version strings such as `1.4.2`.
///
/// Segments are compared numerically, left to right. Non-numeric segments
/// and missing trailing segments are treated as `0`, so `1.2` and `1.2.0`
/// compare equal and `1.0.10` is greater than `1.0.9`.
class SemanticVersion implements Comparable<SemanticVersion> {
  const SemanticVersion(this.segments);

  factory SemanticVersion.parse(String value) {
    final segments = value
        .trim()
        .split('.')
        .map((segment) => int.tryParse(segment.trim()) ?? 0)
        .toList(growable: false);

    return SemanticVersion(segments);
  }

  final List<int> segments;

  /// Whether this version is strictly older than [other].
  bool isBelow(SemanticVersion other) => compareTo(other) < 0;

  /// Whether this version is the same as or newer than [other].
  bool isAtLeast(SemanticVersion other) => compareTo(other) >= 0;

  @override
  int compareTo(SemanticVersion other) {
    final length = max(segments.length, other.segments.length);

    for (var index = 0; index < length; index++) {
      final left = index < segments.length ? segments[index] : 0;
      final right = index < other.segments.length ? other.segments[index] : 0;

      if (left != right) {
        return left.compareTo(right);
      }
    }

    return 0;
  }
}
