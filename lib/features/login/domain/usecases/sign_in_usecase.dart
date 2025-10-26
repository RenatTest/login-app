import 'package:login_app/features/login/domain/entities/user_entity.dart';
import 'package:login_app/features/login/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity?> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
