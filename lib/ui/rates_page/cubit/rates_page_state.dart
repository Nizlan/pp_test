part of 'rates_page_cubit.dart';

@immutable
sealed class RatesPageState extends Equatable {}

final class RatesPageInitial extends RatesPageState {
  @override
  List<Object?> get props => [];
}

final class RatesPageLoading extends RatesPageState {
  @override
  List<Object?> get props => [];
}

final class RatesPageLoaded extends RatesPageState {
  final List<Currency> rates;
  RatesPageLoaded({required this.rates});

  @override
  List<Object?> get props => [rates];
}
