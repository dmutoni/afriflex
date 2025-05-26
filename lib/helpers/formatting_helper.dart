String formatNumberWithSuffix(
  num value, {
  required num max,
  int decimalPlaces = 1,
  String? prefix,
}) {
  // Return unformatted number with currency if below max
  if (value.abs() < max) {
    final formatted = value.toStringAsFixed(value is int ? 0 : decimalPlaces);
    return prefix != null ? '$prefix $formatted' : formatted;
  }

  // Define suffixes and their thresholds
  const suffixes = [
    {'suffix': 'k', 'divisor': 1e3}, // Thousand
    {'suffix': 'M', 'divisor': 1e6}, // Million
    {'suffix': 'B', 'divisor': 1e9}, // Billion
    {'suffix': 'T', 'divisor': 1e12}, // Trillion
  ];

  // Find appropriate suffix
  for (var i = suffixes.length - 1; i >= 0; i--) {
    final divisor = suffixes[i]['divisor'] as double;
    if (value.abs() >= divisor) {
      final formatted = (value / divisor).toStringAsFixed(decimalPlaces);
      final result = formatted.endsWith('.0') ? formatted.substring(0, formatted.length - 2) : formatted;
      return prefix != null
          ? '$prefix $result${suffixes[i]['suffix']}'
          : '$result${suffixes[i]['suffix']}';
    }
  }

  // Fallback for numbers below 1000
  final formatted = value.toStringAsFixed(value is int ? 0 : decimalPlaces);
  return prefix != null ? '$prefix $formatted' : formatted;
}