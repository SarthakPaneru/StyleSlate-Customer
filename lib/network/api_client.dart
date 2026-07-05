import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:hamro_barber_mobile/features/auth/models/confirm_forgot_password_request.dart';
import 'package:hamro_barber_mobile/features/auth/models/customer_dto.dart';
import 'package:hamro_barber_mobile/features/auth/models/forgot_password_request.dart';
import 'package:hamro_barber_mobile/features/auth/models/login_request.dart';
import 'package:hamro_barber_mobile/features/auth/models/login_response.dart';
import 'package:hamro_barber_mobile/features/auth/models/register_request.dart';
import 'package:hamro_barber_mobile/features/home/models/appointment_dto.dart';
import 'package:hamro_barber_mobile/features/home/models/barber_detail_dto.dart';
import 'package:hamro_barber_mobile/features/home/models/barber_summary_dto.dart';
import 'package:hamro_barber_mobile/features/home/models/create_appointment_request.dart';

part 'api_client.g.dart';

/// Typed Retrofit client, replacing `lib/config/api_requests.dart` +
/// `lib/config/api_service.dart`'s raw `http.Response` methods. Covers the
/// Auth endpoints for this migration pass; other endpoints are added as
/// their features are migrated.
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<HttpResponse<dynamic>> register(@Body() RegisterRequest request);

  @GET('/customer/get-logged-in-user')
  Future<CustomerDto> getLoggedInUser();

  @POST('/auth/forgot-password')
  Future<HttpResponse<dynamic>> forgotPassword(
    @Query('email') String email,
    @Body() ForgotPasswordRequest request,
  );

  @PUT('/auth/confirm-forgot-password')
  Future<HttpResponse<dynamic>> confirmForgotPassword(
    @Body() ConfirmForgotPasswordRequest request,
  );

  @GET('/barber/get/nearest')
  Future<List<BarberSummaryDto>> getNearestBarbers(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
  );

  @GET('/barber/get/{barberId}')
  Future<BarberDetailDto> getBarber(@Path('barberId') int barberId);

  @POST('/appointment/save')
  Future<HttpResponse<dynamic>> createAppointment(@Body() CreateAppointmentRequest request);

  @GET('/appointment/get/customer/{customerId}')
  Future<List<AppointmentDto>> getAppointments(
    @Path('customerId') int customerId,
    @Query('status') String status,
  );
}
