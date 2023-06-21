import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Orientaion extends StatelessWidget {
  const Orientaion({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container();
  }
}