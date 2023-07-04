import 'package:flutter/material.dart';
import 'categories.dart';
import 'barber_type.dart';
import 'hometitle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List barberType = [
    [
      "Hair style",
      true,
    ],
    [
      "Beard",
      false,
    ],
    [
      "colouring",
      false,
    ]
  ];
  void barberTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < barberType.length; i++) {
        barberType[i][1] = false;
      }
      barberType[index][1] = true;
    });
  }

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
                      // Notificartion
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.notifications, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            //search bar
            Container(
              decoration: BoxDecoration(
                color: Color(0xff222327),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Color(0xff5f6064),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Search for salon, services..',
                    style: TextStyle(color: Color(0xff5f6064)),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            //how do you fell?

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                      color: Color(0xff5f6064),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            //4 different faces
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Hairstyle
                Column(
                  children: [
                    Category(
                      categoryFace: '',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Hair style',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),

                //facial

                Column(
                  children: [
                    Category(
                      categoryFace: '',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Hair style',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),

                //Trimming
                Column(
                  children: [
                    Category(
                      categoryFace: '',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Hair style',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),

                Column(
                  children: [
                    Category(
                      categoryFace: '',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Hair style',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),

                //Saving

                //Treatment

                //coloring

                //Appointment type
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular salon nearby',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: Color(0xffbfa58c),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: barberType.length,
                    itemBuilder: (context, index) {
                      return BarberType(
                          barberType: barberType[index][0],
                          isSelected: barberType[index][1],
                          onTap: () {
                            barberTypeSelected(index);
                          });
                    })),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BarberTile(
                    barberImagePath:
                        '/home/clay/Projects/first try/searchBar/searchbar/lib/images/a.jpeg',
                    barberName: 'Sk Yadav',
                    barberPrice: '4.20',
                  ),
                  BarberTile(
                    barberImagePath:
                        '/home/clay/Projects/first try/searchBar/searchbar/lib/images/a.jpeg',
                    barberName: 'Ram Singh',
                    barberPrice: '5.20',
                  ),
                  BarberTile(
                    barberImagePath:
                        '/home/clay/Projects/first try/searchBar/searchbar/lib/images/a.jpeg',
                    barberName: 'Sarthak',
                    barberPrice: '2.20',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
