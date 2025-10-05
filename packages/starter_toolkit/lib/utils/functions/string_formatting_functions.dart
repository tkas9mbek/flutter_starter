String capitalizeFirstLetter(String? input) {
  if (input == null || input.isEmpty) {
    return '';
  }

  return input[0].toUpperCase() + input.substring(1);
}

String removeSpaceAndSymbols(String input) {
  return input.replaceAll(RegExp(r'\s+|[^\w\s]'), '');
}

String cleanPhoneNumber(String input) {
  return input.replaceAll(RegExp(r'[\s\(\)\-]'), '');
}
