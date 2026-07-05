import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/features/auth/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Replaces the setState-driven `_LoginState` in `core/auth/login.dart`.
class LoginViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool obscurePassword = true;

  void validateEmail() {
    isEmailValid = EmailValidator.validate(emailController.text.trim());
    rebuildUi();
  }

  void validatePassword() {
    isPasswordValid = passwordController.text.isNotEmpty;
    rebuildUi();
  }

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    rebuildUi();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty || !isEmailValid || !isPasswordValid) {
      _snackbarService.showSnackbar(message: 'Login failed. Please check your credentials.');
      return;
    }

    try {
      await runBusyFuture(_authRepository.login(email, password));
      _navigationService.clearStackAndShow(Routes.homeShellView);
    } catch (_) {
      _snackbarService.showSnackbar(message: 'Login failed. Please check your credentials.');
    }
  }

  void goToRegister() => _navigationService.navigateTo(Routes.registerView);

  void goToForgotPassword() => _navigationService.navigateTo(Routes.forgotPasswordView);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
