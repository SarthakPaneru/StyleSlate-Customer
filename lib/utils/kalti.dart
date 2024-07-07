import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiInitializer extends StatelessWidget {
  final Widget child;

  KhaltiInitializer({required this.child});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey:
          'test_public_key_9a85b4d4f8ee4a00ab435d76955936a6', // Replace with your actual public key
      builder: (context, navigatorKey) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NP'),
          ],
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
            // Other localizations delegates
          ],
          home: child,
        );
      },
    );
  }
}
