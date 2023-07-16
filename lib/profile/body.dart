import 'package:flutter/material.dart';
import '/profile/changepassword.dart';
import 'profile_menu.dart';
import 'profile.dart';
import 'helpcenterscreen.dart';
import 'Myaccount.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
           ProfilePage(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "lib/assets/images/User Icon.svg",
            press: () => {
              navigateTOMyaccount(context)
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
            press: () =>{navigateTOChangePassword(context)},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "lib/assets/images/Question mark.svg",
            press: () =>{navigateTOHelpcenter(context)},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "lib/assets/images/Log out.svg",
            press: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text('Are you sure.'),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text(
                          'NO',
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
    );
  }

  void navigateTOChangePassword(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
  }
void navigateTOHelpcenter(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HelpCenterScreen()));
  }
  void navigateTOMyaccount(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyAccountScreen()));
  }

}
