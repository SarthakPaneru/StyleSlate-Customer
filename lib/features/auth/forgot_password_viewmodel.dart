import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/features/auth/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Replaces the setState-driven `_ForgetpasswordState` in `core/auth/forgot_pwd.dart`.
class ForgotPasswordViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final emailController = TextEditingController();

  Future<void> sendCode() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Please fill email address field.',
      );
      return;
    }
    if (!EmailValidator.validate(email)) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Please insert correct email address.',
      );
      return;
    }

    try {
      await runBusyFuture(_authRepository.forgotPassword(email));
      _navigationService.navigateTo(Routes.forgotPasswordUpdateView);
    } catch (_) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to send verification code. Please try again.',
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
