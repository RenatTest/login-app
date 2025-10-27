import 'package:go_router/go_router.dart';
import 'package:login_app/core/storage/secure_storage/secure_storage.dart';
import 'package:login_app/features/app/page_names.dart';
import 'package:login_app/features/login/presentation/ui/screens/login_page_screen.dart';
import 'package:login_app/features/home/presentatuin/ui/screens/home_page_screen.dart';

final router = GoRouter(
  redirect: (context, state) async {
    final token = await SecureStorage.instance.getToken();

    if (token == '' && state.matchedLocation != '/') {
      return '/';
    }

    if (token != '' && state.matchedLocation == '/') {
      return '/home-page';
    }

    return null;
  },
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
