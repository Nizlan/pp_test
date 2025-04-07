import '../../../domain/entities/currency.dart';
import 'currencies_repo.dart';
import '../../datasources/currency_remote_data_source/currency_remote_data_source.dart';

class CurrenciesRepoImpl extends CurrenciesRepo {
  final CurrencyRemoteDataSource _currencyRemoteDataSource;

  CurrenciesRepoImpl({
    required CurrencyRemoteDataSource currencyRemoteDataSource,
  }) : _currencyRemoteDataSource = currencyRemoteDataSource;

  @override
  Future<List<Currency>> getAllCurrencies() async {
    final currencies =
        await _currencyRemoteDataSource.fetchAllCurrenciesFromApi();
    return currencies;
  }

  @override
  Future<String> convertCurrency(Currency from, Currency to, String amount) {
    // TODO: implement convertCurrency
    throw UnimplementedError();
  }
}
