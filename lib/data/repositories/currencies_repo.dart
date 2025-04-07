import '../../domain/entities/currency.dart';

abstract class CurrenciesRepo {
  Future<List<Currency>> getAllCurrencies();
  Future<String> convertCurrency(Currency from, Currency to, String amount);
}
