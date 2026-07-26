import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/utils/image_url_builder.dart';
import 'package:hamro_barber_mobile/data/appointments/appointment_repository_factory.dart';
import 'package:hamro_barber_mobile/features/appointments/viewmodel/appointments_view_model.dart';
import 'package:hamro_barber_mobile/theme/app_colors.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_shimmer.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_avatar_image.dart';

class ScheduledAppointmentPage extends StatefulWidget {
  const ScheduledAppointmentPage({super.key});

  @override
  State<ScheduledAppointmentPage> createState() =>
      _ScheduledAppointmentPageState();
}

class _ScheduledAppointmentPageState extends State<ScheduledAppointmentPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appointmentsTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: AppStrings.appointmentsTabUpcoming),
            Tab(text: AppStrings.appointmentsTabCompleted),
            Tab(text: AppStrings.appointmentsTabCancelled),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _AppointmentTab(status: 'upcoming'),
          _AppointmentTab(status: 'completed'),
          _AppointmentTab(status: 'cancelled'),
        ],
      ),
    );
  }
}

class _AppointmentTab extends StatefulWidget {
  const _AppointmentTab({required this.status});

  final String status;

  @override
  State<_AppointmentTab> createState() => _AppointmentTabState();
}

class _AppointmentTabState extends State<_AppointmentTab> {
  late final AppointmentsViewModel _viewModel =
      AppointmentsViewModel(createAppointmentRepository());

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onChanged);
    _viewModel.load(widget.status);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _viewModel.removeListener(_onChanged);
    super.dispose();
  }

  Future<void> _refresh() => _viewModel.load(widget.status);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_viewModel.status == ViewStatus.loading) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) => const ShimmerListTile(),
      );
    }
    if (_viewModel.status == ViewStatus.error) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          AppEmptyState(
            icon: Icons.wifi_off,
            message: _viewModel.errorMessage ?? AppStrings.appointmentsLoadFailed,
            onRetry: _refresh,
          ),
        ],
      );
    }
    if (_viewModel.appointments.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 80),
          AppEmptyState(message: AppStrings.appointmentsEmpty),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _viewModel.appointments.length,
      itemBuilder: (context, index) {
        final appointment = _viewModel.appointments[index];
        final dateTime = DateTime.fromMillisecondsSinceEpoch(
          appointment.bookingStart * 1000,
        );

        return Card(
          color: AppColors.surfaceElevated,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: AppAvatarImage(
              imageUrl: ImageUrlBuilder.forUser(appointment.barberUserId),
            ),
            title: Text(
              appointment.barberName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.appointmentDate(
                    DateFormat('yyyy-MM-dd').format(dateTime))),
                Text(AppStrings.appointmentTime(
                    DateFormat('HH:mm').format(dateTime))),
                Text(AppStrings.appointmentService(appointment.serviceName)),
              ],
            ),
            trailing: widget.status == 'completed'
                ? const Icon(Icons.check_circle, color: AppColors.success)
                : widget.status == 'cancelled'
                    ? const Icon(Icons.cancel, color: AppColors.error)
                    : null,
          ),
        );
      },
    );
  }
}
