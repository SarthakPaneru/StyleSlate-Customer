import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hamro_barber_mobile/theme/app_colors.dart';

/// Wraps [child] in the app's standard shimmer sheen. Use [ShimmerBox] for
/// the common case of a plain rounded-rectangle placeholder.
class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceElevated,
      highlightColor: AppColors.surfaceElevated.withValues(alpha: 0.4),
      child: child,
    );
  }
}

/// A single placeholder shape. Nest one or more of these inside a shared
/// [AppShimmer] ancestor so the highlight sweeps across them in sync —
/// don't wrap each box in its own [AppShimmer].
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height = 14,
    this.borderRadius = 8,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Skeleton for a leading-avatar list row (appointment/barber list items).
class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const ShimmerBox(width: 48, height: 48, borderRadius: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBox(width: 120, height: 14),
                  SizedBox(height: 8),
                  ShimmerBox(width: 180, height: 12),
                  SizedBox(height: 6),
                  ShimmerBox(width: 100, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
