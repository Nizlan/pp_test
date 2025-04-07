import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'convert_page_state.dart';

class ConvertPageCubit extends Cubit<ConvertPageState> {
  ConvertPageCubit() : super(ConvertPageInitial());
}
