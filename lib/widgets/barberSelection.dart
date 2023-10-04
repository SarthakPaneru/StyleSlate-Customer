import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/Screen/appointment.dart';
import 'package:hamro_barber_mobile/Screen/booking%20page.dart';
import 'package:hamro_barber_mobile/Screen/detailScreen.dart';
import 'package:hamro_barber_mobile/Screen/homescreen.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/modules/models/barber.dart';
import 'package:http/http.dart' as http;

class BarberSelection extends StatefulWidget {
  final double latitude;
  final double longitude;

  const BarberSelection(this.latitude, this.longitude, {super.key});

  @override
  State<BarberSelection> createState() => _BarberSelectionState();
}

class _BarberSelectionState extends State<BarberSelection> {
  final ApiRequests _apiRequests = ApiRequests();
  // List<Barber> barbershop = List.empty(growable: true);
  List<int> _barberIds = List.empty(growable: true);
  List<int> _userIds = List.empty(growable: true);
  List<String> _names = List.empty(growable: true);
  List<double> _distances = List.empty(growable: true);
  late int _lengthOfResponse;
  bool _isLoading = true;
  List<String> _imageUrls = List.empty(growable: true);

  // bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBarbers();
    // getImageUrl();
  }

  void getImageUrl() {
    for (int i = 0; i < _lengthOfResponse; i++) {
      String image = _apiRequests.retrieveImageUrlFromUserId(_userIds[i]);
      print('Image URL: $image');
      _imageUrls.add(image);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getBarbers() async {
    try {
      // await Future.delayed(Duration(seconds: 2));

      await _apiRequests.getNearestBarber(widget.latitude, widget.longitude);
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
        // _isLoading = false;
      });
      getImageUrl();
    } catch (e) {
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
    // final d = jsonDecode(jsonEncode(dist));

    _distances.add(dist);

    print(barberName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323345),
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 200, // Adjust this height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _lengthOfResponse,
                  itemBuilder: (context, index) {
                    if (index >= _lengthOfResponse) {
                      return Text('No data available');
                    }
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
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
                            child: FittedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: CachedNetworkImage(
                                  imageUrl: _imageUrls[index],
                                  placeholder: (context, url) => const Icon(
                                    Icons.person,
                                    size: 80,
                                  ),
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons
                                        .person, // You can use any widget as the error placeholder
                                    size: 80,
                                    
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${_names[index]}',
                            style: TextStyle(color: Colors.yellow),
                          ),
                          Text(
                            'km : ${_distances[index]}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
