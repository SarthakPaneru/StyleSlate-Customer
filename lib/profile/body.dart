import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart'; // Import your Token class
import 'package:hamro_barber_mobile/profile/changepassword.dart';

import 'Myaccount.dart';
import 'helpcenterscreen.dart';
import 'profile.dart';
import 'profile_menu.dart';
// Import your Login screen

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff323345), // Set the background color here
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePage(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "lib/assets/images/User Icon.svg",
              press: () {
                navigateTOMyaccount(context);
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "lib/assets/images/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "lib/assets/images/Settings.svg",
              press: () {
                navigateTOChangePassword(context);
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "lib/assets/images/Question mark.svg",
              press: () {
                navigateTOHelpcenter(context);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "lib/assets/images/Log out.svg",
              press: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () async {
                            // Perform logout action
                            await _logout(context);
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigateTOChangePassword(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
  }

  void navigateTOHelpcenter(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HelpCenterScreen()));
  }

  void navigateTOMyaccount(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyAccountScreen()));
  }

  Future<void> _logout(BuildContext context) async {
    // Clear the stored token
    Token _token = Token();
    await _token.clearBearerToken();

    // Navigate to the Login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (Route<dynamic> route) => false,
    );
  }
}
