/// Returns [input] with its first character upper-cased.
///
/// Returns an empty string for `null` or empty input.
String capitalizeFirstLetter(String? input) {
  if (input == null || input.isEmpty) {
    return '';
  }

  return input[0].toUpperCase() + input.substring(1);
}
