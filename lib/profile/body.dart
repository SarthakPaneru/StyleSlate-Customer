import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/features/auth/view/login_screen.dart';
import 'package:hamro_barber_mobile/core/auth/current_user_state.dart';
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
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePage(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: AppStrings.menuMyAccount,
              icon: "lib/assets/images/User Icon.svg",
              press: () {
                navigateTOMyaccount(context);
              },
            ),
            ProfileMenu(
              text: AppStrings.menuNotifications,
              icon: "lib/assets/images/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: AppStrings.menuSettings,
              icon: "lib/assets/images/Settings.svg",
              press: () {
                navigateTOChangePassword(context);
              },
            ),
            ProfileMenu(
              text: AppStrings.menuHelpCenter,
              icon: "lib/assets/images/Question mark.svg",
              press: () {
                navigateTOHelpcenter(context);
              },
            ),
            ProfileMenu(
              text: AppStrings.menuLogOut,
              icon: "lib/assets/images/Log out.svg",
              press: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(AppStrings.logOutConfirmMessage),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(AppStrings.no),
                        ),
                        TextButton(
                          onPressed: () async {
                            await _logout(context);
                          },
                          child: const Text(AppStrings.yes),
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

    if (!context.mounted) return;
    // Reset the shared user profile so the next login never briefly
    // shows this account's cached name/email.
    context.read<CurrentUserState>().clear();

    // Navigate to the Login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
