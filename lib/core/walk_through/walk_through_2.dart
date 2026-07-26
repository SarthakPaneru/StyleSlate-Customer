import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'onboarding_slide.dart';

class WalkThroughTwo extends StatelessWidget {
  const WalkThroughTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingSlide(
      icon: Icons.calendar_month,
      title: AppStrings.onboardingSlide2Title,
      description: AppStrings.onboardingSlide2Description,
    );
  }
}
