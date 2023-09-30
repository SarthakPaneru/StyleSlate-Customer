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

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height -
//                 kToolbarHeight -
//                 MediaQuery.of(context).padding.top,
//             child: BarberSelection(),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  String _imageUrl = '';

  // bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageUrl();
    getBarbers();
  }

  Future<void> getImageUrl() async {
    String image = await _apiRequests.retrieveImageUrl();
    setState(() {
      _imageUrl = image;
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
      print("HERE 1");

      _lengthOfResponse = jsonResponse.length;
      print('Length: $_lengthOfResponse');
      for (int i = 0; i < _lengthOfResponse; i++) {
        getBarber(jsonResponse[i]);
      }
      print('COMPLETED');
      setState(() {
        _lengthOfResponse = jsonResponse.length;
        print(_lengthOfResponse);
        print(_barberIds[0]);
        print(_distances[0]);
        print(_names[0]);
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getBarber(final response) async {
    Map<String, dynamic> jsonResponseBarber = jsonDecode(jsonEncode(response));
    int id = jsonResponseBarber['id'];
    _barberIds.add(id);
    Map<String, dynamic> user = jsonResponseBarber['user'];
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
                                builder: (context) =>
                                    DetailScreen(_barberIds[index]),
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
                                  imageUrl: '${_imageUrl}',
                                  placeholder: (context, url) => const Icon(
                                    Icons.person,
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
