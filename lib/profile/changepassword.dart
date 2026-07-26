import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository_factory.dart';
import 'package:hamro_barber_mobile/features/profile/viewmodel/change_password_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/inputs/app_text_field.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(createProfileRepository()),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit(ChangePasswordViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await viewModel.changePassword(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (!mounted) return;
    if (success) {
      AppSnackbar.showSuccess(context, AppStrings.changePasswordSuccess);
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    } else {
      AppSnackbar.showError(
        context,
        viewModel.errorMessage ?? AppStrings.changePasswordFailedGeneric,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChangePasswordViewModel>();

    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.changePasswordTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                controller: _currentPasswordController,
                labelText: AppStrings.changePasswordCurrent,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                validator: (value) => viewModel.validateRequired(
                    value, AppStrings.changePasswordCurrent),
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: _newPasswordController,
                labelText: AppStrings.changePasswordNew,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                validator: (value) => viewModel.validateRequired(
                    value, AppStrings.changePasswordNew),
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: _confirmPasswordController,
                labelText: AppStrings.changePasswordConfirm,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                validator: (value) => viewModel.validateConfirmPassword(
                    value, _newPasswordController.text),
              ),
              const SizedBox(height: 28),
              AppPrimaryButton(
                label: AppStrings.changePasswordButton,
                isLoading: viewModel.status == ViewStatus.loading,
                onPressed: () => _submit(viewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
