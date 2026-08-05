import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/Screen/detailScreen.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/utils/image_url_builder.dart';
import 'package:hamro_barber_mobile/data/barbers/models/nearest_barber_model.dart';
import 'package:hamro_barber_mobile/theme/app_colors.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_avatar_image.dart';

class FavourtiePage extends StatelessWidget {
  const FavourtiePage({super.key});

  // ==========================================================================
  // TEMPORARY -- DEBUG-ONLY MOCK DATA for design review.
  // There is no favourites backend yet -- this list is not real.
  // DO NOT remove until told to. Only shows in debug builds (kDebugMode).
  // ==========================================================================
  static const _mockFavourites = [
    NearestBarberModel(
      id: 9001,
      distance: 1.2,
      user: NearestBarberUser(
          id: 9001, firstName: 'Prajwal', lastName: 'Shrestha'),
    ),
    NearestBarberModel(
      id: 9002,
      distance: 2.8,
      user: NearestBarberUser(id: 9002, firstName: 'Sagar', lastName: 'Thapa'),
    ),
    NearestBarberModel(
      id: 9003,
      distance: 0.6,
      user: NearestBarberUser(
          id: 9003, firstName: 'Bikash', lastName: 'Gurung'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.favouritesTitle)),
      body: kDebugMode ? _MockFavouritesList(barbers: _mockFavourites) : const AppEmptyState(
        icon: Icons.favorite_border,
        message: AppStrings.favouritesEmpty,
      ),
    );
  }
}

/// TEMPORARY -- DEBUG-ONLY. Renders [FavourtiePage]'s mock data; delete
/// alongside the mock list above once a real favourites backend exists.
class _MockFavouritesList extends StatelessWidget {
  const _MockFavouritesList({required this.barbers});

  final List<NearestBarberModel> barbers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: barbers.length,
      itemBuilder: (context, index) {
        final barber = barbers[index];
        return Card(
          color: AppColors.surfaceElevated,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: AppAvatarImage(
              imageUrl: ImageUrlBuilder.forUser(barber.user.id),
            ),
            title: Text(
              barber.fullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              AppStrings.distanceAway(barber.distance.toStringAsFixed(1)),
            ),
            trailing: const Icon(Icons.favorite, color: AppColors.coral),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(barberId: barber.id),
              ),
            ),
          ),
        );
      },
    );
  }
}
