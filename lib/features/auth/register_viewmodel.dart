import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/features/auth/auth_repository.dart';
import 'package:hamro_barber_mobile/features/auth/models/register_request.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Replaces the setState-driven `_RegisterState` in `core/auth/register.dart`.
class RegisterViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> register() async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _snackbarService.showSnackbar(message: 'Registration failed. Please check your credentials.');
      return;
    }
    if (password != confirmPassword) {
      _snackbarService.showSnackbar(message: 'Registration failed. Please check your credentials.');
      return;
    }
    if (!EmailValidator.validate(email.trim())) {
      _snackbarService.showSnackbar(message: 'Registration failed. Please check your credentials.');
      return;
    }

    try {
      await runBusyFuture(_authRepository.register(RegisterRequest(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
      )));
      _navigationService.replaceWith(Routes.loginView);
    } catch (_) {
      _snackbarService.showSnackbar(message: 'Registration failed. Please check your credentials.');
    }
  }

  void goToLogin() => _navigationService.replaceWith(Routes.loginView);

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
