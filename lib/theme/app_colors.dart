import 'package:flutter/material.dart';

/// Centralized color palette. `seed` and `coral` are drawn from the two most
/// recurring accent colors already used across the app's home/detail
/// screens, kept as the deliberate "brand" anchors for the new Material 3
/// color scheme rather than the ad hoc per-screen hex values they replace.
class AppColors {
  AppColors._();

  static const Color seed = Color(0xFF4E295B);
  static const Color coral = Color(0xFFFF8573);
  static const Color navy = Color(0xFF323345);
  static const Color surfaceElevated = Color(0xFF3D3E52);

  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFEF5350);
}
