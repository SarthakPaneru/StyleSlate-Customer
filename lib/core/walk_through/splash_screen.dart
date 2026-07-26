import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';
import 'package:hamro_barber_mobile/core/services/app_preferences.dart';
import 'package:hamro_barber_mobile/core/walk_through/biometric_lock_screen.dart';
import 'package:hamro_barber_mobile/core/walk_through/onboarding_screen.dart';
import 'package:hamro_barber_mobile/features/auth/view/login_screen.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _preferences = AppPreferences();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _resolveStartupRoute);
  }

  Future<void> _resolveStartupRoute() async {
    final seenOnboarding = await _preferences.hasSeenOnboarding();
    if (!seenOnboarding) {
      _replaceWith(const OnboardingScreen());
      return;
    }

    final token = await Token().retrieveBearerToken();
    if (token == null) {
      _replaceWith(const LoginScreen());
      return;
    }

    final biometricEnabled = await _preferences.isBiometricEnabled();
    if (biometricEnabled) {
      _replaceWith(const BiometricLockScreen());
    } else {
      _replaceWith(const HomePage());
    }
  }

  void _replaceWith(Widget screen) {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('lib/assets/images/barberlogo.png')),
    );
  }
}
