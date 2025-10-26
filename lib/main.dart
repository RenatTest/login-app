import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/features/login/data/data_source/firebase_auth_datasource.dart';
import 'package:login_app/features/login/data/repositories/auth_repository_impl.dart';
import 'package:login_app/features/login/domain/usecases/sign_in_usecase.dart';
import 'package:login_app/features/login/presentation/cubit/auth_cubit.dart';
import 'package:login_app/router/app_router.dart';
import 'package:login_app/utils/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final dataSource = FirebaseAuthDataSource();
  final repository = AuthRepositoryImpl(dataSource);
  final signInUseCase = SignInUseCase(repository);

  runApp(MyApp(repository: repository, signInUseCase: signInUseCase));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.repository,
    required this.signInUseCase,
  });

  final AuthRepositoryImpl repository;
  final SignInUseCase signInUseCase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(signInUseCase, repository),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
