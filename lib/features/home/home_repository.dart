import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/features/home/models/appointment_dto.dart';
import 'package:hamro_barber_mobile/features/home/models/barber_detail_dto.dart';
import 'package:hamro_barber_mobile/features/home/models/barber_summary_dto.dart';
import 'package:hamro_barber_mobile/features/home/models/create_appointment_request.dart';
import 'package:hamro_barber_mobile/network/api_client.dart';

abstract class HomeRepository {
  Future<List<BarberSummaryDto>> getNearestBarbers(double latitude, double longitude);
  Future<BarberDetailDto> getBarber(int barberId);
  Future<void> createAppointment(
      int bookingStart, int bookingEnd, int barberId, int serviceId);
  Future<List<AppointmentDto>> getAppointments(int customerId, String status);
  String imageUrlForUser(int userId);
}

/// Replaces the direct `ApiRequests`/`ApiService` calls that used to live in
/// `widgets/barberSelection.dart`, `Screen/detailScreen.dart`,
/// `Screen/booking page.dart` and `Screen/appointment.dart`.
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<BarberSummaryDto>> getNearestBarbers(double latitude, double longitude) {
    return _apiClient.getNearestBarbers(latitude, longitude);
  }

  @override
  Future<BarberDetailDto> getBarber(int barberId) {
    return _apiClient.getBarber(barberId);
  }

  @override
  Future<void> createAppointment(
      int bookingStart, int bookingEnd, int barberId, int serviceId) async {
    await _apiClient.createAppointment(CreateAppointmentRequest(
      bookingStart: bookingStart,
      bookingEnd: bookingEnd,
      barberId: barberId,
      servicesIds: [serviceId.toString()],
    ));
  }

  @override
  Future<List<AppointmentDto>> getAppointments(int customerId, String status) {
    return _apiClient.getAppointments(customerId, status);
  }

  @override
  String imageUrlForUser(int userId) {
    return '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId/get-image';
  }
}
