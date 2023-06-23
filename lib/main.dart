import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/utils/mixins/orientation_mixins.dart';
import 'core/auth/login.dart';

void main() {
  Orientations.setPreferredOrientations();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Orientaion();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
