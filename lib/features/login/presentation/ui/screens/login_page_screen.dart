import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_app/features/app/page_names.dart';

class LoginPageScreen extends StatelessWidget {
  const LoginPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Login Page', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed(ScreenNames.homePage),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(width: 2.0, color: Colors.white),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
