import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  ForgotPasswordViewModel(this._repository);

  final AuthRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationEmailRequired;
    }
    if (!EmailValidator.validate(value.trim())) {
      return AppStrings.validationEmailInvalid;
    }
    return null;
  }

  Future<bool> sendResetCode({required String email}) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _repository.forgotPassword(email: email);
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
