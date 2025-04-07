import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rates_page_state.dart';

class RatesPageCubit extends Cubit<RatesPageState> {
  RatesPageCubit() : super(RatesPageInitial());
}
