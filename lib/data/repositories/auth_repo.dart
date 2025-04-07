import '../../domain/entities/user.dart';

abstract class AuthRepo {
  Future<bool> tryLogin(String email, String password);
  Future<void> signOut();
  Future<User> getCurrentUser();
  Stream<User?> getCurrentUserStream();
}
