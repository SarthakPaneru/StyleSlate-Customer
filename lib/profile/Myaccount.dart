import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/auth/current_user_state.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/services/app_preferences.dart';
import 'package:hamro_barber_mobile/core/services/biometric_service.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_shimmer.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _preferences = AppPreferences();
  bool _biometricSupported = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    // Reuses the shared CurrentUserState (populated once at app root) --
    // a no-op if Home already loaded it, so this never fires a duplicate
    // GET /customer/get-logged-in-user call.
    context.read<CurrentUserState>().ensureLoaded();
    _loadBiometricState();
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

  Widget _infoTile({
    required IconData icon,
    required String value,
    required String emptyLabel,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(value.isEmpty ? emptyLabel : value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<CurrentUserState>();

    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.myAccountTitle),
      body: _buildBody(currentUser),
    );
  }

  Widget _buildBody(CurrentUserState currentUser) {
    if (currentUser.status == ViewStatus.loading ||
        currentUser.status == ViewStatus.idle) {
      return const AppShimmer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              ShimmerListTile(),
              ShimmerListTile(),
              ShimmerListTile(),
            ],
          ),
        ),
      );
    }

    if (currentUser.status == ViewStatus.error) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          AppEmptyState(
            icon: Icons.wifi_off,
            message: currentUser.errorMessage ?? AppStrings.myAccountLoadFailed,
            onRetry: currentUser.refresh,
          ),
        ],
      );
    }

    final account = currentUser.user;
    final username = account == null
        ? ''
        : '${account.firstName} ${account.lastName}'.trim();

    return ListView(
      children: <Widget>[
        _infoTile(
          icon: Icons.phone,
          value: account?.phone ?? '',
          emptyLabel: AppStrings.myAccountNoPhone,
        ),
        _infoTile(
          icon: Icons.email,
          value: account?.email ?? '',
          emptyLabel: AppStrings.myAccountNoEmail,
        ),
        _infoTile(
          icon: Icons.person,
          value: username,
          emptyLabel: AppStrings.myAccountNoName,
        ),
        if (_biometricSupported)
          SwitchListTile(
            secondary: const Icon(Icons.fingerprint),
            title: const Text(AppStrings.biometricToggleLabel),
            value: _biometricEnabled,
            onChanged: _toggleBiometric,
          ),
      ],
    );
  }
}
