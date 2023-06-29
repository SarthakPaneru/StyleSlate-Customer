import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';
import 'package:hamro_barber_mobile/widgets/appbar.dart';
import 'package:hamro_barber_mobile/widgets/buttons.dart';
import 'package:hamro_barber_mobile/widgets/colors.dart';
import 'package:hamro_barber_mobile/widgets/textfield.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            title: 'Register New User',
            onpressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(2),
                    height: 150,
                    width: 150,
                    child: Image.asset('lib/assets/images/barberlogo.png'),
                  ),
                  Text(
                    'Regiser',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: PrimaryColors.primarybrown,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const InputField(
                    hinttext: 'First Name',
                    obscuretext: false,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  const InputField(
                    hinttext: 'Last Name',
                    obscuretext: false,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  const InputField(
                    hinttext: 'Email',
                    obscuretext: false,
                    icon: Icons.mail,
                  ),
                  const SizedBox(height: 15),
                  const InputField(
                    hinttext: 'Password',
                    obscuretext: true,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 15),
                  const InputField(
                    hinttext: 'Confirm Password',
                    obscuretext: true,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    label: 'Register',
                    icon: Icons.arrow_circle_right_sharp,
                    onpressed: () {},
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Login();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "Already have an Account? LogIn Here",
                      style: TextStyle(
                        fontSize: 17,
                        color: PrimaryColors.primarybrown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
