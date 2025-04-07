import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_auth_data_dto/user_auth_data_dto.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceSharedPref extends AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceSharedPref({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<UserAuthDataDto?> getAuthData() async {
    final json = _sharedPreferences.getString('auth_data');
    if (json == null) {
      return null;
    }
    return UserAuthDataDto.fromJson(json);
  }

  @override
  Future<void> saveAuthData(String email, String password) async {
    final userAuthData = UserAuthDataDto(email: email, password: password);
    await _sharedPreferences.setString('auth_data', userAuthData.toJson());
  }

  @override
  Future<void> signOut() async {
    await _sharedPreferences.remove('auth_data');
  }
}
