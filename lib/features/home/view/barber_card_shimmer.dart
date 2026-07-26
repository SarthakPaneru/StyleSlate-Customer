import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_shimmer.dart';

/// Skeleton matching [BarberCard]'s shape, shown while the barber list loads.
class BarberCardShimmer extends StatelessWidget {
  const BarberCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(width: 140, height: 100, borderRadius: 16),
            const SizedBox(height: 8),
            const ShimmerBox(width: 100, height: 14),
            const SizedBox(height: 6),
            const ShimmerBox(width: 70, height: 12),
          ],
        ),
      ),
    );
  }
}
