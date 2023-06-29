import 'package:flutter/material.dart';

import '/profile/body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Body(),
    );
  }
}
