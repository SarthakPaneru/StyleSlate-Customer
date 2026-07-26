import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'onboarding_slide.dart';

class WalkThroughThree extends StatelessWidget {
  const WalkThroughThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingSlide(
      icon: Icons.chat_bubble_outline,
      title: AppStrings.onboardingSlide3Title,
      description: AppStrings.onboardingSlide3Description,
    );
  }
}
