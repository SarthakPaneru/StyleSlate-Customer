import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/auth/current_user_state.dart';
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
  int _selectedIndex = 0;
  final Customer _customer = Customer();
  int? _customerId;
  double _longitude = 0;
  double _latitude = 0;

  @override
  void initState() {
    super.initState();
    _loadCustomerId();
    _loadLocation();
    context.read<CurrentUserState>().ensureLoaded();
  }

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = const [
    UserHome(),
    UserFavorite(),
    UserBook(),
    UserAccount(),
  ];

  Future<void> _loadCustomerId() async {
    final customerId = await _customer.retrieveCustomerId();
    if (!mounted || customerId == null) return;
    setState(() {
      _customerId = customerId;
    });
  }

  Future<void> _loadLocation() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _longitude = prefs.getDouble('longitude') ?? 0;
      _latitude = prefs.getDouble('latitude') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _children[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _customerId == null
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(_customerId!, _longitude, _latitude),
                  ),
                );
              },
        tooltip: AppStrings.chatTooltip,
        child: const Icon(Icons.chat_bubble_outline),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomNavBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.secondary,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.5),
        backgroundColor: colorScheme.surface,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.navHome),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: AppStrings.navFavorite),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: AppStrings.navBook),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: AppStrings.navAccount),
        ],
      ),
    );
  }
}
