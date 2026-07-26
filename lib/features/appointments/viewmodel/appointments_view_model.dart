import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/appointments/appointment_repository.dart';
import 'package:hamro_barber_mobile/data/appointments/models/appointment_model.dart';

class AppointmentsViewModel extends ChangeNotifier {
  AppointmentsViewModel(this._repository);

  final AppointmentRepository _repository;

  ViewStatus status = ViewStatus.loading;
  String? errorMessage;
  List<AppointmentModel> appointments = const [];

  Future<void> load(String status) async {
    this.status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      appointments = await _repository.getAppointments(status);
      this.status = ViewStatus.success;
    } on AppException catch (e) {
      this.status = ViewStatus.error;
      errorMessage = e.message;
    }
    notifyListeners();
  }
}
