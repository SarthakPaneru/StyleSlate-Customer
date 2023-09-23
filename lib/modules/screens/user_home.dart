import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/modules/screens/categories_bubble.dart';
import 'package:hamro_barber_mobile/widgets/barberSelection.dart';
import 'package:geolocator/geolocator.dart';


import 'barber_type.dart';
import 'categories.dart';
import 'hometitle.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final List<String> Categories = [
    "Hairstyle",
    "Saving",
    "Treatment",
    "coloring",
    "Custom"
  ];

  final List barberType = [
    ["Hair style", true],
    ["Beard", false],
    ["colouring", false]
  ];

  void barberTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < barberType.length; i++) {
        barberType[i][1] = false;
      }
      barberType[index][1] = true;
    });
  }

  final _textController = TextEditingController();
  String userPost = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323345),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  // greetings row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Sarthak!",
                            style: TextStyle(
                              color: Color(0xffbfa58c),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Your location',
                            style: TextStyle(color: Color(0xff616274)),
                          )
                        ],
                      ),
                      // Notification
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.notifications, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Find Your Barber',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Clear the text that is typed
                        _textController.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
            ),
            // how do you feel?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // 4 different faces
            Column(
              children: [
                Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesBubble(text: Categories[index], imagePath: '/home/clay/Projects/Hamrobarber/lib/assets/images/categories/categories${index}.jpg',);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recommended Barbers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: BarberSelection(),
            ),
          ],
        ),
      ),
    );
  }
}
