import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/core/storage/secure_storage/secure_storage.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        final token = await user.getIdToken();
        await SecureStorage.instance.saveToken(token);
        return userCredential.user;
      }
      return null;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'email-already-in-use') {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          final user = userCredential.user;
          if (user != null) {
            final token = await user.getIdToken();
            await SecureStorage.instance.saveToken(token);
            return userCredential.user;
          }
          return null;
        } on FirebaseAuthException catch (exception) {
          throw CustomServerError(
            errorMessage:
                'login: ${exception.code == 'invalid-credential' ? 'Wrong password' : exception.code}',
          );
        }
      } else {
        throw CustomServerError(errorMessage: 'register: ${exception.code}');
      }
    } catch (error) {
      throw CustomServerError(errorMessage: 'unknown: ${error.toString()}');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await SecureStorage.instance.deleteToken();
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user != null) {
        return user;
      }
      return null;
    });
  }
}

class CustomServerError implements Exception {
  CustomServerError({required this.errorMessage});

  final String errorMessage;

  @override
  String toString() => 'Error $errorMessage';
}
