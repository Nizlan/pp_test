import '../../../domain/entities/user_auth_data.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData(String email, String password);
  Future<UserAuthData> getAuthData();
}
