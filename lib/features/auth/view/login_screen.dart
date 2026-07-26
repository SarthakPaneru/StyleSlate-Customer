import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/services/app_preferences.dart';
import 'package:hamro_barber_mobile/core/services/biometric_service.dart';
import 'package:hamro_barber_mobile/data/auth/auth_repository_factory.dart';
import 'package:hamro_barber_mobile/features/auth/viewmodel/login_view_model.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/inputs/app_text_field.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_brand_logo.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(createAuthRepository()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(LoginViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await viewModel.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;
    if (success) {
      await _maybeOfferBiometricLogin();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      AppSnackbar.showError(
        context,
        viewModel.errorMessage ?? AppStrings.loginFailedGeneric,
      );
    }
  }

  Future<void> _maybeOfferBiometricLogin() async {
    final preferences = AppPreferences();
    if (await preferences.hasBiometricPromptShown()) return;
    if (!await BiometricService().isSupported) return;

    await preferences.setBiometricPromptShown();
    if (!mounted) return;

    final enable = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.loginBiometricPromptTitle),
        content: const Text(AppStrings.loginBiometricPromptBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.loginBiometricPromptNotNow),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppStrings.loginBiometricPromptEnable),
          ),
        ],
      ),
    );

    if (enable == true) {
      await preferences.setBiometricEnabled(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                const Center(child: AppBrandLogo()),
                const SizedBox(height: 28),
                Text(
                  AppStrings.loginWelcomeBack,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.loginSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 36),
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
                  validator: viewModel.validatePassword,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen()),
                    ),
                    child: const Text(AppStrings.loginForgotPassword),
                  ),
                ),
                const SizedBox(height: 8),
                AppPrimaryButton(
                  label: AppStrings.loginButton,
                  isLoading: viewModel.status == ViewStatus.loading,
                  onPressed: () => _submit(viewModel),
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    ),
                    child: const Text(AppStrings.loginNoAccount),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
