import 'package:pp_test/domain/entities/user_auth_data.dart';

import 'auth_remote_data_source.dart';

final _savedUsers = [UserAuthData(email: "demo", password: "demo")];

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<String?> tryLogin(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_savedUsers.any(
      (user) => user.email == email && user.password == password,
    )) {
      return null;
    }
    return "Invalid email or password";
  }
}
