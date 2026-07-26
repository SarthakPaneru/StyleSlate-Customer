import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'models/create_appointment_request.dart';

part 'appointment_api.g.dart';

@RestApi()
abstract class AppointmentApi {
  factory AppointmentApi(Dio dio) = _AppointmentApi;

  @POST('/appointment/save')
  Future<void> createAppointment(@Body() CreateAppointmentRequest request);

  @GET('/appointment/get/customer/{customerId}')
  Future<dynamic> getAppointmentsRaw(
    @Path('customerId') int customerId,
    @Query('status') String status,
  );
}
