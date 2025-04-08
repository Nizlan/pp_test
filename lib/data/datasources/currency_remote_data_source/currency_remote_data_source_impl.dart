// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import '../../models/currency_dto/currency_dto.dart';
// import 'currency_remote_data_source.dart';

// class CurrencyRemoteDataSourceImpl extends CurrencyRemoteDataSource {
//   @override
//   Future<List<CurrencyDto>> fetchAllCurrenciesFromApi() async {
//     final response = await Dio().get(
//       'https://rest.coincap.io/v3/rates',
//       queryParameters: {'apiKey': dotenv.env['API_KEY']},
//     );
//     final data = response.data['data'];
//     final List<CurrencyDto> currencies =
//         data.map((e) => CurrencyDto.fromJson(e)).toList().cast<CurrencyDto>();
//     return currencies;
//   }
// }
