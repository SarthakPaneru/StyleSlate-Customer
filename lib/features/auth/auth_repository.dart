import 'package:hamro_barber_mobile/features/auth/models/confirm_forgot_password_request.dart';
import 'package:hamro_barber_mobile/features/auth/models/forgot_password_request.dart';
import 'package:hamro_barber_mobile/features/auth/models/login_request.dart';
import 'package:hamro_barber_mobile/features/auth/models/register_request.dart';
import 'package:hamro_barber_mobile/network/api_client.dart';
import 'package:hamro_barber_mobile/services/customer_session_service.dart';
import 'package:hamro_barber_mobile/services/token_service.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(RegisterRequest request);
  Future<void> forgotPassword(String email);
  Future<void> confirmForgotPassword(ConfirmForgotPasswordRequest request);
}

/// Replaces the direct `ApiRequests`/`ApiService` calls that used to live in
/// `core/auth/login.dart`, `register.dart`, `forgot_pwd.dart` and
/// `forgot_password_update.dart`.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._apiClient, this._tokenService, this._customerSessionService);

  final ApiClient _apiClient;
  final TokenService _tokenService;
  final CustomerSessionService _customerSessionService;

  @override
  Future<void> login(String email, String password) async {
    final response = await _apiClient.login(LoginRequest(email: email, password: password));
    await _tokenService.storeBearerToken(response.accessToken);

    final customer = await _apiClient.getLoggedInUser();
    await _customerSessionService.storeCustomerDetails(customer);
  }

  @override
  Future<void> register(RegisterRequest request) async {
    await _apiClient.register(request);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _apiClient.forgotPassword(email, ForgotPasswordRequest(email: email));
  }

  @override
  Future<void> confirmForgotPassword(ConfirmForgotPasswordRequest request) async {
    await _apiClient.confirmForgotPassword(request);
  }
}
