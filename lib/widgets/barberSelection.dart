import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Your App'),
      // ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
            child: BarberSelection(),
          ),
        ],
      ),
    );
  }
}

class BarberSelection extends StatelessWidget {
  final List<String> barbershop = [
    "Sk Hairstyle",
    "Ramon Hairstyle",
    "Hamro Barber",
    "Hamro shaloon",
    "Unique Hairstyle",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbershop.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 150,
                width: 150,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'lib/assets/images/categories/categories$index.jpg',
                              fit: BoxFit.fitHeight,
                              height: 110,
                            ),
                          
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      barbershop[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
