part of 'rates_cubit.dart';

@immutable
sealed class RatesState extends Equatable {}

final class RatesInitial extends RatesState {
  @override
  List<Object?> get props => [];
}

final class RatesLoading extends RatesState {
  @override
  List<Object?> get props => [];
}

final class RatesLoaded extends RatesState {
  final List<Currency> rates;
  RatesLoaded({required this.rates});

  @override
  List<Object?> get props => [rates];
}
