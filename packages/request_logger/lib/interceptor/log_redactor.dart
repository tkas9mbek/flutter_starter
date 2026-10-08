const _hiddenPlaceholder = 'Hidden';

/// Redacts configured header/field names to a placeholder before a captured
/// request ever reaches [HttpLogManager], so tokens never sit in memory.
final class LogRedactor {
  const LogRedactor({required this.hiddenHeaders, required this.hiddenFields});

  final List<String> hiddenHeaders;
  final List<String> hiddenFields;

  Map<String, dynamic> headers(Map<String, dynamic> headers) => {
    for (final entry in headers.entries)
      entry.key: hiddenHeaders.contains(entry.key)
          ? _hiddenPlaceholder
          : entry.value,
  };

  Map<String, dynamic>? fields(Map<String, dynamic>? fields) =>
      fields == null ? null : _redactMap(fields);

  dynamic body(dynamic body) => body is Map ? _redactMap(body) : body;

  Map<String, dynamic> _redactMap(Map<dynamic, dynamic> map) => {
    for (final entry in map.entries)
      entry.key.toString(): hiddenFields.contains(entry.key)
          ? _hiddenPlaceholder
          : switch (entry.value) {
              final Map value => _redactMap(value),
              final List value =>
                value.map((e) => e is Map ? _redactMap(e) : e).toList(),
              final value => value,
            },
  };
}
