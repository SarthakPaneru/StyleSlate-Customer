import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_barber_mobile/app/app.locator.dart';
import 'package:hamro_barber_mobile/app/app_dependencies.dart';
import 'package:hamro_barber_mobile/features/auth/login_view.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_theme.dart';

void main() {
  setUp(() async {
    await setupLocator();
    registerAppDependencies();
  });

  tearDown(() => locator.reset());

  testWidgets('LoginView renders the login form', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const LoginView()));

    expect(find.text('Login'), findsWidgets);
    expect(find.text('Log in'), findsOneWidget);
  });
}
