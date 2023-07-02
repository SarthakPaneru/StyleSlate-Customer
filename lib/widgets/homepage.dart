import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';
import 'package:hamro_barber_mobile/widgets/appbar.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final Token _token = Token();

  void initState() async {
    String? token = await _token.retrieveBearerToken();
    if (token!.isEmpty) {
      print('Empty token');
    } else {
      print('Retreived token: ${token}');
    }
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            title: 'Homepage',
            onpressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
