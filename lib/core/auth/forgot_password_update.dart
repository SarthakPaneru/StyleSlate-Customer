import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
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

  final ApiRequests _apiRequests = ApiRequests();

  bool _isEmailValid = false;
  bool _isNewPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  bool _isOtpValid = false;

  static const Color backgroundColor = Color(0xFF323345);
  static const Color accentColor = Color(0xFFE1BEE7);
  static const Color textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _newPasswordController.addListener(_validateNewPassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
    _otpController.addListener(_validateOtp);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      _isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
          .hasMatch(_emailController.text);
    });
  }

  void _validateNewPassword() {
    setState(() {
      _isNewPasswordValid = _newPasswordController.text.length >= 8;
    });
  }

  void _validateConfirmPassword() {
    setState(() {
      _isConfirmPasswordValid =
          _confirmPasswordController.text == _newPasswordController.text;
    });
  }

  void _validateOtp() {
    setState(() {
      _isOtpValid = _otpController.text.length == 6;
    });
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _changePassword() async {
    if (!_isEmailValid ||
        !_isNewPasswordValid ||
        !_isConfirmPasswordValid ||
        !_isOtpValid) {
      _showSnackBar('Please fill in all fields correctly.');
      return;
    }

    try {
      http.Response response = await _apiRequests.forgotChangePassword(
          _emailController.text,
          _newPasswordController.text,
          _confirmPasswordController.text,
          _otpController.text);

      if (response.statusCode == 200) {
        _showSnackBar('Password changed successfully.', isError: false);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => const Login(),
            ),
          );
        });
      } else {
        _showSnackBar('Error: ${response.body}');
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  isValid: _isEmailValid,
                  errorText: 'Enter a valid email address',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _newPasswordController,
                  label: 'New Password',
                  isValid: _isNewPasswordValid,
                  errorText: 'Password must be at least 8 characters long',
                  obscureText: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  isValid: _isConfirmPasswordValid,
                  errorText: 'Passwords do not match',
                  obscureText: true,
                  icon: Icons.lock_outline,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _otpController,
                  label: 'OTP',
                  isValid: _isOtpValid,
                  errorText: 'OTP must be 6 digits',
                  keyboardType: TextInputType.number,
                  icon: Icons.security,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  onPressed: _changePassword,
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isValid,
    required String errorText,
    bool obscureText = false,
    TextInputType? keyboardType,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: accentColor.withOpacity(0.8)),
          prefixIcon: Icon(icon, color: accentColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: accentColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          errorText: controller.text.isNotEmpty && !isValid ? errorText : null,
          errorStyle: TextStyle(color: Colors.red[300]),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
