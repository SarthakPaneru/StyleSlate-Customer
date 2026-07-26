import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository_factory.dart';
import 'package:hamro_barber_mobile/features/auth/viewmodel/forgot_password_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/inputs/app_text_field.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';
import 'forgot_password_confirm_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(createAuthRepository()),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit(ForgotPasswordViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final success = await viewModel.sendResetCode(email: email);

    if (!mounted) return;
    if (success) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ForgotPasswordConfirmScreen(email: email),
        ),
      );
    } else {
      AppSnackbar.showError(
        context,
        viewModel.errorMessage ?? AppStrings.forgotPasswordSendFailed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ForgotPasswordViewModel>();

    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.forgotPasswordTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.forgotPasswordBody,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _emailController,
                  labelText: AppStrings.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: viewModel.validateEmail,
                ),
                const SizedBox(height: 28),
                AppPrimaryButton(
                  label: AppStrings.forgotPasswordSendCode,
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
