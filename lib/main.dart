import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/config/firebase_api.dart';
import 'package:hamro_barber_mobile/core/auth/current_user_state.dart';
import 'package:hamro_barber_mobile/core/walk_through/splash_screen.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository_factory.dart';
import 'package:hamro_barber_mobile/firebase_options.dart';
import 'package:hamro_barber_mobile/utils/kalti.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseApi().initializeNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CurrentUserState(createProfileRepository()),
      child: const KhaltiInitializer(child: SplashScreen()),
    );
  }
}
