String capitalizeFirstLetter(String? input) {
  if (input == null || input.isEmpty) {
    return '';
  }

  return input[0].toUpperCase() + input.substring(1);
}
