abstract class AuthRemoteDataSource {
  Future<String?> tryLogin(String email, String password);
}
