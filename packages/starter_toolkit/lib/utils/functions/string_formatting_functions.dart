/// Returns [input] with its first character upper-cased.
///
/// Returns an empty string for `null` or empty input.
String capitalizeFirstLetter(String? input) {
  if (input == null || input.isEmpty) {
    return '';
  }

  return input[0].toUpperCase() + input.substring(1);
}

/// Removes whitespace and non-word symbols from [input].
String removeSpaceAndSymbols(String input) =>
    input.replaceAll(RegExp(r'\s+|[^\w\s]'), '');

/// Strips display formatting (spaces, parens, dashes) from a phone number.
String cleanPhoneNumber(String input) =>
    input.replaceAll(RegExp(r'[\s\(\)\-]'), '');
