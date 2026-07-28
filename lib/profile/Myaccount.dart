import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/services/app_preferences.dart';
import 'package:hamro_barber_mobile/core/services/biometric_service.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository_factory.dart';
import 'package:hamro_barber_mobile/features/profile/viewmodel/my_account_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_shimmer.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_top_bar.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyAccountViewModel(createProfileRepository())..load(),
      child: const _MyAccountView(),
    );
  }
}

class _MyAccountView extends StatefulWidget {
  const _MyAccountView();

  @override
  State<_MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<_MyAccountView> {
  final _preferences = AppPreferences();
  bool _biometricSupported = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
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
    final viewModel = context.watch<MyAccountViewModel>();

    return Scaffold(
      appBar: const AppTopBar(title: AppStrings.myAccountTitle),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(MyAccountViewModel viewModel) {
    if (viewModel.status == ViewStatus.loading) {
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

    if (viewModel.status == ViewStatus.error) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          AppEmptyState(
            icon: Icons.wifi_off,
            message: viewModel.errorMessage ?? AppStrings.myAccountLoadFailed,
            onRetry: viewModel.load,
          ),
        ],
      );
    }

    final account = viewModel.account;
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
