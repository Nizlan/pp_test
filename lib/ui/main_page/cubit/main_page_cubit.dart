import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/auth_repo/auth_repo.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  final AuthRepo authRepository;
  MainPageCubit(this.authRepository) : super(MainPageInitial(0));

  void onItemTapped(int index) {
    emit(MainPageInitial(index));
  }

  void onLoggedOut() async {
    await authRepository.signOut();
    emit(MainPageLoggedOut(state.selectedIndex));
  }
}
