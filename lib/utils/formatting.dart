String formatCurrencyWith18Decimals(String value) {
  try {
    final parts = value.split('.');
    final integerPart = parts[0];

    if (parts.length == 1) {
      return '$integerPart.000000000000000000';
    }

    final decimalPart = parts[1];

    if (decimalPart.length < 18) {
      return '$integerPart.${decimalPart.padRight(18, '0')}';
    }

    return '$integerPart.${decimalPart.substring(0, 18)}';
  } catch (e) {
    print('Error formatting value "$value": $e');
    return '0.${'0' * 18}';
  }
}
