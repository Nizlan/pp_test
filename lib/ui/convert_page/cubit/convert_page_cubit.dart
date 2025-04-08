import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/currency.dart';

part 'convert_page_state.dart';

class ConvertPageCubit extends Cubit<ConvertPageState> {
  ConvertPageCubit() : super(ConvertPageInitial());

  static const _initFromCurrency = 'BTC';
  static const _initToCurrency = 'RUB';
  static const _initAmount = '1';
  static final _commissionPercent = Decimal.parse('1.03');

  void init(List<Currency> currencies) {
    final (String result, String resultWithCommission) = convert(
      _initAmount,
      currencies.firstWhere((c) => c.symbol == _initFromCurrency),
      currencies.firstWhere((c) => c.symbol == _initToCurrency),
    );
    emit(
      ConvertPageLoaded(
        fromCurrency: currencies.firstWhere(
          (c) => c.symbol == _initFromCurrency,
        ),
        toCurrency: currencies.firstWhere((c) => c.symbol == _initToCurrency),
        amount: '1',
        result: result,
        resultWithCommission: resultWithCommission,
      ),
    );
  }

  void updateAmount({
    required String amount,
    required Currency fromCurrency,
    required Currency toCurrency,
  }) {
    final (String result, String resultWithCommission) = convert(
      amount,
      fromCurrency,
      toCurrency,
    );
    final currentState = state as ConvertPageLoaded;
    emit(
      currentState.copyWith(
        result: result,
        resultWithCommission: resultWithCommission,
        amount: amount,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      ),
    );
  }

  (String result, String resultWithCommission) convert(
    String amount,
    Currency fromCurrency,
    Currency toCurrency,
  ) {
    final amountDecimal = Decimal.parse(amount);
    final fromRate = Decimal.parse(fromCurrency.rateUsd);
    final toRate = Decimal.parse(toCurrency.rateUsd);

    final resultDecimal = ((amountDecimal * fromRate) / toRate).toDecimal(
      scaleOnInfinitePrecision: 18,
    );
    final resultWithCommissionDecimal = resultDecimal * _commissionPercent;

    bool fiat = toCurrency.type == 'fiat';
    final int scale = fiat ? 2 : 18;

    final roundedResult = resultDecimal.floor(scale: scale);
    final roundedResultWithCommission = resultWithCommissionDecimal.floor(
      scale: scale,
    );

    return (
      roundedResult.toStringAsFixed(scale),
      roundedResultWithCommission.toStringAsFixed(scale),
    );
  }
}
