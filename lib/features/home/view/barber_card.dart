import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/utils/image_url_builder.dart';
import 'package:hamro_barber_mobile/data/barbers/models/nearest_barber_model.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_avatar_image.dart';

class BarberCard extends StatelessWidget {
  const BarberCard({super.key, required this.barber, required this.onTap});

  final NearestBarberModel barber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAvatarImage(
              imageUrl: ImageUrlBuilder.forUser(barber.user.id),
              size: 100,
              borderRadius: BorderRadius.circular(16),
            ),
            const SizedBox(height: 8),
            Text(
              barber.fullName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              AppStrings.distanceAway(barber.distance.toStringAsFixed(1)),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.secondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
