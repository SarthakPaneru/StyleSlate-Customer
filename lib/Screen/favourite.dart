import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_empty_state.dart';

class FavourtiePage extends StatelessWidget {
  const FavourtiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.favouritesTitle)),
      body: const AppEmptyState(
        icon: Icons.favorite_border,
        message: AppStrings.favouritesEmpty,
      ),
    );
  }
}
