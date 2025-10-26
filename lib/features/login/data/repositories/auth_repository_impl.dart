import 'package:login_app/features/login/data/data_source/firebase_auth_datasource.dart';
import 'package:login_app/features/login/domain/entities/user_entity.dart';
import 'package:login_app/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> signIn(String email, String password) {
    return dataSource.signIn(email, password);
  }

  @override
  Future<void> signOut() => dataSource.signOut();

  @override
  Stream<UserEntity?> get user => dataSource.user;
}
