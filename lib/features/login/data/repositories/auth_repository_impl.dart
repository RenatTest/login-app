import 'package:login_app/features/login/data/data_source/firebase_auth_datasource.dart';
import 'package:login_app/features/login/domain/entities/user_entity.dart';
import 'package:login_app/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    final firebaseUser = await dataSource.signIn(email, password);
    if (firebaseUser != null) {
      final token = await firebaseUser.getIdToken();
      return UserEntity(token: token, email: firebaseUser.email);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }

  @override
  Stream<UserEntity?> get user {
    return dataSource.user.asyncMap((firebaseUser) async {
      if (firebaseUser != null) {
        final token = await firebaseUser.getIdToken();
        return UserEntity(token: token, email: firebaseUser.email);
      }
      return null;
    });
  }
}
