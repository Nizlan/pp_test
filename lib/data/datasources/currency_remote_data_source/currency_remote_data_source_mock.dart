import 'dart:math';

import 'package:pp_test/data/datasources/currency_remote_data_source/mock_currencies_list.dart';
import 'package:pp_test/data/models/currency_dto/currency_dto.dart';

import 'currency_remote_data_source.dart';

class CurrencyRemoteDataSourceMock extends CurrencyRemoteDataSource {
  @override
  Future<List<CurrencyDto>> fetchAllCurrenciesFromApi() async {
    await Future.delayed(const Duration(seconds: 1));
    final List<dynamic> currenciesData = mockList["data"] as List<dynamic>;
    final currencies =
        currenciesData.map((e) => CurrencyDto.fromJson(e)).toList();
    final modifiedCurrencies =
        currencies.map((e) {
          final currentRate = double.parse(e.rateUsd);
          final modifiedRate =
              currentRate * (1 + (Random().nextDouble() * 0.05));
          return e.copyWith(rateUsd: modifiedRate.toString());
        }).toList();
    return modifiedCurrencies;
  }
}
