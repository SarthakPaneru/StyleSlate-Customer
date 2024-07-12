import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/core/auth/forgot_password_update.dart';
import 'package:http/http.dart' as http;

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final ApiRequests _apiRequests = ApiRequests();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isLoading = false;
  String? _emailError;

  static const Color backgroundColor = Color(0xFF323345);
  static const Color accentColor = Color(0xFF8B8FA7);
  static const Color textColor = Color(0xFFE0E0E0);
  static const Color buttonColor = Color(0xFF4A4D64);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.forward();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      if (_emailController.text.isEmpty) {
        _emailError = 'Email is required';
      } else if (!EmailValidator.validate(_emailController.text)) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red[700] : accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          textColor: Colors.white,
        ),
      ),
    );
  }

  void _forgotpassword() async {
    if (_emailError != null) {
      _showSnackBar(_emailError!, isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      http.Response response =
          await _apiRequests.forgotPassword(_emailController.text.trim());
      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                const ForgotChangePasswordScreen(),
          ),
        );
      } else {
        _showSnackBar('An error occurred. Please try again later.',
            isError: true);
      }
    } catch (e) {
      _showSnackBar('Network error. Please check your connection.',
          isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Forget Password',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              ScaleTransition(
                scale: _animation,
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: accentColor.withOpacity(0.5), width: 2),
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    size: 80,
                    color: accentColor.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Forgot Your Password?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: textColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter your email address to receive a verification code.',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor.withOpacity(0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                  prefixIcon:
                      Icon(Icons.email, color: accentColor.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: accentColor.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: accentColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: accentColor.withOpacity(0.3)),
                  ),
                  filled: true,
                  fillColor: buttonColor.withOpacity(0.3),
                  errorText: _emailError,
                  errorStyle: TextStyle(color: Colors.red[300]),
                ),
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading ? null : _forgotpassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  elevation: 0,
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: textColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Send Code',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
