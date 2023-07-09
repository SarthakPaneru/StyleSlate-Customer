import 'package:flutter/material.dart';
import 'package:heart_toggle/heart_toggle.dart';

var serviceList = [
  {'title': 'Men\s Hair Cut', 'duration': 45, 'price': 30},
  {'title': 'Women\s Hair Cut', 'duration': 60, 'price': 50},
  {'title': 'Color & Blow Dry', 'duration': 90, 'price': 75},
  {'title': 'Oil Treatment', 'duration': 30, 'price': 20},
];

class DetailScreen extends StatelessWidget {
  final stylist;

  DetailScreen(this.stylist);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3 + 10,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'assets/detail_bg.png',
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.purple.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 140,
                        ),
                        const Text(
                          'Service List',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ServiceTile(serviceList[0]),
                        ServiceTile(serviceList[1]),
                        ServiceTile(serviceList[2]),
                        ServiceTile(serviceList[3]),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 90,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        height: MediaQuery.of(context).size.height / 6 + 20,
                        decoration: BoxDecoration(
                          color: stylist['bgColor'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Positioned(
                              top: 5,
                              right: -25,
                              child: Image.asset(
                                stylist['imgUrl'],
                                scale: 1.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            stylist['stylistName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            stylist['salonName'],
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xffFF8573),
                              ),
                              SizedBox(width: 5),
                              Text(
                                stylist['rating'],
                                style: TextStyle(
                                  color: Color(0xffFF8573),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${stylist['rateAmount']})',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: MediaQuery.of(context).size.height / 3 - 55,
                child: MaterialButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(10),
                    child: HeartToggle(
                      props: HeartToggleProps(
                        size: 35.0,
                        passiveFillColor: Colors.grey[200]!,
                        ballElevation: 4.0,
                        heartElevation: 4.0,
                        ballColor: Colors.white,
                        onChanged: (toggled) => {},
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final service;
  ServiceTile(this.service);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: Text(
                  service['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${service['duration']} Min',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            '\$${service['price']}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          MaterialButton(
            onPressed: () {},
            color: Color(0xffFF8573),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Book',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
