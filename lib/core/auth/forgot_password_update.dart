import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';

import 'package:hamro_barber_mobile/config/api_service.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';
import 'package:http/http.dart' as http;

class ForgotChangePasswordScreen extends StatefulWidget {
  const ForgotChangePasswordScreen({super.key});

  @override
  _ForgotChangePasswordScreenState createState() =>
      _ForgotChangePasswordScreenState();
}

class _ForgotChangePasswordScreenState
    extends State<ForgotChangePasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  final ApiRequests _apiRequests = ApiRequests();

  @override
  void initState() {
    super.initState();
    // _apiService.get('/test');
  }

  void _changePassword() async {
    String email = _emailController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String otp = _otpController.text;

    // Perform validation
    if (email.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
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
    http.Response response = await _apiRequests.forgotChangePassword(
        email, newPassword, confirmPassword, otp);
    // print('done');

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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Login();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
      // Clear the text fields
    _emailController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
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
              controller: _emailController,
              obscureText: false,
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
                labelText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
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
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'New Password',
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
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
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: _otpController,
              obscureText: true,
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
                labelText: 'OTP',
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 34, 34, 46),
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
