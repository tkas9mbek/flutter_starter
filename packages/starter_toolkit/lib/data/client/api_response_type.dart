/// Defines how the HTTP response should be parsed and returned.
enum ApiResponseType {
  /// Parse the response as JSON and deserialize to type [T].
  json,

  /// Return the raw Dio [Response], exposing headers, status code and metadata.
  fullResponse,

  /// Return the response body as plain text (HTML, XML, etc.).
  plain,

  /// Return the response body as raw bytes (images, PDFs, downloads).
  bytes,

  /// Return the response body as a byte stream for large or real-time data.
  stream,
}
