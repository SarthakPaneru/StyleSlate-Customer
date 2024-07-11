import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApiRequests _apiRequests = ApiRequests();

  @override
  void initState() {
    super.initState();
    //check login status

    Future.delayed(const Duration(seconds: 3), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    String? token = await Token().retrieveBearerToken();
    if (token != null) {
      http.Response response = await _apiRequests.getLoggedInUser();
      if (response.statusCode == 200) {
        openDashBoard();
      }
    } else {
      openLogin();
    }
  }

  void openDashBoard() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void openLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('lib/assets/images/barberlogo.png')),
    );
  }
}
