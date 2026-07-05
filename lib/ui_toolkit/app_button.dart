import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/ui_toolkit/app_colors.dart';

/// Single button widget superseding `widgets/button.dart`, `widgets/buttons.dart`
/// and `widgets/register_my_button.dart`.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.onPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label, style: const TextStyle(fontSize: 18)),
                  if (icon != null) ...[
                    const SizedBox(width: 10),
                    Icon(icon),
                  ],
                ],
              ),
      ),
    );
  }
}

/// Text-only link button, e.g. "Forgot Password?" / "Don't have an account?".
class AppLinkButton extends StatelessWidget {
  const AppLinkButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: AppColors.primary),
      ),
    );
  }
}
