import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:login_app/features/login/data/data_source/firebase_auth_datasource.dart';
import 'package:login_app/features/login/data/repositories/auth_repository_impl.dart';
import 'package:login_app/features/login/domain/usecases/sign_in_usecase.dart';
import 'package:login_app/features/login/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;
void initDI() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(),
  );

  getIt.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(getIt<FirebaseAuthDataSource>()),
  );

  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<SignInUseCase>(), getIt<AuthRepositoryImpl>()),
  );
}
