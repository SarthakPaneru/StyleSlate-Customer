import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/Screen/detailScreen.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/auth/current_user_state.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/barbers/barber_repository_factory.dart';
import 'package:hamro_barber_mobile/features/home/view/barber_card.dart';
import 'package:hamro_barber_mobile/features/home/view/barber_card_shimmer.dart';
import 'package:hamro_barber_mobile/features/home/view/barber_search_screen.dart';
import 'package:hamro_barber_mobile/features/home/viewmodel/home_view_model.dart';
import 'package:hamro_barber_mobile/modules/screens/categories_bubble.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'package:hamro_barber_mobile/ui_kit/navigation/app_section_header.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(createBarberRepository())..initialize(),
      child: const _UserHomeView(),
    );
  }
}

class _UserHomeView extends StatefulWidget {
  const _UserHomeView();

  @override
  State<_UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<_UserHomeView> {
  static const _categories = [
    AppStrings.categoryHaircut,
    AppStrings.categoryHairStyle,
    AppStrings.categoryBeard,
    AppStrings.categoryTreatment,
    AppStrings.categoryBeautySaloon,
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final currentUser = context.watch<CurrentUserState>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: viewModel.loadBarbers,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.homeGreeting(
                                currentUser.user?.firstName ?? ''),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _locationLabel(viewModel),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.notifications, color: colorScheme.onSurface),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Material(
                    color: colorScheme.onSurface.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BarberSearchScreen(barbers: viewModel.barbers),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          children: [
                            Icon(Icons.search,
                                color: colorScheme.onSurface.withValues(alpha: 0.6)),
                            const SizedBox(width: 12),
                            Text(
                              AppStrings.homeFindYourBarber,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const AppSectionHeader(title: AppStrings.homeCategorySectionTitle),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) => CategoriesBubble(
                      text: _categories[index],
                      index: index,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const AppSectionHeader(title: AppStrings.homeRecommendedBarbersTitle),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildBarberList(viewModel),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _locationLabel(HomeViewModel viewModel) {
    if (viewModel.placeName.isNotEmpty) return viewModel.placeName;
    final hasCoordinates = viewModel.latitude != 0 || viewModel.longitude != 0;
    return hasCoordinates
        ? AppStrings.homeLocationUnavailable
        : AppStrings.homeLocating;
  }

  Widget _buildBarberList(HomeViewModel viewModel) {
    if (viewModel.status == ViewStatus.loading) {
      return SizedBox(
        height: 190,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) => const BarberCardShimmer(),
        ),
      );
    }
    if (viewModel.status == ViewStatus.error) {
      return AppEmptyState(
        icon: Icons.wifi_off,
        message: viewModel.errorMessage ?? AppStrings.homeBarbersLoadFailed,
        onRetry: viewModel.loadBarbers,
      );
    }
    if (viewModel.barbers.isEmpty) {
      return const AppEmptyState(message: AppStrings.homeNoBarbersNearby);
    }
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.barbers.length,
        itemBuilder: (context, index) {
          final barber = viewModel.barbers[index];
          return BarberCard(
            barber: barber,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(barberId: barber.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
