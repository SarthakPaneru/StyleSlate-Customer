
import 'package:flutter/material.dart';
import 'colors.dart';

class InputField extends StatelessWidget {
  final String hinttext;
  final bool obscuretext;
  final IconData? icon;
 

  const InputField({
    required this.hinttext,
    required this.obscuretext,
    required this.icon,
    
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: TextField(
          cursorHeight: 18,
          cursorColor: PrimaryColors.primarybrown,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: PrimaryColors.primarybrown,
            ),
            hintText: hinttext,
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: PrimaryColors.primarybrown,
            )),
          ),
          obscureText: obscuretext),
    );
  }
}
