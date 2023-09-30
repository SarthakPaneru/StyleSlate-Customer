import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xff323345),
        title: const Text(
          'My account',
          style: TextStyle(color: Colors.white), // Set title text color to white
        ),
      ),
      backgroundColor: const Color(0xff323345), // Set background color here
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text(
              'Phone Number',
              style: TextStyle(color: Colors.white), // Set text color to orange
            ),
            leading: const Icon(
              Icons.phone,
              color: Colors.white, // Set icon color to orange
            ),
          ),
          ListTile(
            title: const Text(
              'Email',
              style: TextStyle(color: Colors.white), // Set text color to orange
            ),
            leading: const Icon(
              Icons.email,
              color: Colors.white, // Set icon color to orange
            ),
            onTap: () {
              // Handle "Email" tap
              // You can navigate or handle actions accordingly
            },
          ),
          ListTile(
            title: const Text(
              'Username',
              style: TextStyle(color: Colors.white), // Set text color to orange
            ),
            leading: const Icon(
              Icons.person,
              color: Colors.white, // Set icon color to orange
            ),
            onTap: () {
              // Handle "Username" tap
              // You can navigate or handle actions accordingly
            },
          ),
        ],
      ),
    );
  }
}
