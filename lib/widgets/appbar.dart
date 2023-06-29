import 'package:flutter/material.dart';
import 'colors.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final void Function()? onpressed;
  const MyAppBar({
    required this.title,
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: onpressed, icon: const Icon(Icons.arrow_back_ios)),
      backgroundColor: PrimaryColors.primarybrown,
      title: Text(title),
    );
  }
}
