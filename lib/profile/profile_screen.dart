import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';

import '/profile/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.profileTitle),
      ),
      body: const Body(),
    );
  }
}
