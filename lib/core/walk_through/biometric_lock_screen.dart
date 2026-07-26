import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';
import 'package:hamro_barber_mobile/core/services/biometric_service.dart';
import 'package:hamro_barber_mobile/features/auth/view/login_screen.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
import 'package:hamro_barber_mobile/ui_kit/buttons/app_primary_button.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_brand_logo.dart';

/// Shown at launch when the user has an existing session AND has opted
/// into biometric login. Blocks entry to the app until Face ID/fingerprint
/// succeeds, with a password fallback that doesn't clear the session.
class BiometricLockScreen extends StatefulWidget {
  const BiometricLockScreen({super.key});

  @override
  State<BiometricLockScreen> createState() => _BiometricLockScreenState();
}

class _BiometricLockScreenState extends State<BiometricLockScreen> {
  final _biometricService = BiometricService();
  bool _authenticating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
  }

  Future<void> _authenticate() async {
    setState(() => _authenticating = true);
    final success = await _biometricService.authenticate(
      reason: AppStrings.biometricLoginReason,
    );
    if (!mounted) return;
    setState(() => _authenticating = false);

    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  Future<void> _usePasswordInstead() async {
    // Clear the session so the user goes through a normal password login
    // rather than looping back to this lock screen.
    await Token().clearBearerToken();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppBrandLogo(),
              const SizedBox(height: 28),
              Text(
                AppStrings.biometricUnlockTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.biometricUnlockSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              AppPrimaryButton(
                label: AppStrings.biometricTryAgain,
                isLoading: _authenticating,
                onPressed: _authenticate,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _usePasswordInstead,
                child: const Text(AppStrings.usePasswordInstead),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
