import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/features/home/home_repository.dart';
import 'package:hamro_barber_mobile/features/home/models/appointment_dto.dart';
import 'package:hamro_barber_mobile/services/customer_session_service.dart';
import 'package:stacked/stacked.dart';

/// Replaces `Screen/appointment.dart` (`ScheduledAppointmentPage`).
class AppointmentsViewModel extends BaseViewModel {
  static const statuses = ['upcoming', 'completed', 'cancelled'];

  final _homeRepository = locator<HomeRepository>();
  final _customerSessionService = locator<CustomerSessionService>();

  List<AppointmentDto> appointments = [];
  bool isLoading = true;
  int selectedTabIndex = 0;

  Future<void> init() => selectTab(0);

  Future<void> selectTab(int index) async {
    selectedTabIndex = index;
    isLoading = true;
    rebuildUi();

    try {
      final customerId = await _customerSessionService.retrieveCustomerId();
      appointments =
          customerId != null ? await _homeRepository.getAppointments(customerId, statuses[index]) : [];
    } catch (_) {
      appointments = [];
    }
    isLoading = false;
    rebuildUi();
  }

  String imageUrlFor(AppointmentDto appointment) {
    final userId = appointment.barber?.user?.id;
    return userId != null ? _homeRepository.imageUrlForUser(userId) : '';
  }

  String barberNameFor(AppointmentDto appointment) =>
      '${appointment.barber?.user?.firstName ?? ''} ${appointment.barber?.user?.lastName ?? ''}'.trim();

  String serviceNameFor(AppointmentDto appointment) {
    final services = appointment.services;
    return services != null && services.isNotEmpty ? (services.first.serviceName ?? '') : '';
  }

  String dateFor(AppointmentDto appointment) {
    final dt = _dateTimeFor(appointment);
    return '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  String timeFor(AppointmentDto appointment) {
    final dt = _dateTimeFor(appointment);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  DateTime _dateTimeFor(AppointmentDto appointment) =>
      DateTime.fromMillisecondsSinceEpoch((appointment.bookingStart ?? 0) * 1000);
}
