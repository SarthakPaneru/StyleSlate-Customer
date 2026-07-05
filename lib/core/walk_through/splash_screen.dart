import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/auth/login_view.dart';
import 'package:hamro_barber_mobile/features/home/home_shell_view.dart';
import 'package:hamro_barber_mobile/services/token_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //check login status

    Future.delayed(const Duration(seconds: 3), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    String? token = await TokenService().retrieveBearerToken();
    if (token != null) {
      openDashBoard();
    } else {
      openLogin();
    }
  }

  void openDashBoard() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeShellView()));
  }

  void openLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('lib/assets/images/barberlogo.png')),
    );
  }
}
