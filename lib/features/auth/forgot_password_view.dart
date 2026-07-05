import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/auth/forgot_password_viewmodel.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_bar.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_button.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_text_field.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StackedView<ForgotPasswordViewModel> {
  const ForgotPasswordView({super.key});

  @override
  ForgotPasswordViewModel viewModelBuilder(BuildContext context) => ForgotPasswordViewModel();

  @override
  Widget builder(BuildContext context, ForgotPasswordViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppToolbar(
        title: 'Forget Password',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  height: 180,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lock_outline, size: 110, color: AppColors.onPrimary),
                ),
                const SizedBox(height: 25),
                const SizedBox(
                  width: 280,
                  child: Text(
                    'Please Enter Your Email Address To Receive a Verification Code.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.emailController,
                  label: 'Enter Email Address',
                  icon: Icons.mail,
                ),
                const SizedBox(height: 15),
                AppButton(
                  label: 'Send Code',
                  isLoading: viewModel.isBusy,
                  onPressed: viewModel.sendCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
