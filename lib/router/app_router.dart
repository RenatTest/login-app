import 'package:go_router/go_router.dart';
import 'package:login_app/features/app/page_names.dart';
import 'package:login_app/features/login/presentation/ui/screens/login_page_screen.dart';
import 'package:login_app/features/profile/presentatuin/ui/screens/profile_page_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: ScreenNames.loginPage,
      builder: (context, state) => const LoginPageScreen(),
      routes: [
        GoRoute(
          path: 'profile-page',
          name: ScreenNames.profilePage,
          builder: (context, state) => const ProfilePageScreen(),
        ),
      ],
    ),
  ],
);
