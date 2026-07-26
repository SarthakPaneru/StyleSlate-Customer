import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:hamro_barber_mobile/theme/app_theme.dart';

/// This owns the app's single MaterialApp (KhaltiScope's builder is where
/// khalti_flutter expects the navigatorKey to be attached). Do not wrap
/// [child] in a second MaterialApp — nested MaterialApps means anything
/// that defaults to the root navigator (e.g. showDialog's useRootNavigator)
/// escapes into an untheemed app instance.
class KhaltiInitializer extends StatelessWidget {
  const KhaltiInitializer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey:
          'test_public_key_9a85b4d4f8ee4a00ab435d76955936a6', // Replace with your actual public key
      builder: (context, navigatorKey) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          theme: AppTheme.dark(),
          debugShowCheckedModeBanner: false,
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
