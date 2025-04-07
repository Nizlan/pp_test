abstract class AuthRemoteDataSource {
  Future<bool> tryLogin(String email, String password);
}
