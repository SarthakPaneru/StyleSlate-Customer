import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import '/Screen/detailScreen.dart';
import 'package:http/http.dart' as http;

const stylistData = [
  {
    'stylistName': 'Cameron Jones',
    'salonName': 'Super Cut Salon',
    'rating': '4.8',
    'rateAmount': '56',
    'imgUrl': 'assets/stylist1.png',
    'bgColor': Color(0xffFFF0EB),
  },
  {
    'stylistName': 'Max Robertson',
    'salonName': 'Rossano Ferretti Salon',
    'rating': '4.7',
    'rateAmount': '80',
    'imgUrl': 'assets/stylist2.png',
    'bgColor': Color(0xffEBF6FF),
  },
  {
    'stylistName': 'Beth Watson',
    'salonName': 'Neville Hair and Beauty',
    'rating': '4.7',
    'rateAmount': '70',
    'imgUrl': 'assets/stylist3.png',
    'bgColor': Color(0xffFFF3EB),
  }
];

List<dynamic>? stylistData1;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiRequests _apiRequests = ApiRequests();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    http.Response response = await _apiRequests.getBarbers();
    List<dynamic> jsonResponse = jsonDecode(response.body);
    // String barber = jsonResponse['name'];
    stylistData1 = jsonResponse;
    print(stylistData1);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Hair Stylist',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      StylistCard(stylistData1?[0]),
                      StylistCard(stylistData1?[1])
                      // StylistCard(stylistData1?[2]),
                      // StylistCard(stylistData1?[3]),
                      // StylistCard(stylistData1?[4]),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class StylistCard extends StatelessWidget {
  final stylist;
  StylistCard(this.stylist);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffFFF0EB),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 1,
            right: -60,
            child:
                Image.network('${ApiConstants.baseUrl}${stylist['imageUrl']}',
                width: MediaQuery.of(context).size.width * 0.60,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                // Image loaded successfully
                return child;
              } else {
                // Image is still loading
                return const CircularProgressIndicator();
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  stylist['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  stylist['panNo'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Color(0xff4E295B),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      stylist['rating'].toString(),
                      style: const TextStyle(
                        color: Color(0xff4E295B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(stylist)));
                  },
                  color: const Color(0xff4E295B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
