/// Defines how the HTTP response should be parsed and returned.
enum ApiResponseType {
  /// Parse response as JSON and deserialize to type [T].
  ///
  /// Use with a fromJson factory function to convert JSON to model.
  /// Example: `client.get<User>('/profile', fromJson: User.fromJson)`
  json,

  /// Return the raw [Response] object from Dio.
  ///
  /// Useful when you need access to headers, status code, or other metadata.
  /// Example: `client.get<Response>('/profile', responseType: ResponseType.fullResponse)`
  fullResponse,

  /// Return response body as plain text [String].
  ///
  /// Use for non-JSON responses like HTML, XML, or plain text.
  /// Example: `client.get<String>('/healthcheck', responseType: ResponseType.plain)`
  plain,

  /// Return response body as raw bytes [List<int>].
  ///
  /// Use for binary data like images, PDFs, or file downloads.
  /// Example: `client.get<List<int>>('/download', responseType: ResponseType.bytes)`
  bytes,

  /// Return response body as a [Stream<List<int>>].
  ///
  /// Use for streaming large files or real-time data.
  /// Example: `client.get<Stream<List<int>>>('/video', responseType: ResponseType.stream)`
  stream,
}
