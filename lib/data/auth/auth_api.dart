import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'models/confirm_forgot_password_request.dart';
import 'models/login_request.dart';
import 'models/login_response.dart';
import 'models/logged_in_user_response.dart';
import 'models/register_request.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<void> register(@Body() RegisterRequest request);

  @POST('/auth/forgot-password')
  Future<void> forgotPassword(@Query('email') String email);

  @PUT('/auth/confirm-forgot-password')
  Future<void> confirmForgotPassword(
    @Body() ConfirmForgotPasswordRequest request,
  );

  @GET('/customer/get-logged-in-user')
  Future<LoggedInUserResponse> getLoggedInUser();
}
