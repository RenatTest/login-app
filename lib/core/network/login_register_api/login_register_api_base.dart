abstract interface class LoginRegisterApiBase {
  Future<void> loginRegister({required String email, required String password});
  Future<void> logOut();
}
