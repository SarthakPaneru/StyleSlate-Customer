import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/core/utils/image_url_builder.dart';
import 'package:hamro_barber_mobile/data/barbers/barber_repository.dart';
import 'package:hamro_barber_mobile/data/barbers/models/barber_detail_model.dart';

class BarberDetailViewModel extends ChangeNotifier {
  BarberDetailViewModel(this._repository);

  final BarberRepository _repository;

  ViewStatus status = ViewStatus.loading;
  String? errorMessage;
  BarberDetailModel? barber;
  String imageUrl = '';

  Future<void> load(int barberId) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    final userId = await Customer().retrieveUserId();
    if (userId != null) {
      imageUrl = ImageUrlBuilder.forUser(int.parse(userId));
    }

    try {
      barber = await _repository.getBarberDetail(barberId);
      status = ViewStatus.success;
    } on AppException catch (e) {
      status = ViewStatus.error;
      errorMessage = e.message;
    }
    notifyListeners();
  }
}
