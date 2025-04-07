import 'package:pp_test/data/models/user_auth_data_dto/user_auth_data_dto.dart';

import '../../../domain/entities/user_auth_data.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData(String email, String password);
  Future<UserAuthDataDto?> getAuthData();
  Future<void> signOut();
}
