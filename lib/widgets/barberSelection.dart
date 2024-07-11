import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/Screen/detailScreen.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/maps/presentation/pages/my_home_page.dart';
import 'package:http/http.dart' as http;

class BarberSelection extends StatefulWidget {
  final double latitude;
  final double longitude;

  const BarberSelection(this.latitude, this.longitude, {Key? key})
      : super(key: key);

  @override
  State<BarberSelection> createState() => _BarberSelectionState();
}

class _BarberSelectionState extends State<BarberSelection> {
  final ApiRequests _apiRequests = ApiRequests();
  final List<int> _barberIds = [];
  final List<int> _userIds = [];
  final List<String> _names = [];
  final List<double> _distances = [];
  late int _lengthOfResponse;
  bool _isLoading = true;
  bool _isError = false;
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    getBarbers();
  }

  void getImageUrl() {
    for (int i = 0; i < _lengthOfResponse; i++) {
      String image = _apiRequests.retrieveImageUrlFromUserId(_userIds[i]);
      print('Image URL: $image');
      _imageUrls.add(image);
    }
    setState(() {
      _isLoading = false;
      _isError = false;
    });
  }

  Future<void> getBarbers() async {
    try {
      http.Response response = await _apiRequests.getNearestBarber(
          widget.latitude, widget.longitude);
      print(response.body);

      List<dynamic> jsonResponse = jsonDecode(response.body);

      _lengthOfResponse = jsonResponse.length;

      print('Length: $_lengthOfResponse');
      for (int i = 0; i < _lengthOfResponse; i++) {
        getBarber(jsonResponse[i]);
      }
      print('COMPLETED');
      setState(() {
        _lengthOfResponse = jsonResponse.length;
      });
      getImageUrl();
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
      print(e);
    }
  }

  Future<void> getBarber(final response) async {
    Map<String, dynamic> jsonResponseBarber = jsonDecode(jsonEncode(response));
    int id = jsonResponseBarber['id'];
    _barberIds.add(id);
    Map<String, dynamic> user = jsonResponseBarber['user'];
    _userIds.add(user['id']);
    Map<String, dynamic> jsonResponseUser = jsonDecode(jsonEncode(user));
    final barberName =
        '${jsonResponseUser['firstName']} ${jsonResponseUser['lastName']}';
    _names.add(barberName);

    double dist = jsonResponseBarber['distance'];
    _distances.add(dist);

    print(barberName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            )
          : _isError
              ? Center(
                  child: Text("Error fetching data",
                      style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _lengthOfResponse,
                  itemBuilder: (context, index) {
                    if (index >= _lengthOfResponse) {
                      return const Text('No data available',
                          style: TextStyle(color: Colors.white));
                    }
                    return Container(
                      width: 220,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  barberId: _barberIds[index],
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: _imageUrls[index],
                                placeholder: (context, url) => Container(
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.person,
                                      size: 80, color: Colors.grey[400]),
                                ),
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                                errorWidget: (context, url, error) => Container(
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.error,
                                      size: 80, color: Colors.grey[400]),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _names[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 16, color: Colors.red),
                                    SizedBox(width: 5),
                                    Text(
                                      '${_distances[index].toStringAsFixed(2)} km',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  child: Text('See Location'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffbfa58c),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
