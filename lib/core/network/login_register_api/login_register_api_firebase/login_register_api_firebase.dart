import 'package:login_app/core/network/login_register_api/login_register_api_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/core/storage/secure_storage/secure_storage.dart';

class LoginRegisterApiFirebase implements LoginRegisterApiBase {
  @override
  Future<void> loginRegister({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        String? token = await user.getIdToken();
        await SecureStorage.instance.saveToken(token);
      }
      await SecureStorage.instance.saveUserEmail(email);
    } on FirebaseAuthException catch (exception) {
      try {
        if (exception.code == 'email-already-in-use') {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          User? user = userCredential.user;
          if (user != null) {
            String? token = await user.getIdToken();
            await SecureStorage.instance.saveToken(token);
          }
          await SecureStorage.instance.saveUserEmail(email);
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
