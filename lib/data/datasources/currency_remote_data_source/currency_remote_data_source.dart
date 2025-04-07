import '../../models/currency_dto/currency_dto.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CurrencyDto>> fetchAllCurrenciesFromApi();
}
