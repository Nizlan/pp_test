import 'package:pp_test/data/models/user_auth_data_dto/user_auth_data_dto.dart';

import '../../models/user_dto/user_dto.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData(String email, String password);
  Future<UserAuthDataDto?> getAuthData();
  Future<UserDto?> getCurrentUser();
  Future<void> signOut();
}
