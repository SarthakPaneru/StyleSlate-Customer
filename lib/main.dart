import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamro_barber_mobile/Screen/mapflutter.dart';
import 'package:hamro_barber_mobile/profile/profile_screen.dart';
import 'package:hamro_barber_mobile/widgets/colors.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';

void main() {

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mainpage(),
  ));
}

class Mainpage extends StatelessWidget {
  const Mainpage({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          centerTitle: true,
          backgroundColor: PrimaryColors.primarybrown,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              const SizedBox(height: 75),
              Container(
                margin: const EdgeInsets.all(20),
                child: Image.asset('lib/assets/images/barberlogo.png'),
              ),
              const Text(
                'कपाल काट्टने होईनत ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 45),
              FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: PrimaryColors.primarybrown,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Login();
                    },
                  ));
                },
                child: const Icon(Icons.arrow_forward_outlined, size: 28),
              ),
              const SizedBox(height: 10),
              const Text(
                "Let's Explore",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
