abstract class AuthRepository {
  Future<void> login({required String email, required String password});

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
  });

  Future<void> forgotPassword({required String email});

  Future<void> confirmForgotPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
    required String otp,
  });
}
