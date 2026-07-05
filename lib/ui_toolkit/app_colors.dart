import 'package:flutter/material.dart';

/// Single source of truth for app colors, superseding the previously
/// competing `widgets/colors.dart`, `widgets/config.dart` (`Config.primaryColor`)
/// and `profile/constants.dart` (`kPrimaryColor`) definitions.
abstract class AppColors {
  static const Color primary = Color(0xFF795548); // Colors.brown.shade500
  static const Color primaryDark = Color(0xFF5D4037); // Colors.brown.shade700
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFEEEEEE); // Colors.grey.shade200
  static const Color border = Color(0xFFBDBDBD); // Colors.grey.shade400
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF9E9E9E); // Colors.grey.shade500
  static const Color onPrimary = Colors.white;
  static const Color error = Color(0xFFD32F2F);

  /// Dark dashboard background used consistently across the Home/Favorites/
  /// Appointments tabs in the original app (was the literal `Color(0xff323345)`
  /// scattered across `user_home.dart`, `favourite.dart`, `appointment.dart`,
  /// `barberSelection.dart` and `homepage.dart`'s bottom nav).
  static const Color darkSurface = Color(0xFF323345);
}
