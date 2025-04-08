import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageInitial(0));

  void onItemTapped(int index) {
    emit(MainPageInitial(index));
  }

  void onLoggedOut() {
    emit(MainPageLoggedOut(state.selectedIndex));
  }
}
