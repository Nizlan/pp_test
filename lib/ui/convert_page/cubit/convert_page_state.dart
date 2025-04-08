part of 'convert_page_cubit.dart';

@immutable
sealed class ConvertPageState {}

final class ConvertPageInitial extends ConvertPageState {}

final class ConvertPageLoaded extends ConvertPageState {
  final Currency fromCurrency;
  final Currency toCurrency;
  final String amount;
  final String result;
  final String resultWithCommission;

  ConvertPageLoaded({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.result,
    required this.resultWithCommission,
  });

  ConvertPageLoaded copyWith({
    Currency? fromCurrency,
    Currency? toCurrency,
    String? amount,
    String? result,
    String? resultWithCommission,
  }) {
    return ConvertPageLoaded(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      result: result ?? this.result,
      resultWithCommission: resultWithCommission ?? this.resultWithCommission,
    );
  }
}
