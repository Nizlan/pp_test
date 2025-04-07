import '../../../domain/entities/user.dart';
import '../../datasources/auth_local_data_source/auth_local_data_source.dart';
import '../../datasources/auth_remote_data_source/auth_remote_data_source.dart';
import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  User? _user;

  AuthRepoImpl({
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
  });

  @override
  Future<String?> tryLogin(String email, String password) async {
    final result = await authRemoteDataSource.tryLogin(email, password);
    if (result != null) {
      _user = User(email: email);
    }
    return result;
  }

  @override
  Future<void> signOut() async {
    await authLocalDataSource.signOut();
    _user = null;
  }

  @override
  User? getCurrentUser() {
    return _user;
  }
}
