import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/features/login/domain/repositories/auth_repository.dart';
import 'package:login_app/features/login/domain/usecases/sign_in_usecase.dart';
import 'package:login_app/features/login/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final AuthRepository authRepository;

  AuthCubit(this.signInUseCase, this.authRepository) : super(AuthState()) {
    authRepository.user.listen((user) => emit(state.copyWith(user: user)));
  }

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(loading: true));
    try {
      final user = await signInUseCase(email, password);
      emit(state.copyWith(loading: false, user: user));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(state.copyWith(user: null));
  }
}
