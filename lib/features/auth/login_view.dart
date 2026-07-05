import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/auth/login_viewmodel.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_button.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_text_field.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),
                const SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage('lib/assets/images/barberlogo.png')),
                ),
                Text('Login', style: AppTextStyles.headline),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.emailController,
                  label: 'Email',
                  icon: Icons.mail,
                  onChanged: (_) => viewModel.validateEmail(),
                  errorText: viewModel.isEmailValid ? null : 'Invalid email',
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: viewModel.obscurePassword,
                  onChanged: (_) => viewModel.validatePassword(),
                  errorText: viewModel.isPasswordValid ? null : 'Invalid password',
                  suffixIcon: IconButton(
                    onPressed: viewModel.toggleObscurePassword,
                    icon: Icon(
                      viewModel.obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                AppButton(
                  label: 'Log in',
                  icon: Icons.arrow_forward,
                  isLoading: viewModel.isBusy,
                  onPressed: viewModel.login,
                ),
                const SizedBox(height: 8),
                AppLinkButton(label: 'Forgot Password?', onPressed: viewModel.goToForgotPassword),
                AppLinkButton(
                  label: "Don't have an Account? Register Here",
                  onPressed: viewModel.goToRegister,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }
}
