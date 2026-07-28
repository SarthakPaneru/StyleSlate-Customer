import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'auth_api.dart';
import 'auth_repository.dart';
import 'models/confirm_forgot_password_request.dart';
import 'models/login_request.dart';
import 'models/register_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authApi);

  final AuthApi _authApi;

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final response = await _authApi.login(
        LoginRequest(email: email, password: password),
      );
      await Token().storeBearerToken(response.accessToken);

      final loggedInUser = await _authApi.getLoggedInUser();
      await Customer().storeCustomerDetails(loggedInUser.toJson());
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      await _authApi.register(
        RegisterRequest(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
        ),
      );
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _authApi.forgotPassword(email);
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  @override
  Future<void> confirmForgotPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
    required String otp,
  }) async {
    try {
      await _authApi.confirmForgotPassword(
        ConfirmForgotPasswordRequest(
          email: email,
          newPassword: newPassword,
          confirmNewPassword: confirmPassword,
          otp: otp,
        ),
      );
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }
}
