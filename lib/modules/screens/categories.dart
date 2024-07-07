import 'package:flutter/material.dart';



class Category extends StatelessWidget {
  final String categoryFace;
  const Category({super.key,required this.categoryFace});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff867d6c),
        borderRadius: BorderRadius.circular(12),
      ),
      
      padding: const EdgeInsets.all(5),
      width: 100,
      child: Center(
        child: Image.network(
            'https://c8.alamy.com/comp/KFEAFB/male-avatar-profile-icon-round-man-face-KFEAFB.jpg',
            ),
      ),
    );
  }
}
