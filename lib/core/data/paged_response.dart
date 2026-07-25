/// Shared shape for Spring Data `Page<T>` responses.
///
/// The backend serializes `PageImpl` directly (legacy format). Only the fields
/// the client actually needs are modeled here; deserialize the `content[]`
/// elements with the item's own `fromJson`.
///
/// ```dart
/// final page = await client.requestJson<PagedResponse<Task>>(
///   method: HttpMethod.get,
///   path: '/tasks',
///   queryParameters: query,
///   fromJson: (json) => PagedResponse.fromJson(json, Task.fromJson),
/// );
/// ```
class PagedResponse<T> {
  const PagedResponse({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.number,
    required this.size,
    required this.first,
    required this.last,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final rawContent = (json['content'] as List<dynamic>? ?? <dynamic>[])
        .map((item) => fromJsonT(item as Map<String, dynamic>))
        .toList();

    return PagedResponse<T>(
      content: rawContent,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      number: (json['number'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? rawContent.length,
      first: json['first'] as bool? ?? true,
      last: json['last'] as bool? ?? true,
    );
  }

  final List<T> content;

  /// Elements across all pages, not just this one.
  final int totalElements;

  final int totalPages;

  /// Current page number — zero-based, matching Spring's `page` parameter.
  final int number;

  final int size;
  final bool first;
  final bool last;
}
