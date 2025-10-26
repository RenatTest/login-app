import 'package:login_app/features/login/domain/entities/user_entity.dart';

class AuthState {
  final bool loading;
  final UserEntity? user;
  final String? error;

  AuthState({this.loading = false, this.user, this.error});

  AuthState copyWith({bool? loading, UserEntity? user, String? error}) {
    return AuthState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      error: error,
    );
  }
}
