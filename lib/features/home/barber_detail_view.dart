import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/home/barber_detail_viewmodel.dart';
import 'package:hamro_barber_mobile/features/home/models/service_dto.dart';
import 'package:stacked/stacked.dart';

class BarberDetailView extends StackedView<BarberDetailViewModel> {
  const BarberDetailView({super.key, required this.barberId});

  final int barberId;

  @override
  BarberDetailViewModel viewModelBuilder(BuildContext context) => BarberDetailViewModel(barberId);

  @override
  void onViewModelReady(BarberDetailViewModel viewModel) => viewModel.init();

  @override
  Widget builder(BuildContext context, BarberDetailViewModel viewModel, Widget? child) {
    if (viewModel.isBusy || viewModel.barber == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final barber = viewModel.barber!;
    final services = barber.services ?? const <ServiceDto>[];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: viewModel.imageUrl,
                      placeholder: (context, url) => const Icon(Icons.person, size: 80),
                      errorWidget: (context, url, error) => const Icon(Icons.person, size: 80),
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barber.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Color(0xffFF8573)),
                          const SizedBox(width: 5),
                          Text(
                            '${barber.rating ?? '-'}',
                            style: const TextStyle(color: Color(0xffFF8573)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text('Service List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _ServiceTile(service: service, onBook: () => viewModel.bookService(service.id!));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.service, required this.onBook});

  final ServiceDto service;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
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
                  service.serviceName ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text('${service.serviceTimeInMinutes} Min', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(service.fee ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(width: 10),
          MaterialButton(
            onPressed: onBook,
            color: const Color(0xffFF8573),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Text('Book', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
