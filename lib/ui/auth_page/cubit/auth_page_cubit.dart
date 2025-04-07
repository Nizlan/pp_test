import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_page_state.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  AuthPageCubit() : super(AuthPageInitial());
}
