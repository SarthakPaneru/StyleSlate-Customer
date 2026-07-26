import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository_factory.dart';
import 'package:hamro_barber_mobile/features/auth/viewmodel/register_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/inputs/app_text_field.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_brand_logo.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(createAuthRepository()),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit(RegisterViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await viewModel.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
    );

    if (!mounted) return;
    if (success) {
      AppSnackbar.showSuccess(context, AppStrings.registerSuccess);
      Navigator.of(context).pop();
    } else {
      AppSnackbar.showError(
        context,
        viewModel.errorMessage ?? AppStrings.registerFailedGeneric,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();

    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.registerTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: AppBrandLogo(size: 72)),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _firstNameController,
                        labelText: AppStrings.registerFirstName,
                        validator: (value) => viewModel.validateRequired(
                            value, AppStrings.registerFirstName),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        controller: _lastNameController,
                        labelText: AppStrings.registerLastName,
                        validator: (value) => viewModel.validateRequired(
                            value, AppStrings.registerLastName),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _emailController,
                  labelText: AppStrings.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: viewModel.validateEmail,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  labelText: AppStrings.password,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) =>
                      viewModel.validateRequired(value, AppStrings.password),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  labelText: AppStrings.confirmPassword,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) => viewModel.validateConfirmPassword(
                      value, _passwordController.text),
                ),
                const SizedBox(height: 28),
                AppPrimaryButton(
                  label: AppStrings.registerButton,
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
