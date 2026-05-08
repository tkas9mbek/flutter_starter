/// Default option label that delegates to [Object.toString].
///
/// Suitable when the option type already has a meaningful `toString` —
/// e.g. enums.
String defaultOptionLabelBuilder(Object value) => value.toString();
