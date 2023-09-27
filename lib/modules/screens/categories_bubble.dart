import 'package:flutter/material.dart';

class CategoriesBubble extends StatelessWidget {
  final String text;
  final int index;

  CategoriesBubble({required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[400],
          ),
          child: ClipOval(
              child: Image.asset(
                  'lib/assets/images/categories/categories$index.jpg')),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ]),
    );
  }
}
