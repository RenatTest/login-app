import 'package:login_app/core/network/login_register_api/login_register_api_base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRegisterApiFirebase implements LoginRegisterApiBase {
  @override
  Future<void> loginRegister({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (exception) {
      try {
        if (exception.code == 'email-already-in-use') {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        }
      } catch (error) {
        throw CustomServerError(
          errorMessage: 'Login error: ${error.toString()}',
        );
      }
    } catch (error) {
      throw CustomServerError(
        errorMessage: 'Register error: ${error.toString()}',
      );
    }
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class CustomServerError implements Exception {
  CustomServerError({required this.errorMessage});

  final String errorMessage;

  @override
  String toString() => 'CustomServerError: $errorMessage';
}
