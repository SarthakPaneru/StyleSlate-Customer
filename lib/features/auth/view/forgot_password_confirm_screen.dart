import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository_factory.dart';
import 'package:hamro_barber_mobile/features/auth/viewmodel/forgot_password_confirm_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/inputs/app_text_field.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';
import 'login_screen.dart';

class ForgotPasswordConfirmScreen extends StatelessWidget {
  const ForgotPasswordConfirmScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordConfirmViewModel(createAuthRepository()),
      child: _ForgotPasswordConfirmView(email: email),
    );
  }
}

class _ForgotPasswordConfirmView extends StatefulWidget {
  const _ForgotPasswordConfirmView({required this.email});

  final String email;

  @override
  State<_ForgotPasswordConfirmView> createState() =>
      _ForgotPasswordConfirmViewState();
}

class _ForgotPasswordConfirmViewState
    extends State<_ForgotPasswordConfirmView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit(ForgotPasswordConfirmViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await viewModel.confirmReset(
      email: widget.email,
      newPassword: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
      otp: _otpController.text.trim(),
    );

    if (!mounted) return;
    if (success) {
      AppSnackbar.showSuccess(context, AppStrings.resetPasswordSuccess);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } else {
      AppSnackbar.showError(
        context,
        viewModel.errorMessage ?? AppStrings.resetPasswordFailedGeneric,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ForgotPasswordConfirmViewModel>();

    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.resetPasswordTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.resetPasswordBody(widget.email),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _otpController,
                  labelText: AppStrings.resetPasswordCode,
                  keyboardType: TextInputType.number,
                  validator: (value) => viewModel.validateRequired(
                      value, AppStrings.resetPasswordCode),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _newPasswordController,
                  labelText: AppStrings.resetPasswordNewPassword,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) => viewModel.validateRequired(
                      value, AppStrings.resetPasswordNewPassword),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  labelText: AppStrings.resetPasswordConfirmNewPassword,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) => viewModel.validateConfirmPassword(
                      value, _newPasswordController.text),
                ),
                const SizedBox(height: 28),
                AppPrimaryButton(
                  label: AppStrings.resetPasswordButton,
                  isLoading: viewModel.status == ViewStatus.loading,
                  onPressed: () => _submit(viewModel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
