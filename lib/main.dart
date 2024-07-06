import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/firebase_api.dart';
import 'package:hamro_barber_mobile/core/walk_through/splash_screen.dart';
import 'package:hamro_barber_mobile/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseApi().initializeNotifications();
  runApp(
    const Mainpage(),
  );
}

class Mainpage extends StatelessWidget {
  const Mainpage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
