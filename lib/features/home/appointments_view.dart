import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/home/appointments_viewmodel.dart';
import 'package:hamro_barber_mobile/features/home/models/appointment_dto.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';
import 'package:stacked/stacked.dart';

class AppointmentsView extends StackedView<AppointmentsViewModel> {
  const AppointmentsView({super.key});

  @override
  AppointmentsViewModel viewModelBuilder(BuildContext context) => AppointmentsViewModel();

  @override
  void onViewModelReady(AppointmentsViewModel viewModel) => viewModel.init();

  @override
  Widget builder(BuildContext context, AppointmentsViewModel viewModel, Widget? child) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.darkSurface,
        appBar: AppBar(
          title: const Text('Scheduled Appointments', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.darkSurface,
          bottom: TabBar(
            labelColor: Colors.white,
            onTap: viewModel.selectTab,
            tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Completed'), Tab(text: 'Cancelled')],
          ),
        ),
        body: TabBarView(
          children: [
            _AppointmentList(viewModel: viewModel, isCompleted: false),
            _AppointmentList(viewModel: viewModel, isCompleted: true),
            _AppointmentList(viewModel: viewModel, isCompleted: false),
          ],
        ),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  const _AppointmentList({required this.viewModel, required this.isCompleted});

  final AppointmentsViewModel viewModel;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.appointments.isEmpty) {
      return const Center(
        child: Text('No appointments found', style: TextStyle(color: Colors.white70)),
      );
    }
    return ListView.builder(
      itemCount: viewModel.appointments.length,
      itemBuilder: (context, index) {
        final AppointmentDto appointment = viewModel.appointments[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Card(
            color: AppColors.darkSurface,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(child: CachedNetworkImage(imageUrl: viewModel.imageUrlFor(appointment))),
              title: Text(
                viewModel.barberNameFor(appointment),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${viewModel.dateFor(appointment)}',
                      style: const TextStyle(color: Colors.white70)),
                  Text('Time: ${viewModel.timeFor(appointment)}',
                      style: const TextStyle(color: Colors.white70)),
                  Text('Service: ${viewModel.serviceNameFor(appointment)}',
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
              trailing: isCompleted
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : IconButton(
                      icon: const Icon(Icons.cancel),
                      color: Colors.red,
                      onPressed: () {},
                    ),
            ),
          ),
        );
      },
    );
  }
}
