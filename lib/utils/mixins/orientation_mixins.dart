import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Orientations {
  static void setPreferredOrientations() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}