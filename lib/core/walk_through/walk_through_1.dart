import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'onboarding_slide.dart';

class WalkThroughOne extends StatelessWidget {
  const WalkThroughOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingSlide(
      icon: Icons.search,
      title: AppStrings.onboardingSlide1Title,
      description: AppStrings.onboardingSlide1Description,
    );
  }
}
