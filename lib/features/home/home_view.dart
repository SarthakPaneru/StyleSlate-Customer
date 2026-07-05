import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/home/home_viewmodel.dart';
import 'package:hamro_barber_mobile/features/home/widgets/category_bubble.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.init();

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.darkSurface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${viewModel.firstName}',
                        style: const TextStyle(
                          color: Color(0xffbfa58c),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your location: ${viewModel.latitude}, ${viewModel.longitude}',
                        style: const TextStyle(color: Color(0xff616274)),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 18, right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.more_horiz, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HomeViewModel.categories.length,
                itemBuilder: (context, index) => CategoryBubble(
                  text: HomeViewModel.categories[index],
                  index: index,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18, top: 5, right: 13),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recommended Barbers',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(child: _BarberList(viewModel: viewModel)),
          ],
        ),
      ),
    );
  }
}

class _BarberList extends StatelessWidget {
  const _BarberList({required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoadingBarbers) {
      return const Center(child: CircularProgressIndicator(color: Colors.yellow));
    }
    if (viewModel.barbers.isEmpty) {
      return const Center(
        child: Text('No barbers found nearby', style: TextStyle(color: Colors.white70)),
      );
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.barbers.length,
        itemBuilder: (context, index) {
          final barber = viewModel.barbers[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => viewModel.openBarberDetail(barber.id!),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: viewModel.imageUrlFor(barber),
                      placeholder: (context, url) => const Icon(Icons.person, size: 80),
                      errorWidget: (context, url, error) => const Icon(Icons.person, size: 80),
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(viewModel.nameFor(barber), style: const TextStyle(color: Colors.yellow)),
                Text(
                  'km : ${barber.distance}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
