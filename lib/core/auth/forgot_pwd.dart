import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/widgets/appbar.dart';
import 'package:hamro_barber_mobile/widgets/buttons.dart';
import 'package:hamro_barber_mobile/widgets/colors.dart';
import 'package:email_validator/email_validator.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController
        .dispose(); // Dispose of the controller when no longer needed
    super.dispose();
  }

  void _forgotpassword() {
    String email = _emailController.text;
    final bool isValid = EmailValidator.validate(_emailController.text.trim());

    if (email.isEmpty) {
      print('$email');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill  email address field .'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
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
    if (isValid == false) {
      print('$email');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please insert correct email address.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
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
  }

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
                  TextField(
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      labelText: 'Enter Email Address',
                      icon: const Icon(Icons.mail),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    label: 'Send Code',
                    icon: null,
                    onpressed: _forgotpassword,
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
