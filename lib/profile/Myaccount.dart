import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'My account',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Phone Number',
            style: TextStyle(color: Colors.orange),),
            leading: const Icon(Icons.email),
          ),
          ListTile(
            title: const Text('Email',
            style: TextStyle(color: Colors.orange),),
            leading: const Icon(Icons.question_answer),
            onTap: () {
              // Handle "FAQs" tap
              // You can navigate to a list of frequently asked questions
              // or show the answers directly in the app
            },
          ),
          ListTile(
            title: Text('Username',
            style: TextStyle(color: Colors.orange),),
            leading: Icon(Icons.description),
            onTap: () {
              // Handle "Terms and Conditions" tap
              // You can navigate to a screen displaying the terms and conditions
            },
          ),
          
        ],
      ),
    );
  }
}
