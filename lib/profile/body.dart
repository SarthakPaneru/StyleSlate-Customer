import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';
import 'package:hamro_barber_mobile/profile/changepassword.dart';

import 'Myaccount.dart';
import 'helpcenterscreen.dart';
import 'profile.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff323345),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff323345),
            const Color(0xff323345).withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              const ProfilePage(),
              const SizedBox(height: 20),
              _buildProfileMenu(
                context,
                "My Account",
                "lib/assets/images/User Icon.svg",
                () => navigateTo(context, const MyAccountScreen()),
              ),
              _buildProfileMenu(
                context,
                "Notifications",
                "lib/assets/images/Bell.svg",
                () {},
              ),
              _buildProfileMenu(
                context,
                "Settings",
                "lib/assets/images/Settings.svg",
                () => navigateTo(context, const ChangePasswordScreen()),
              ),
              _buildProfileMenu(
                context,
                "Help Center",
                "lib/assets/images/Question mark.svg",
                () => navigateTo(context, const HelpCenterScreen()),
              ),
              _buildProfileMenu(
                context,
                "Log Out",
                "lib/assets/images/Log out.svg",
                () => _showLogoutDialog(context),
                isLogout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenu(
      BuildContext context, String text, String icon, VoidCallback press,
      {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isLogout
            ? Colors.red.withOpacity(0.1)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withOpacity(0.1)
                : const Color(0xFFF5F6F9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            color: isLogout ? Colors.red : const Color(0xFF323345),
            width: 18,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.white,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isLogout ? Colors.red : Colors.white,
          size: 18,
        ),
        onTap: press,
      ),
    );
  }

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff323345),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Logout', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to log out?',
              style: TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    Token _token = Token();
    await _token.clearBearerToken();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (Route<dynamic> route) => false,
    );
  }
}
