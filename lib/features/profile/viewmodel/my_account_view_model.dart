import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/auth/models/logged_in_user_response.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository.dart';

class MyAccountViewModel extends ChangeNotifier {
  MyAccountViewModel(this._repository);

  final ProfileRepository _repository;

  ViewStatus status = ViewStatus.loading;
  String? errorMessage;
  UserResponse? account;

  Future<void> load() async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      account = await _repository.getAccountDetails();
      status = ViewStatus.success;
    } on AppException catch (e) {
      status = ViewStatus.error;
      errorMessage = e.message;
    }
    notifyListeners();
  }
}
