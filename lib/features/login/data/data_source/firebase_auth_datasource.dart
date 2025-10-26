import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/core/storage/secure_storage/secure_storage.dart';
import 'package:login_app/features/login/domain/entities/user_entity.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserEntity?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        final token = await user.getIdToken();
        await SecureStorage.instance.saveToken(token);
        return UserEntity(uid: user.uid, email: user.email);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          final user = userCredential.user;
          if (user != null) {
            final token = await user.getIdToken();
            await SecureStorage.instance.saveToken(token);
            return UserEntity(uid: user.uid, email: user.email);
          }
          return null;
        } on FirebaseAuthException catch (loginError) {
          throw CustomServerError(
            errorMessage: 'Login error: ${loginError.message}',
          );
        }
      } else {
        throw CustomServerError(errorMessage: 'Register error: ${e.message}');
      }
    } catch (error) {
      throw CustomServerError(
        errorMessage: 'Unknown error: ${error.toString()}',
      );
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await SecureStorage.instance.saveToken('');
  }

  Stream<UserEntity?> get user {
    return _firebaseAuth.authStateChanges().map(
      (user) =>
          user != null ? UserEntity(uid: user.uid, email: user.email) : null,
    );
  }
}

class CustomServerError implements Exception {
  CustomServerError({required this.errorMessage});

  final String errorMessage;

  @override
  String toString() => 'CustomServerError: $errorMessage';
}
