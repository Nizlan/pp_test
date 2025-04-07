class Currency {
  final String id;
  final String symbol;
  final String? currencySymbol;
  final String type;
  final String rateUsd;

  Currency({
    required this.id,
    required this.symbol,
    required this.currencySymbol,
    required this.type,
    required this.rateUsd,
  });
}
