import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/firebase_api.dart';
import 'package:hamro_barber_mobile/core/walk_through/splash_screen.dart';
import 'package:hamro_barber_mobile/firebase_options.dart';
import 'package:hamro_barber_mobile/utils/kalti.dart';
// Import the Khalti initializer

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseApi().initializeNotifications();
  runApp(
    const MyApp(), // Use MyApp instead of Mainpage
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiInitializer(
      child: Mainpage(), // Pass the Mainpage to KhaltiInitializer
    );
  }
}

class Mainpage extends StatelessWidget {
  const Mainpage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner:
          false, // Set debugShowCheckedModeBanner to false
      home: SplashScreen(),
    );
  }
}
