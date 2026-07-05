import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';

import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool passwordNotVisible1 = true;
  bool passwordNotVisible2 = true;
  bool passwordNotVisible3 = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  final ApiRequests _apiRequests = ApiRequests();

  @override
  void initState() {
    super.initState();
  }

  void _changePassword() async {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Perform validation
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      // Show an error message if any field is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (newPassword != confirmPassword) {
      // Show an error message if new password and confirm password don't match
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('New password and confirm password must match.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // TODO: Perform the password change logic here
    try {
      http.Response response = await _apiRequests.updatePassword(
          currentPassword, newPassword, confirmPassword);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Password changed successfully.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        // Clear the text fields
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      }
    } catch (e) {
      print('Error updating password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _currentPasswordController,
              obscureText: passwordNotVisible1,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 66, 62, 62)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.transparent,
                filled: true,
                labelText: 'Current Password',
                // labelStyle: const TextStyle(color: Colors.white54),
                hintStyle: const TextStyle(color: Colors.blueAccent),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordNotVisible1 = !passwordNotVisible1;
                    });
                  },
                  icon: Icon(passwordNotVisible1
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: passwordNotVisible2,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 66, 62, 62)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.transparent,
                filled: true,
                hintStyle: const TextStyle(color: Colors.white),
                labelText: 'New Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordNotVisible2 = !passwordNotVisible2;
                    });
                  },
                  icon: Icon(passwordNotVisible2
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: passwordNotVisible3,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 66, 62, 62)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.transparent,
                filled: true,
                hintStyle: const TextStyle(color: Colors.white),
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordNotVisible3 = !passwordNotVisible3;
                    });
                  },
                  icon: Icon(passwordNotVisible3
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromARGB(255, 34, 34, 46),
                ),
              ),
              onPressed: _changePassword,
              child: const Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
