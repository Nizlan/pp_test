part of 'rates_cubit.dart';

@immutable
sealed class RatesState extends Equatable {
  final String? error;

  RatesState copyWith({String? error});

  const RatesState({this.error});
}

final class RatesInitial extends RatesState {
  const RatesInitial({super.error});
  @override
  List<Object?> get props => [error];

  @override
  RatesInitial copyWith({String? error}) {
    return RatesInitial(error: error ?? this.error);
  }
}

final class RatesLoading extends RatesState {
  const RatesLoading({super.error});
  @override
  List<Object?> get props => [error];

  @override
  RatesLoading copyWith({String? error}) {
    return RatesLoading(error: error ?? this.error);
  }
}

final class RatesLoaded extends RatesState {
  final List<Currency> rates;
  const RatesLoaded({required this.rates, super.error});

  @override
  List<Object?> get props => [rates, error];

  @override
  RatesLoaded copyWith({String? error, List<Currency>? rates}) {
    return RatesLoaded(rates: rates ?? this.rates, error: error ?? this.error);
  }
}
