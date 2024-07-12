import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/modules/screens/searchScreen.dart';
import 'package:hamro_barber_mobile/widgets/barberSelection.dart';
import 'package:hamro_barber_mobile/widgets/carousel.dart';
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
  String _locationName = 'Loading...';

  @override
  void initState() {
    super.initState();
    getLocation();
    getUserDetails();
    loadLocation();
  }

  void getUserDetails() async {
    final firstName = await _customer.retrieveFirstName();
    _firstName = firstName!;
    setState(() {
      _isLoading = false;
    });
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('longitude', longitude);
    await prefs.setDouble('latitude', latitude);

    getAddressFromLatLng(latitude, longitude);
  }

  void getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];
      setState(() {
        _locationName = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void loadLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      longitude = prefs.getDouble('longitude') ?? 0;
      latitude = prefs.getDouble('latitude') ?? 0;
    });
    getAddressFromLatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      body: RefreshIndicator(
        onRefresh: () async {
          getLocation();
          getUserDetails();
          loadLocation();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome, $_firstName",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xffbfa58c),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Color(0xff616274), size: 16),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    _locationName,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Color(0xff616274)),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SearchScreen(),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications,
                                color: Colors.white),
                            onPressed: () {
                              // Handle notifications
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const ImageCarousel(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recommended Barbers',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xffbfa58c)))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: BarberSelection(latitude, longitude),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
