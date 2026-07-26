import 'package:hamro_barber_mobile/core/network/dio_client.dart';
import 'appointment_api.dart';
import 'appointment_repository.dart';
import 'appointment_repository_impl.dart';

AppointmentRepository createAppointmentRepository() {
  return AppointmentRepositoryImpl(AppointmentApi(DioClient.instance));
}
