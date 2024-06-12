import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/modules/screens/user_account.dart';
import 'package:hamro_barber_mobile/modules/screens/user_book.dart';
import 'package:hamro_barber_mobile/modules/screens/user_favorite.dart';
import 'package:hamro_barber_mobile/modules/screens/user_home.dart';
import 'package:hamro_barber_mobile/modules/screens/user_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  int _selectedIndex = 0;

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    const UserHome(),
    const UserFavorite(),
    const UserBook(),
    const UserAccount(),
  ];

  void _onAddButtonPressed() {
    // Handle the floating action button press here
    print('Floating action button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UserSearch();
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomNavBar,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: const Color(0xff323345),
            elevation: 10,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Account'),
            ],
          ),
        ],
      ),
    );
  }
}
