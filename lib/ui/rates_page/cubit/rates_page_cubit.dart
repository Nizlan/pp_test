import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/currencies_repo/currencies_repo.dart';
import '../../../domain/entities/currency.dart';

part 'rates_page_state.dart';

class RatesPageCubit extends Cubit<RatesPageState> {
  final CurrenciesRepo currenciesRepo;
  RatesPageCubit({required this.currenciesRepo}) : super(RatesPageInitial());

  Timer? _timer;

  setUpdatesTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      updateRates();
    });
  }

  void init() {
    fetchRates();
    setUpdatesTimer();
  }

  Future<void> fetchRates() async {
    emit(RatesPageLoading());
    final rates = await currenciesRepo.getAllCurrencies();
    emit(RatesPageLoaded(rates: rates));
  }

  Future<void> updateRates() async {
    final rates = await currenciesRepo.getAllCurrencies();

    emit(RatesPageLoaded(rates: rates));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
