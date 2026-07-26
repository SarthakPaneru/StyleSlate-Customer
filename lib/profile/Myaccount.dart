import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/core/services/app_preferences.dart';
import 'package:hamro_barber_mobile/core/services/biometric_service.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _preferences = AppPreferences();
  String _email = '';
  String _phone = '';
  String _username = '';
  bool _biometricSupported = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadAccountDetails();
    _loadBiometricState();
  }

  Future<void> _loadAccountDetails() async {
    final customer = Customer();
    final email = await customer.retrieveCustomerEmail();
    final phone = await customer.retrievePhone();
    final firstName = await customer.retrieveFirstName();
    final lastName = await customer.retrieveLastName();

    if (!mounted) return;
    setState(() {
      _email = email ?? '';
      _phone = phone ?? '';
      _username = '${firstName ?? ''} ${lastName ?? ''}'.trim();
    });
  }

  Future<void> _loadBiometricState() async {
    final supported = await BiometricService().isSupported;
    final enabled = await _preferences.isBiometricEnabled();
    if (!mounted) return;
    setState(() {
      _biometricSupported = supported;
      _biometricEnabled = enabled;
    });
  }

  Future<void> _toggleBiometric(bool value) async {
    if (value) {
      final authenticated = await BiometricService().authenticate(
        reason: AppStrings.biometricEnableConfirmReason,
      );
      if (!authenticated) return;
    }
    await _preferences.setBiometricEnabled(value);
    if (!mounted) return;
    setState(() => _biometricEnabled = value);
    AppSnackbar.showSuccess(
      context,
      value ? AppStrings.biometricEnabledMessage : AppStrings.biometricDisabledMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.myAccountTitle),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(_phone.isEmpty ? AppStrings.myAccountNoPhone : _phone),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(_email.isEmpty ? AppStrings.myAccountNoEmail : _email),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(_username.isEmpty ? AppStrings.myAccountNoName : _username),
          ),
          if (_biometricSupported)
            SwitchListTile(
              secondary: const Icon(Icons.fingerprint),
              title: const Text(AppStrings.biometricToggleLabel),
              value: _biometricEnabled,
              onChanged: _toggleBiometric,
            ),
        ],
      ),
    );
  }
}
