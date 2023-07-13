import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/modules/screens/user_account.dart';
import 'package:hamro_barber_mobile/modules/screens/user_book.dart';
import 'package:hamro_barber_mobile/modules/screens/user_favorite.dart';
import 'package:hamro_barber_mobile/modules/screens/user_home.dart';
import 'package:hamro_barber_mobile/modules/screens/user_search.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiRequests _apiRequests = ApiRequests();
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

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    Map<String, dynamic> user = jsonResponse['user'];

    Map<String, dynamic> jsonResponse1 = jsonDecode(jsonEncode(user));
    _firstName = jsonResponse1['firstName'];

    print(_firstName);
    setState(() {
      _isLoading = false;
    });
    print(_isLoading);
  }

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
  
  int _selectedIndex = 0;

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    UserHome(),
    UserSearch(),
    UserFavorite(),
    UserBook(),
    UserAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomNavBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xff323345),
        elevation: 10,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
