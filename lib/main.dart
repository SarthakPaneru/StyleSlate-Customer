import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app.router.dart';
import 'package:hamro_barber_mobile/app/app_dependencies.dart';
import 'package:hamro_barber_mobile/config/firebase_api.dart';
import 'package:hamro_barber_mobile/core/walk_through/splash_screen.dart';
import 'package:hamro_barber_mobile/firebase_options.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_theme.dart';
import 'package:hamro_barber_mobile/utils/kalti.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseApi().initializeNotifications();

  await setupLocator();
  registerAppDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiInitializer(
      child: MaterialApp(
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [StackedService.routeObserver],
        onGenerateRoute: StackedRouter().onGenerateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
