part of 'rates_page_cubit.dart';

@immutable
sealed class RatesPageState {}

final class RatesPageInitial extends RatesPageState {}

final class RatesPageLoading extends RatesPageState {}

final class RatesPageLoaded extends RatesPageState {
  final List<Currency> rates;
  RatesPageLoaded({required this.rates});
}
