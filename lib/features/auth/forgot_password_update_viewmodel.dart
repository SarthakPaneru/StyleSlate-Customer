import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/features/auth/auth_repository.dart';
import 'package:hamro_barber_mobile/features/auth/models/confirm_forgot_password_request.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Replaces the setState-driven `_ForgotChangePasswordScreenState` in
/// `core/auth/forgot_password_update.dart`.
class ForgotPasswordUpdateViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  Future<void> changePassword() async {
    final email = emailController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;
    final otp = otpController.text;

    if (email.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      await _dialogService.showDialog(title: 'Error', description: 'Please fill in all fields.');
      return;
    }
    if (newPassword != confirmPassword) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'New password and confirm password must match.',
      );
      return;
    }

    try {
      await runBusyFuture(_authRepository.confirmForgotPassword(ConfirmForgotPasswordRequest(
        email: email,
        newPassword: newPassword,
        confirmNewPassword: confirmPassword,
        otp: otp,
      )));
      await _dialogService.showDialog(title: 'Success', description: 'Password changed successfully.');
      _navigationService.clearStackAndShow(Routes.loginView);
    } catch (_) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to change password. Please try again.',
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
