import 'package:go_router/go_router.dart';
import 'package:login_app/features/app/page_names.dart';
import 'package:login_app/features/login/presentation/ui/screens/login_page_screen.dart';
import 'package:login_app/features/home/presentatuin/ui/screens/home_page_screen.dart';

final router = GoRouter(
  initialLocation: '/',
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
