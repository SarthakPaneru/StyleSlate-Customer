import 'package:shared_preferences/shared_preferences.dart';

/// Small first-launch/settings flags that don't warrant their own backend
/// round-trip — onboarding seen, and the user's biometric-login opt-in.
class AppPreferences {
  static const _keyOnboardingSeen = 'onboarding_seen';
  static const _keyBiometricEnabled = 'biometric_enabled';
  static const _keyBiometricPromptShown = 'biometric_prompt_shown';

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingSeen) ?? false;
  }

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingSeen, true);
  }

  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyBiometricEnabled) ?? false;
  }

  Future<void> setBiometricEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyBiometricEnabled, value);
  }

  Future<bool> hasBiometricPromptShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyBiometricPromptShown) ?? false;
  }

  Future<void> setBiometricPromptShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyBiometricPromptShown, true);
  }
}
