import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/modules/screens/user_account.dart';
import 'package:hamro_barber_mobile/modules/screens/user_book.dart';
import 'package:hamro_barber_mobile/modules/screens/user_favorite.dart';
import 'package:hamro_barber_mobile/modules/screens/user_home.dart';
import 'package:hamro_barber_mobile/socket/user_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List barberType = [
    ["Hair style", true],
    ["Beard", false],
    ["colouring", false]
  ];

  int _selectedIndex = 0;
  late int customerId;
  Customer customer = Customer();
  late double longitude;
  late double latitude;

  @override
  void initState() {
    getCustomerId();
    loadLocation();
    super.initState();
  }

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _children = [
    const UserHome(),
    UserFavorite(
      customerId: ApiConstants.maxRetryCount,
    ),
    const UserBook(),
    const UserAccount(),
  ];

  void getCustomerId() async {
    int tempid = (await customer.retrieveCustomerId())!;
    setState(() {
      customerId = tempid;
    });
  }

  void loadLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      longitude = prefs.getDouble('longitude') ?? 0;
      latitude = prefs.getDouble('latitude') ?? 0;
      print('DAAAAAAAAAATAAAAAAAAAAAAAA: $longitude');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPage(customerId, longitude, latitude);
                  },
                ),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add, size: 30),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff323345),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _navigateBottomNavBar(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              _selectedIndex == 0 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? Colors.white
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _navigateBottomNavBar(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color:
                              _selectedIndex == 1 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Colors.white
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _navigateBottomNavBar(2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book,
                          color:
                              _selectedIndex == 2 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Book',
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? Colors.white
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _navigateBottomNavBar(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color:
                              _selectedIndex == 3 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Account',
                          style: TextStyle(
                            color: _selectedIndex == 3
                                ? Colors.white
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
