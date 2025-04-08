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

  _setUpdatesTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      updateRates();
    });
  }

  void init() {
    _fetchRates();
    _setUpdatesTimer();
  }

  Future<void> _fetchRates() async {
    emit(RatesLoading());
    try {
      final rates = await currenciesRepo.getAllCurrencies();
      emit(RatesLoaded(rates: rates));
    } catch (e) {
      emit(RatesLoading(error: e.toString()));
    }
  }

  Future<void> updateRates() async {
    try {
      final rates = await currenciesRepo.getAllCurrencies();
      emit(RatesLoaded(rates: rates));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
