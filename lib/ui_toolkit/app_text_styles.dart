import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';

/// Real type scale superseding `widgets/styles.dart`'s cryptically-named
/// `AppStyle` (e.g. `m12b` was actually fontSize 30).
abstract class AppTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyOnPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.onPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle link = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );
}
