import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'appointment_api.dart';
import 'appointment_repository.dart';
import 'models/appointment_model.dart';
import 'models/create_appointment_request.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  AppointmentRepositoryImpl(this._appointmentApi);

  final AppointmentApi _appointmentApi;

  @override
  Future<void> createAppointment({
    required int bookingStart,
    required int bookingEnd,
    required int barberId,
    required int serviceId,
  }) async {
    try {
      await _appointmentApi.createAppointment(
        CreateAppointmentRequest(
          bookingStart: bookingStart,
          bookingEnd: bookingEnd,
          barberId: barberId,
          servicesIds: [serviceId.toString()],
        ),
      );
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointments(String status) async {
    try {
      final customerId = await Customer().retrieveCustomerId();
      final raw = await _appointmentApi.getAppointmentsRaw(
        customerId ?? 0,
        status,
      ) as List<dynamic>;
      return raw
          .map((json) => AppointmentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    }
  }
}
