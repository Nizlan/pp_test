import '../../../domain/entities/user.dart';

abstract class AuthRepo {
  Future<String?> tryLogin(String email, String password);
  Future<void> signOut();
  User? getCurrentUser();
}
