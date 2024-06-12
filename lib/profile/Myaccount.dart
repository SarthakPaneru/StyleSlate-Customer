import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String _email = '';

  String _phone = '';

  String _username = '';

  ApiRequests _apiRequests = ApiRequests();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAccountDetails();
  }

  _loadAccountDetails() async {
  try {
    final email = await Customer().retrieveCustomerEmail();
    final phone = await Customer().retrievePhone();
    final firstName = await Customer().retrieveFirstName();
    final lastName = await Customer().retrieveLastName();
    setState(() {
      _email = email!;
      _phone = phone!;
      _username = '$firstName $lastName';
    });
  } catch (e) {
    // Handle any errors here
    print('Error loading account details: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xff323345),
        title: const Text(
          'My account',
          style:
              TextStyle(color: Colors.white), // Set title text color to white
        ),
      ),
      backgroundColor: const Color(0xff323345), // Set background color here
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              _phone,
              style: TextStyle(color: Colors.white), // Set text color to orange
            ),
            leading: Icon(
              Icons.phone,
              color: Colors.white, // Set icon color to orange
            ),
          ),
          ListTile(
            title: Text(
              _email,
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
            title: Text(
              _username,
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
