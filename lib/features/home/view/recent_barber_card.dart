import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/core/utils/image_url_builder.dart';
import 'package:hamro_barber_mobile/data/appointments/models/appointment_model.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_avatar_image.dart';

/// A previously-visited barber, shown in the "Book Again" shelf. Tapping
/// it goes straight to that barber's own detail/booking screen, the same
/// quick-reorder pattern food-delivery apps use for past orders.
class RecentBarberCard extends StatelessWidget {
  const RecentBarberCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });

  final AppointmentModel appointment;
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
              imageUrl: ImageUrlBuilder.forUser(appointment.barberUserId),
              size: 100,
              borderRadius: BorderRadius.circular(16),
            ),
            const SizedBox(height: 8),
            Text(
              appointment.barberName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              appointment.serviceName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
