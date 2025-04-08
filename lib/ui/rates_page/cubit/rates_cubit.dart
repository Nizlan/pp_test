import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/currencies_repo/currencies_repo.dart';
import '../../../domain/entities/currency.dart';

part 'rates_state.dart';

class RatesCubit extends Cubit<RatesState> {
  final CurrenciesRepo currenciesRepo;
  RatesCubit({required this.currenciesRepo}) : super(RatesInitial());

  Timer? _timer;

  setUpdatesTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      updateRates();
    });
  }

  void init() {
    _fetchRates();
    setUpdatesTimer();
  }

  Future<void> _fetchRates() async {
    emit(RatesLoading());
    final rates = await currenciesRepo.getAllCurrencies();
    emit(RatesLoaded(rates: rates));
  }

  Future<void> updateRates() async {
    final rates = await currenciesRepo.getAllCurrencies();

    emit(RatesLoaded(rates: rates));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
