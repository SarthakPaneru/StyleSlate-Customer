import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_shimmer.dart';

/// Consistent avatar image with a shimmer-while-loading and person-icon
/// error state, replacing the same CachedNetworkImage boilerplate
/// duplicated across barber lists, appointment lists, and the profile
/// avatar.
class AppAvatarImage extends StatelessWidget {
  const AppAvatarImage({
    super.key,
    required this.imageUrl,
    this.size = 48,
    this.borderRadius,
  });

  final String imageUrl;
  final double size;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: size,
      height: size,
      placeholder: (context, url) => AppShimmer(
        child: ShimmerBox(width: size, height: size, borderRadius: size / 2),
      ),
      errorWidget: (context, url, error) => Icon(Icons.person, size: size * 0.6),
    );

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
      child: SizedBox(width: size, height: size, child: image),
    );
  }
}
