import 'models/appointment_model.dart';

abstract class AppointmentRepository {
  Future<void> createAppointment({
    required int bookingStart,
    required int bookingEnd,
    required int barberId,
    required int serviceId,
  });

  Future<List<AppointmentModel>> getAppointments(String status);
}
