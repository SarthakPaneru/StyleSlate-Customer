import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/modules/screens/categories_bubble.dart';
import 'package:hamro_barber_mobile/widgets/barberSelection.dart';
import 'package:http/http.dart' as http;

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final ApiRequests _apiRequests = ApiRequests();
  final Customer _customer = Customer();
  bool _isLoading = true;

  String _firstName = '';

  @override
  void initState() {
    super.initState();

    // if (_firstName == null) {
    getUserDetails();
    // }
  }

  void getUserDetails() async {
    http.Response response = await _apiRequests.getLoggedInUser();

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    _customer.storeCustomerDetails(jsonResponse);

    Map<String, dynamic> user = jsonResponse['user'];

    Map<String, dynamic> jsonResponse1 = jsonDecode(jsonEncode(user));
    _firstName = jsonResponse1['firstName'];

    print(_firstName);
    setState(() {
      _isLoading = false;
    });
    print(_isLoading);
  }

  final List<String> categories = [
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
      backgroundColor: const Color(0xff323345),
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
                            "Hi, $_firstName",
                            style: const TextStyle(
                              color: Color(0xffbfa58c),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
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
                        padding: const EdgeInsets.all(12),
                        child: const Icon(Icons.notifications,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
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
                        decoration: const InputDecoration(
                          hintText: 'Find Your Barber',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Clear the text that is typed
                        _textController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
            ),
            // how do you feel?
            const Row(
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
            const SizedBox(
              height: 20,
            ),
            // 4 different faces
            Column(
              children: [
                Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesBubble(text: categories[index]);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            const Padding(
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
            const SizedBox(height: 5),
            Expanded(
              child: BarberSelection(),
            ),
          ],
        ),
      ),
    );
  }
}
