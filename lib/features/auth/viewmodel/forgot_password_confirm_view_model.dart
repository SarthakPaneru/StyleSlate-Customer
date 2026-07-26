import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository.dart';

class ForgotPasswordConfirmViewModel extends ChangeNotifier {
  ForgotPasswordConfirmViewModel(this._repository);

  final AuthRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationFieldRequired(fieldName);
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String newPassword) {
    if (value == null || value.isEmpty) {
      return AppStrings.validationConfirmNewPasswordRequired;
    }
    if (value != newPassword) return AppStrings.validationPasswordsDoNotMatch;
    return null;
  }

  Future<bool> confirmReset({
    required String email,
    required String newPassword,
    required String confirmPassword,
    required String otp,
  }) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _repository.confirmForgotPassword(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        otp: otp,
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
