import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/auth_repo/auth_repo.dart';

part 'auth_page_state.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  AuthPageCubit(this.authRepository) : super(AuthPageInitial());

  final AuthRepo authRepository;

  void tryLogin(String email, String password) async {
    emit(AuthPageLoading());
    final result = await authRepository.tryLogin(email, password);
    if (result == null) {
      emit(AuthPageSuccess());
    } else {
      emit(AuthPageError(result));
    }
  }
}
