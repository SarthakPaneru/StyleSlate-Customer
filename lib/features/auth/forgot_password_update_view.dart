import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/auth/forgot_password_update_viewmodel.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_button.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_text_field.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordUpdateView extends StackedView<ForgotPasswordUpdateViewModel> {
  const ForgotPasswordUpdateView({super.key});

  @override
  ForgotPasswordUpdateViewModel viewModelBuilder(BuildContext context) =>
      ForgotPasswordUpdateViewModel();

  @override
  Widget builder(BuildContext context, ForgotPasswordUpdateViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(controller: viewModel.emailController, label: 'Email'),
            const SizedBox(height: 20),
            AppTextField(
              controller: viewModel.newPasswordController,
              label: 'New Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: viewModel.confirmPasswordController,
              label: 'Confirm Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            AppTextField(controller: viewModel.otpController, label: 'OTP'),
            const SizedBox(height: 20),
            AppButton(
              label: 'Change Password',
              isLoading: viewModel.isBusy,
              onPressed: viewModel.changePassword,
            ),
          ],
        ),
      ),
    );
  }
}
