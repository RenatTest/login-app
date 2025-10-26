import 'package:login_app/features/login/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn(String email, String password);
  Future<void> signOut();
  Stream<UserEntity?> get user;
}
