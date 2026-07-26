import 'package:flutter/material.dart';

/// Brand mark used at the top of the auth screens: a soft gradient halo
/// (seed → coral, matching the rest of the app's accent pairing) behind a
/// clean circular logo badge.
class AppBrandLogo extends StatelessWidget {
  const AppBrandLogo({super.key, this.size = 88});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: 0.35),
            colorScheme.secondary.withValues(alpha: 0.35),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withValues(alpha: 0.25),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.surface,
        ),
        padding: EdgeInsets.all(size * 0.16),
        child: Image.asset(
          'lib/assets/images/barberlogo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
