import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_shimmer.dart';

/// Skeleton matching DetailScreen's layout: hero image, name/rating row,
/// and a handful of service rows.
class DetailScreenShimmer extends StatelessWidget {
  const DetailScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerBox(width: double.infinity, height: 220, borderRadius: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerBox(width: 160, height: 20),
                    SizedBox(height: 8),
                    ShimmerBox(width: 80, height: 14),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ShimmerBox(width: 140, height: 16),
                          ShimmerBox(width: 60, height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
