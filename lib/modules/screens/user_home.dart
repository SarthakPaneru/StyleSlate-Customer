import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/modules/screens/categories_bubble.dart';
import 'package:hamro_barber_mobile/widgets/barberSelection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final Customer _customer = Customer();
  bool _isLoading = true;

  String _firstName = '';
  double longitude = 0;
  double latitude = 0;

  @override
  void initState() {
    super.initState();

    // if (_firstName == null) {
    getLocation();
    getUserDetails();
    loadLocation();
    // }
  }

  void getUserDetails() async {
    final firstName = await _customer.retrieveFirstName();
    _firstName = firstName!;

    print(_firstName);
    setState(() {
      _isLoading = false;
    });
    print(_isLoading);
  }

  final List<String> categories = [
    "Haircut",
    "Hair Style",
    "Beard",
    "Treatment",
    "Beauty Saloon"
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

  void getLocation() async {
    Future.delayed(const Duration(seconds: 2), () {});
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
      print("Latitude: ${position.latitude}");
      print("Longitude: ${position.longitude}");
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('longitude', longitude);
    await prefs.setDouble('latitude', latitude);
    print('longitude stored' + '$longitude');
    print('latitude stored' + '$latitude');
  }

  final _textController = TextEditingController();
  String userPost = '';

  void loadLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      longitude = prefs.getDouble('longitude') ?? 0;
      //fall back value
      latitude = prefs.getDouble('latitude') ?? 0;
    });
  }

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
                          Text(
                            'Your location: $longitude, $latitude',
                            style: const TextStyle(color: Color(0xff616274)),
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
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Row(
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
            ),
            const SizedBox(
              height: 20,
            ),
            // 4 different faces
            Column(
              children: [
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesBubble(
                        text: categories[index],
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 10, top: 5, right: 5),
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
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : BarberSelection(latitude, longitude),
            ),
          ],
        ),
      ),
    );
  }
}
