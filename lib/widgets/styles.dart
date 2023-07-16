import 'package:flutter/material.dart';

abstract class AppStyle {
  static TextStyle m12b = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle m12bt = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.65));

  static TextStyle m12w = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white);

  static TextStyle r12w = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white);

  static TextStyle r10wt = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.75));

  static TextStyle b32w = const TextStyle(
      fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white);
}
