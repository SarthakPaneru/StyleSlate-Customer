import 'package:flutter/material.dart';

class CategoriesBubble extends StatelessWidget {
  final String text;

  CategoriesBubble({required this.text});

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
          child: ClipOval(child: Image.asset('/home/clay/Projects/Hamrobarber/lib/assets/images/categories/coloring.jpg')),

        ),
        SizedBox(
          height: 10,
        ),
        Text(text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),)
      ]),
    );
  }
}
