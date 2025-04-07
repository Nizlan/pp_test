import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/currencies_repo/currencies_repo.dart';
import '../../../domain/entities/currency.dart';

part 'rates_page_state.dart';

class RatesPageCubit extends Cubit<RatesPageState> {
  final CurrenciesRepo currenciesRepo;
  RatesPageCubit({required this.currenciesRepo}) : super(RatesPageInitial());

  Future<void> fetchRates() async {
    emit(RatesPageLoading());
    final rates = await currenciesRepo.getAllCurrencies();
    emit(RatesPageLoaded(rates: rates));
  }
}
