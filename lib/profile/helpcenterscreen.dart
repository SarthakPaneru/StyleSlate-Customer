import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xff323345),
        title: const Text(
          'Help Center',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xff323345), // Set the background color here
      body: ListView(
        children: <Widget>[
          const ListTile(
            title: Text(
              'Contact Us',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
            leading: Icon(Icons.email, color: Colors.white), // Set icon color
          ),
          ListTile(
            title: const Text(
              'FAQs',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
            leading: const Icon(
              Icons.question_answer,
              color: Colors.white, // Set icon color
            ),
            onTap: () {
              // Handle "FAQs" tap
              // You can navigate to a list of frequently asked questions
              // or show the answers directly in the app
            },
          ),
          ListTile(
            title: const Text(
              'Terms and Conditions',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
            leading: const Icon(
              Icons.description,
              color: Colors.white, // Set icon color
            ),
            onTap: () {
              // Handle "Terms and Conditions" tap
              // You can navigate to a screen displaying the terms and conditions
            },
          ),
          ListTile(
            title: const Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
            leading: const Icon(
              Icons.lock,
              color: Colors.white, // Set icon color
            ),
            onTap: () {
              // Handle "Privacy Policy" tap
              // You can navigate to a screen displaying the privacy policy
            },
          ),
        ],
      ),
    );
  }
}
