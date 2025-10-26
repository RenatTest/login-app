import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_app/features/app/page_names.dart';
import 'package:login_app/features/login/presentation/cubit/auth_cubit.dart';
import 'package:login_app/features/login/presentation/ui/screens/login_page_screen.dart';
import 'package:login_app/features/home/presentatuin/ui/screens/home_page_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  // redirect: (context, state) {
  //   final token = context.read<AuthCubit>().state.user?.token;

  //   if (token == null && state.matchedLocation != '/') {
  //     return '/'; // переходимо на login
  //   }

  //   if (token != null && state.matchedLocation == '/') {
  //     return '/home-page'; // переходимо на home
  //   }

  //   return null; // залишаємо поточний маршрут
  // },
  // redirect: (context, state) {
  //   final cubit = BlocProvider.of<AuthCubit>(context);
  //   final token = cubit.state.user?.token;

  //   if (token == null) {
  //     return '/';
  //   }

  //   // if (token == null && state.matchedLocation == '/home-page') {
  //   //   return '/';
  //   // }

  //   // if (token != null && state.matchedLocation == '/') {
  //   //   return '/home-page';
  //   // }

  //   return null;
  // },
  routes: [
    GoRoute(
      path: '/',
      name: ScreenNames.loginPage,
      builder: (context, state) => const LoginPageScreen(),
    ),
    GoRoute(
      path: '/home-page',
      name: ScreenNames.homePage,
      builder: (context, state) => const HomePageScreen(),
    ),
  ],
);
