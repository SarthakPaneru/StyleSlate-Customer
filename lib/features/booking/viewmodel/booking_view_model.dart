import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/appointments/appointment_repository.dart';

class BookingViewModel extends ChangeNotifier {
  BookingViewModel(this._repository);

  final AppointmentRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;

  Future<bool> createAppointment({
    required int bookingStart,
    required int bookingEnd,
    required int barberId,
    required int serviceId,
  }) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _repository.createAppointment(
        bookingStart: bookingStart,
        bookingEnd: bookingEnd,
        barberId: barberId,
        serviceId: serviceId,
      );
      status = ViewStatus.success;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      status = ViewStatus.error;
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
  }
}
