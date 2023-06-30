import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/widgets/appbar.dart';
import 'package:hamro_barber_mobile/widgets/buttons.dart';
import 'package:hamro_barber_mobile/widgets/colors.dart';
import 'package:hamro_barber_mobile/widgets/textfield.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            title: 'Forget Password',
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
                children: [
                  const SizedBox(height: 25),
                  const SizedBox(height: 25),
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      color: PrimaryColors.primarybrown,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.lock_outline,
                      size: 110,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 280,
                    child: Text(
                      'Please Enter Your Email Address To Receive a Verification Code.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: PrimaryColors.primarybrown),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const InputField(
                      hinttext: 'Enter Email Address',
                      obscuretext: false,
                      icon: Icons.mail),
                  const SizedBox(height: 15),
                  CustomButton(
                    label: 'Send Code',
                    icon: null,
                    onpressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
