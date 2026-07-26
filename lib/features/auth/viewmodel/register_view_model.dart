import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel(this._repository);

  final AuthRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationFieldRequired(fieldName);
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationEmailRequired;
    }
    if (!EmailValidator.validate(value.trim())) {
      return AppStrings.validationEmailInvalid;
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.validationConfirmPasswordRequired;
    }
    if (value != password) return AppStrings.validationPasswordsDoNotMatch;
    return null;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
  }) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _repository.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
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
