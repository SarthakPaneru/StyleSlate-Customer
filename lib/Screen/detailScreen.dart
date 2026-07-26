import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heart_toggle/heart_toggle.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/barbers/barber_repository_factory.dart';
import 'package:hamro_barber_mobile/features/barber_detail/view/detail_screen_shimmer.dart';
import 'package:hamro_barber_mobile/features/barber_detail/viewmodel/barber_detail_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'booking page.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.barberId});

  final int barberId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BarberDetailViewModel(createBarberRepository())..load(barberId),
      child: _DetailView(barberId: barberId),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({required this.barberId});

  final int barberId;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BarberDetailViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    if (viewModel.status == ViewStatus.loading) {
      return const DetailScreenShimmer();
    }
    if (viewModel.status == ViewStatus.error || viewModel.barber == null) {
      return Scaffold(
        appBar: AppBar(),
        body: AppEmptyState(
          icon: Icons.wifi_off,
          message: viewModel.errorMessage ?? AppStrings.detailLoadFailed,
          onRetry: () => viewModel.load(barberId),
        ),
      );
    }

    final barber = viewModel.barber!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: viewModel.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Icon(Icons.person, size: 80),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person, size: 80),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: HeartToggle(
                    props: HeartToggleProps(
                      size: 32,
                      passiveFillColor: Colors.grey[200]!,
                      ballColor: Colors.white,
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          barber.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: colorScheme.secondary),
                            const SizedBox(width: 4),
                            Text(
                              barber.rating.toString(),
                              style: TextStyle(color: colorScheme.secondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.detailServiceListTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: barber.services.length,
                itemBuilder: (context, index) {
                  final service = barber.services[index];
                  return ServiceTile(
                    serviceId: service.id,
                    barberId: barberId,
                    serviceName: service.serviceName,
                    serviceTimeInMinutes: service.serviceTimeInMinutes,
                    price: service.fee,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.serviceId,
    required this.barberId,
    required this.serviceName,
    required this.serviceTimeInMinutes,
    required this.price,
  });

  final int serviceId;
  final int barberId;
  final String serviceName;
  final String serviceTimeInMinutes;
  final String price;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.detailServiceDuration(serviceTimeInMinutes),
                  style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(
                    barberId: barberId,
                    serviceId: serviceId,
                  ),
                ),
              );
            },
            child: const Text(AppStrings.detailBookButton),
          ),
        ],
      ),
    );
  }
}
