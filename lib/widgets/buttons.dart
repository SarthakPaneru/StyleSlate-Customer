import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/widgets/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final void Function()? onpressed;

  const CustomButton({
    required this.onpressed,
    required this.label,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: PrimaryColors.primarybrown),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
