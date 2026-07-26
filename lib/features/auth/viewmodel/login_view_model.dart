import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._repository);

  final AuthRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationEmailRequired;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.validationEmailInvalid;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.validationPasswordRequired;
    }
    if (value.length < 6) return AppStrings.validationPasswordTooShort;
    return null;
  }

  Future<bool> login({required String email, required String password}) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _repository.login(email: email, password: password);
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
