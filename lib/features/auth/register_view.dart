import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/auth/register_viewmodel.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_bar.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_button.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_text_field.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({super.key});

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) => RegisterViewModel();

  @override
  Widget builder(BuildContext context, RegisterViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppToolbar(title: 'Register New User', onBack: viewModel.goToLogin),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),
                const SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage('lib/assets/images/barberlogo.png')),
                ),
                Text('Register', style: AppTextStyles.headline),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.firstNameController,
                  label: 'First Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.lastNameController,
                  label: 'Last Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.emailController,
                  label: 'Email',
                  icon: Icons.mail,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: viewModel.confirmPasswordController,
                  label: 'Confirm Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                AppButton(
                  label: 'Register',
                  icon: Icons.arrow_circle_right_sharp,
                  isLoading: viewModel.isBusy,
                  onPressed: viewModel.register,
                ),
                AppLinkButton(
                  label: 'Already have an Account? LogIn Here',
                  onPressed: viewModel.goToLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
