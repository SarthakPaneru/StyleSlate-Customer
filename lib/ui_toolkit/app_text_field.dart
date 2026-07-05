import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';

/// TextFormField wrapper (controller + validator) superseding the
/// non-validating `widgets/textfield.dart` `InputField`.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
    this.suffixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon,
        errorText: errorText,
        filled: true,
        fillColor: AppColors.surface,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorText == null ? AppColors.border : AppColors.error,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
