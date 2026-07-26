import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  ChangePasswordViewModel(this._repository);

  final ProfileRepository _repository;

  ViewStatus status = ViewStatus.idle;
  String? errorMessage;

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
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

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      await _repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
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
