import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/core/auth/register.dart';
import 'package:hamro_barber_mobile/widgets/colors.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
import 'package:hamro_barber_mobile/widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isEmailValid = true;
  bool isPasswordValid = true;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    String email = _emailController.text.trim();
    setState(() {
      isEmailValid = EmailValidator.validate(email);
    });
  }

  void _validatePassword() {
    String password = _passwordController.text;
    setState(() {
      isPasswordValid = _validatePasswordStrength(password);
    });
  }

  bool _validatePasswordStrength(String password) {
    // Password validation logic goes here
    // Return true if password meets the criteria, otherwise false
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void _login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty || !isEmailValid || !isPasswordValid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields with valid inputs.'),
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

    // Login logic goes here

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const HomePage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: PrimaryColors.primarybrown,
            title: const Text('LoginSection'),
            automaticallyImplyLeading: false,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
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
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: PrimaryColors.primarybrown,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _emailController,
                    obscureText: false,
                    onChanged: (_) => _validateEmail(),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isEmailValid ? Colors.grey.shade400 : Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                      helperText: isEmailValid ? null : 'Invalid email',
                      helperStyle: TextStyle(
                        color: isEmailValid ? Colors.grey[500] : Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: passwordVisible,
                    onChanged: (_) => _validatePassword(),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isPasswordValid ? Colors.grey.shade400 : Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      helperText: isPasswordValid
                          ? 'Password must contain at least 8 characters, a capital letter, a number, and a special character.'
                          : 'Invalid password',
                      helperStyle: TextStyle(
                        color: isPasswordValid ? Colors.grey[500] : Colors.red,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        backgroundColor: PrimaryColors.primarybrown,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.restart_alt),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle forgot password logic or navigation here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 20,
                        color: PrimaryColors.primarybrown,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Register();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "Don't have an Account? Register Here",
                      style: TextStyle(
                        fontSize: 20,
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
